# function for plotting raw vs. adjusted EPA/Play 

plot_raw_vs_adj <- function(df){
  
  # plot raw vs. adjusted offense AND defense
  
  # setup ####
  require(tidyverse)
  require(magick)
  require(ggimage)
  require(ggthemes)
  
  # transparent function 
  transparent <- function(img) {
    magick::image_fx(img, expression = "0.3*a", channel = "alpha")
  }
  
  # plot ####
  df %>%
    inner_join(logos, by = c("team" = "team_abbr")) %>% #get logos for plotting
    
    ggplot() +
    
    geom_abline(slope = -1, intercept = c(.3, .2, .1, 0, -.1, -.2), alpha = .5) + # grey lines
    
    geom_hline(aes(yintercept = mean(rawOff)), color = "red", linetype = "dashed") + # horizontal line
    geom_vline(aes(xintercept = mean(adjOff)), color = "red", linetype = "dashed") + # vertical line
    
    geom_image(aes(x = rawOff, y = rawDef, image = team_logo_espn), size = 0.05, asp = 2/1, image_fun = transparent) + # raw values
    geom_image(aes(x = adjOff, y = adjDef, image = team_logo_espn), size = 0.05, asp = 2/1) + # adj values
    
    labs(
      x = "Offensive EPA/play",
      y = "Defensive EPA/play",
      caption = "By @henrygise | Data: @nflfastR",
      title = "2021 NFL Opponent-Adjusted Offense and Defense",
      subtitle = "") +
    
    theme_fivethirtyeight() +
    
    theme(plot.title = element_text(size = 24, face = "bold"),
          plot.subtitle = element_text(size = 16),
          plot.caption = element_text(size = 12),
          axis.title = element_text(size = 16, face = "bold"),
          axis.text = element_text(size = 12),
          legend.position = "none") +
    
    scale_y_reverse() # reverse scale for defensive axis
}
