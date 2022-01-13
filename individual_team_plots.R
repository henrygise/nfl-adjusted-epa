# plotting weekly epa over expected for individual teams

# getting data for all nfl teams (need nfl_team_adj_epa())
df_all_teams <- nfl_team_adj_epa(2021, logos$team_abbr[! logos$team_abbr %in% c("LAR", "OAK", "SD", "STL")])

# plot team week-by-week epa over expected (offensive)

plot_ind_team_off <- function(plot_team){
  
  # transparent function
  transparent <- function(img) {
    magick::image_fx(img, expression = "0.7*a", channel = "alpha")
  }
  
  # setup ####
  require(ggplot2)
  require(ggforce)
  require(ggimage)
  require(ggforce)
  
  df <- df_all_teams[c(1:9)] %>% filter(team == plot_team & week > 0) %>%
    left_join(logos, by = c("opp" = "team_abbr"))
  
  # plot ####
  ggplot() +
    # plot bad performances
    geom_link(data =  df %>% filter(over_expected_off < 0),
              aes(x = week, xend = week, y = opp_adj_off, yend = epa_off,
                  alpha = stat(index), size = stat(index)), color = "#FF2700") +
    
    # plot good performances
    geom_link(data =  df %>% filter(over_expected_off >= 0),
              aes(x = week, xend = week, y = opp_adj_off, yend = epa_off,
                  alpha = stat(index), size = stat(index)), color = "#77AB43") +
    
    # plot team logos
    geom_image(data = df, aes(x = week, y = opp_adj_off, image = team_logo_espn), image_fun = transparent, asp = 16/9) +
    
    scale_x_continuous(breaks = seq(1,18)) +
    scale_y_continuous(limits = c(-0.75, 0.75)) +
    
    labs(title = paste0(plot_team, " Offensive EPA/Play Over Expected"),
         subtitle = "Using Opponent Adjusted EPA, 2021 NFL Season",
         caption = "By @henrygise | Data: @nflfastR",
         x = "Week",
         y = "EPA Over Expected") +
    
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
# plot team week-by-week epa over expected (defensive)
plot_ind_team_def <- function(plot_team){
  
  # transparent function
  transparent <- function(img) {
    magick::image_fx(img, expression = "0.7*a", channel = "alpha")
  }
  
  # setup ####
  require(ggplot2)
  require(ggforce)
  require(ggimage)
  require(ggforce)
  
  df <- df_all_teams[c(1:9)] %>% filter(team == plot_team & week > 0) %>%
    left_join(logos, by = c("opp" = "team_abbr"))
  
  # plot ####
  ggplot() +
    # plot bad performances
    geom_link(data =  df %>% filter(over_expected_def > 0),
              aes(x = week, xend = week, y = opp_adj_def, yend = epa_def,
                  alpha = stat(index), size = stat(index)), color = "#FF2700") +
    
    # plot good performances
    geom_link(data =  df %>% filter(over_expected_def <= 0),
              aes(x = week, xend = week, y = opp_adj_def, yend = epa_def,
                  alpha = stat(index), size = stat(index)), color = "#77AB43") +
    
    # plot team logos
    geom_image(data = df, aes(x = week, y = opp_adj_def, image = team_logo_espn), image_fun = transparent, asp = 16/9) +
    
    scale_x_continuous(breaks = seq(1,18)) +
    scale_y_reverse(limits = c(0.75, -0.75)) +
    
    labs(title = paste0(plot_team, " Defensive EPA/Play Over Expected"),
         subtitle = "Using Opponent Adjusted EPA, 2021 NFL Season",
         caption = "By @henrygise | Data: @nflfastR",
         x = "Week",
         y = "EPA Over Expected") +
    
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
