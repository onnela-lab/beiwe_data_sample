## Imports ----
library(ggmap)
library(tidyverse)

## Helper functions ----
bash_merge <- function(folder, awk = TRUE, joined_file = "0000-merged.csv") {
    # Uses bash `awk` or `cat` to merge files. 
    # In general, faster than looping `fread()` for `read_csv`. 
    # Note: `cat` doesn't work if there is a header row.
    original_wd <- getwd()
    setwd(folder)
    if (awk){
        system(paste0("awk 'FNR==1 && NR!=1{next;}{print}' *.csv > ", 
                      joined_file))
    } else {
        system(paste0("cat *.csv > ", joined_file))
    }
    setwd(original_wd)
}

## Merge all gps files within each user ----
for (f in list.dirs('./data', recursive = FALSE)) {
    bash_merge(paste0(f, "/gps"))
}

## Now import all five merged files ----
all_gps <- NULL
for (f in list.files("./", recursive = TRUE, pattern = "0000-merged.csv")) {
    all_gps <- rbind(all_gps, read_csv(f))
}


## Make a dataframe of just datetime components for each observation
dt_gps <- all_gps %>% 
    rename(dt = `UTC time`) %>% 
    mutate(dt = dt - hours(7)) %>% 
    select(dt) %>% 
    mutate(wday = wday(dt), 
           hour = hour(dt), 
           date = date(dt), 
           doy  = yday(dt))

## Calculate number of observations per hour
hour_gps <- dt_gps %>% 
    group_by(date, doy, hour) %>% 
    summarize(obs = n()) 

hour_heatmap <- ggplot(hour_gps, aes(date, hour, fill = log10(obs))) + 
    geom_tile(color = "white") + 
    scale_fill_distiller("Observations", palette = "Spectral", direction = -1, 
                         na.value = "white", 
                         breaks = log10(c(min(hour_gps$obs), 100, 1000, 
                                          max(hour_gps$obs))), 
                         labels = c(min(hour_gps$obs), 100, 1000, 
                                    max(hour_gps$obs)), 
                         guide = guide_colorbar(title.position = "top", 
                                                barwidth = 12, 
                                                barheight = .5)) + 
    coord_equal() + 
    scale_y_continuous(NULL, breaks = c(0, 6, 12, 18, 23), 
                       labels = c("12am", "6am", "12pm", "6pm", "11pm"), 
                       expand = c(0, 0)) + 
    scale_x_date(NULL, expand = c(0, 0)) + 
    theme_classic() + 
    theme(axis.text.y = element_text(vjust = 1), 
          axis.line = element_blank(), 
          axis.ticks = element_blank(), 
          legend.position = "bottom")
ggsave(filename = "./plots/hourly_heatmap.pdf", 
       hour_heatmap, width = 6, height = 2, scale = 2)
ggsave(filename = "./plots/hourly_heatmap.jpg", dpi = 200, 
       hour_heatmap, width = 6, height = 2, scale = 2)
