# function for using ridge regression for calculate opponent-adjusted EPA for a given season

nfl_adj_epa_noHFA <- function(season){
  
  # in this case, we do not control for homefield advantage (HFA) because it is included in the EPA model
  
  # setup ####
  require(tidyverse)
  require(nflfastR)
  require(glmnet)
  require(ggimage)
  require(fastDummies)
  
  # logos
  logos <- nflfastR::teams_colors_logos
  
  # get and clean pbp data ####
  
  # load
  dfPBP <- nflfastR::load_pbp(season)
  
  # filter NAs
  dfPBP <- dfPBP %>%
    filter(!is.na(epa))
  
  # filter play_type to be either pass or run
  dfPBP <- dfPBP %>%
    filter(play_type %in% c("pass", "run"))
  
  # filter wp
  dfPBP <- dfPBP %>%
    filter(wp > 0.2 & wp < 0.8)
  
  # clean and create df that includes offense, defense, and EPA
  df <- dfPBP %>% 
    select(posteam, defteam, epa) %>%
    as.data.frame()
  
  # create dummy columns for posteam and defteam
  dfDummies <- df %>% dummy_cols(select_columns = c("posteam", "defteam")) %>% select(-posteam, -defteam)
  
  # opponent adjustment ####
  x_matrix <- data.matrix(dfDummies %>% select(-epa)) # make x values
  y_matrix <- data.matrix(dfDummies %>% select(epa) %>% mutate(epa = as.numeric(epa))) # make y values
  lambda_seq <- 10^seq(2, -2, by = -.1) # set range of lambdas
  
  ridge_cv <- cv.glmnet(x_matrix, y_matrix, alpha = 0, lambda = lambda_seq) # cross validation for finding optimal lambda
  best_lambda <- ridge_cv$lambda.min # get lambda value that offers minimum MSE
  
  best_ridge <- glmnet(x_matrix, y_matrix, alpha = 0, lambda = best_lambda, intercept = TRUE) # build final model
  
  # create final df ####
  df_final <- as.data.frame(as.matrix(coef(best_ridge))) %>%
    # bring team row names into its own column
    rownames_to_column("team") %>%
    # filter out intercept column
    filter(team != "(Intercept)") %>%
    # add intercept to get final adjusted values
    mutate(adjEPA = s0 + best_ridge$a0) %>% select(-s0) %>%
    # create team and side columns
    mutate(
      new_team = ifelse(str_detect(team,"posteam_"), str_remove(team,"posteam_"), str_remove(team,"defteam_")),
      side = ifelse(str_detect(team,"posteam_"),"adjOff","adjDef")) %>%
    mutate(team = new_team) %>% select(-new_team) %>%
    # give each team one individual row
    pivot_wider(id_cols = team, names_from = side, values_from = adjEPA) %>%
    # join rawOff
    left_join(dfPBP %>% select(posteam, epa) %>%
                group_by(posteam) %>%
                rename(team = posteam) %>%
                summarise(rawOff = mean(as.numeric(epa)))) %>%
    # join rawDef
    left_join(dfPBP %>% select(defteam, epa) %>%
                group_by(defteam) %>%
                rename(team = defteam) %>%
                summarise(rawDef = mean(as.numeric(epa)))) %>%
    # scaling adjusted values to standard deviation of raw values
    mutate(adjOff = (adjOff - mean(adjOff)) / sd(adjOff) * sd(rawOff) +  mean(adjOff),
           adjDef = (adjDef - mean(adjDef)) / sd(adjDef) * sd(rawDef) +  mean(adjDef))
}
