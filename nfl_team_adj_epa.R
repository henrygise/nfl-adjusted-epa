# function for getting EPA over expected per game for specified team(s)

nfl_team_adj_epa <- function(season, teams){
  
  # setup ####
  require(tidyverse)
  require(nflfastR)
  require(glmnet)
  require(ggimage)
  require(fastDummies)
  
  # logos
  logos <- nflfastR::teams_colors_logos
  
  # get list of team EPA adjustments for season
  df_season <- nfl_adj_epa_noHFA(season)
  
  # initial data frame
  df_epa <- data.frame()
  
  # get data ####
  
  for (team in teams){
    
    # individual team schedule
    df_games <- nflfastR::fast_scraper_schedules(season) %>%
      filter(away_team == team | home_team == team)
    
    # get pbp data for given team for given season
    df_pbp <- nflfastR::load_pbp(seasons = season) %>%
      filter(
        # only the team's games
        game_id %in% df_games$game_id,
        # passes and runs
        play_type %in% c("pass", "run"),
        # only plays with epa listed
        !is.na(epa),
        # wp filter
        wp > 0.2 | wp < 0.8)
    
    # get individual epa_play performances ####
    df_epa <- df_epa %>%
      rbind(
        df_pbp %>%
          # team column
          mutate(team = team) %>%
          # denoting opponent
          mutate(opp = ifelse(home_team == team, away_team, home_team)) %>%
          # summarising each game/side by its epa/play
          group_by(team, week, opp, posteam, defteam) %>%
          summarise(epa = mean(epa)) %>%
          # joining adjusted epa data
          left_join(df_season %>% select(team, adjOff, adjDef), by = c("opp" = "team")) %>%
          # get opponent's adjustments
          mutate(opp_adj = ifelse(posteam == team, adjDef, adjOff)) %>%
          # computing over_expected values
          mutate(over_expected = epa - opp_adj) %>%
          # denoting side
          mutate(side = ifelse(posteam == team, "off", "def")) %>%
          ungroup() %>%
          select(week, team, opp, side, epa, opp_adj, over_expected) %>%
          # pivoting to widen offense and defense
          pivot_wider(id_cols = c(week, team, opp), names_from = side, values_from = c(epa, opp_adj, over_expected)) %>%
          full_join(data.frame(
            week = 0,
            team = team,
            opp = team)) %>% arrange(week) %>%
          left_join(logos, by = c("team" = "team_abbr")))
    
    # note: the resulting column opp_adj_off denotes the opponent's adjusted EPA/Play when the specified team is on offense
    
    df_epa[,c(4:9)][is.na(df_epa[,c(4:9)])] <- 0
  }
  
  return(df_epa)
}
