## split_original_data.R
## 
## This script takes the original data of a single user and splits it up into
## N_USERS. For files with very little data (less than NUM_OBS), the data are
## repeated across all users. For files with more than NUM_OBS data, the data
## are randomly sampled (without replacement) across users. 

## Imports
library(tidyverse)
library(foreach)

## Config
cfig     <- config::get()
n_users  <- cfig$n_users
base_dir <- cfig$split_data
orig_dir <- cfig$original_data
min_obs  <- cfig$min_obs

## Study dataframe -- for every study, we want (1) the location of the 
## original files, (2) seeds to generate fake user IDs, (3) resulting 
## reproducible list of random fake user IDs
study_df  <- data_frame(study_path = list.dirs('./original_data/', 
                                               recursive = FALSE)) %>% 
    mutate(study_seed = as.numeric(gsub("[^0-9]", "", x = study_path)), 
           user_ids = NA)

for (i in 1:nrow(study_df)) {
    set.seed(study_df$study_seed[i])
    study_df$user_ids[i] <- list(replicate(n_users, 
                                      paste(sample(c(0:9, letters), 8), 
                                            collapse = "")))
}


## Helper -- foreach requires a wrapper function
divide_csv_file <- function(i, study_files) {
    ## Extract current file string for later
    curr_file <- study_files[i]
    print(curr_file)
    
    ## Set a seed, import data, randomly assign users
    set.seed(i)
    temp_df <- read_csv(curr_file) %>% 
        mutate(user = sample(USER_IDS, n(), replace = TRUE))
    
    ## Loop through users and save each file
    for (u in USER_IDS) {
        ## Create target folder
        user_dir <- gsub(pattern = ORIG_DIR, 
                         replacement = sprintf("%s/%s", BASE_DIR, u), 
                         x = strsplit(curr_file, "2016", fixed = TRUE)[[1]][1])
        dir.create(user_dir, recursive = TRUE, showWarnings = FALSE)
        
        if (nrow(temp_df) < NUM_OBS) {
            write_df <- temp_df %>% 
                select(-user)
        } else {
            write_df <- temp_df %>% 
                filter(user == u) %>% 
                select(-user)
        }
        write.csv(write_df, row.names = FALSE, 
                  file = sprintf(gsub(ORIG_DIR, sprintf("%s/%s", BASE_DIR, u), 
                                      curr_file)))
    }
}

## Now loop through all files -- if more than 50 lines, split randomly and
## write one new file per fake USER_IDS. If less than 50 lines, save a copy
## of identical files for each fake USER_IDS. 
all_files <- list.files(ORIG_DIR, full.names = TRUE, recursive = TRUE)

## Set cores = 1 if you do not want to do this in parallel
doParallel::registerDoParallel(cores = 6)
getDoParWorkers()   ## Check the number of workers you're using

foreach(i=seq_along(all_files), .combine = 'c', .inorder = FALSE) %dopar% {
    divide_csv_file(i, all_files)
}