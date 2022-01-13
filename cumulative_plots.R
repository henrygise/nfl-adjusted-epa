# these are functions for plotting cumulative epa over expected (offense and defense)

# function for charting one team (offense)
plot_playoff_team_off <- function(plot_team){
  
  # setup ####
  require(ggplot2)
  require(ggthemes)
  require(magick)
  
  # vector of teams to be included in plot
  #playoff_teams <- c("LV", "CIN", "NE", "BUF", "TEN", "KC", "PIT", "DAL", "SF", "PHI", "TB", "GB", "LA", "ARI")
  
  # get epa_oe data for each game for each specified team
  #df_playoff <- nfl_team_adj_epa(2021, playoff_teams)
  
  # new vector of all teams not including plot_team (line to be highlighted)
  team_vector <- playoff_teams[playoff_teams != plot_team]
  
  # logos
  logos <- nflfastR::teams_colors_logos
  
  # data frame with all opponents
  opp_df <- df_playoff[1:9] %>%
    filter(team == plot_team) %>%
    mutate(over_expected_off = cumsum(over_expected_off)) %>%
    left_join(logos, by = c("opp" = "team_abbr"))
  
  weeks <- opp_df$week
  
  # plot ####
  ggplot(mapping = aes(x = week, y = over_expected_off)) +
    
    # for team colors
    scale_color_identity(aesthetics = "color") +
    
    # line at zero
    geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
    
    # plot lines on all points for specific team
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[1]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[2]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[3]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[4]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[5]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[6]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[7]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[8]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[9]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[10]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[11]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[12]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == team_vector[13]),
              color = "grey", size = 2, alpha = 0.3) +
    
    # plot line on all points for specific team
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == plot_team),
              mapping = aes(color = team_color), size = 2, alpha = 1) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_off = cumsum(over_expected_off)) %>% filter(team == plot_team),
              mapping = aes(color = team_color2), size = 1, alpha = 1) +
    
    # plot logos across weeks for each game
    geom_image(data = opp_df %>% filter(week == weeks[1]), mapping = aes(x = 1.5, y = 1.5, image = team_logo_espn), size = 0.1, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[2]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[3]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[4]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[5]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[6]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[7]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[8]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[9]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[10]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[11]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[12]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[13]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[14]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[15]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[16]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[17]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[18]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    
    scale_x_continuous(breaks = seq(1,18)) +
    
    labs(title = paste0(plot_team," Cumulative Offensive EPA/Play Over Expected"),
         subtitle = "Using Opponent Adjusted EPA, 2021 NFL Season",
         caption = "By @henrygise | Data: @nflfastR",
         x = "Week",
         y = "Total EPA/Play Over Expected") +
    
    theme_fivethirtyeight() +
    
    theme(plot.title = element_text(size = 24, face = "bold"),
          plot.subtitle = element_text(size = 16),
          plot.caption = element_text(size = 12),
          axis.title = element_text(size = 16, face = "bold"),
          axis.text = element_text(size = 12),
          legend.position = "none",
          panel.grid.major.x = element_blank(),
          aspect.ratio = 9/16)
}
# function for charting one team (offense)
plot_playoff_team_def <- function(plot_team){
  
  # setup ####
  require(ggplot2)
  require(ggthemes)
  require(magick)
  
  # vector of teams to be included in plot
  #playoff_teams <- c("LV", "CIN", "NE", "BUF", "TEN", "KC", "PIT", "DAL", "SF", "PHI", "TB", "GB", "LA", "ARI")
  
  # get epa_oe data for each game for each specified team
  #df_playoff <- nfl_team_adj_epa(2021, playoff_teams)
  
  # new vector of all teams not including plot_team
  team_vector <- playoff_teams[playoff_teams != plot_team]
  
  # logos
  logos <- nflfastR::teams_colors_logos
  
  # data frame with all opponents
  opp_df <- df_playoff[1:9] %>%
    filter(team == plot_team) %>%
    mutate(over_expected_def = cumsum(over_expected_def)) %>%
    left_join(logos, by = c("opp" = "team_abbr"))
  
  weeks <- opp_df$week
  
  # plot ####
  ggplot(mapping = aes(x = week, y = over_expected_def)) +
    
    # for team colors
    scale_color_identity(aesthetics = "color") +
    
    # line at zero
    geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
    
    # plot lines on all points for specific team
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[1]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[2]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[3]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[4]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[5]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[6]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[7]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[8]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[9]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[10]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[11]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[12]),
              color = "grey", size = 2, alpha = 0.3) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == team_vector[13]),
              color = "grey", size = 2, alpha = 0.3) +
    
    # plot line on all points for specific team
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == plot_team),
              mapping = aes(color = team_color), size = 2, alpha = 1) +
    geom_line(data = df_playoff %>% group_by(team) %>% mutate(over_expected_def = cumsum(over_expected_def)) %>% filter(team == plot_team),
              mapping = aes(color = team_color2), size = 1, alpha = 1) +
    
    # plot logos across weeks for each game
    geom_image(data = opp_df %>% filter(week == weeks[1]), mapping = aes(x = 1.5, y = -1.5, image = team_logo_espn), size = 0.1, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[2]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[3]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[4]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[5]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[6]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[7]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[8]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[9]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[10]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[11]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[12]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[13]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[14]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[15]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[16]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[17]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    geom_image(data = opp_df %>% filter(week == weeks[18]), mapping = aes(image = team_logo_espn), size = 0.03, asp = 16/9) +
    
    scale_x_continuous(breaks = seq(1,18)) +
    scale_y_reverse() +
    
    labs(title = paste0(plot_team," Cumulative EPA/Play Over Expected (Defense)"),
         subtitle = "Using Opponent Adjusted EPA, 2021 NFL Season",
         caption = "By @henrygise | Data: @nflfastR",
         x = "Week",
         y = "Total EPA/Play Over Expected") +
    
    theme_fivethirtyeight() +
    
    theme(plot.title = element_text(size = 24, face = "bold"),
          plot.subtitle = element_text(size = 16),
          plot.caption = element_text(size = 12),
          axis.title = element_text(size = 16, face = "bold"),
          axis.text = element_text(size = 12),
          legend.position = "none",
          panel.grid.major.x = element_blank(),
          aspect.ratio = 9/16)
}
