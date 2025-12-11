library(tidyverse)

library(readr)
library(stringr)


#####format


# Example operation schedule read from file ##
# Define the directory where files will be saved
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic")
output_directory <- "C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic"
list_of_files <- list.files(output_directory ,pattern = ".mgt$")
# 


# Loop through the list of files
for (i in seq_along(list_of_files)) {
  # Construct full file path
  file_path <- file.path(getwd(), list_of_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "PINE" in any line
  if (any(grepl("ESC", file_content))) {
    
    ##change ESC for PINE
    file_content <- gsub("ESC", "PINE", file_content)
    # Find the line index for "Management Operations:"
    management_start <- grep("Operation Schedule:", file_content)
    operation_schedule<-file_content[(management_start + 1):length(file_content)]
    
     # If found, replace that line with the replacement chunk
    if (length(management_start) > 0) {
      # Use the new function to modify the file content
      ## here modify the operation schedule 
      years_data <- split_lines_into_years(operation_schedule)
      result <- map2_df(years_data, seq_along(years_data), ~ has_planting_operations(.x, .y))
      # Define target years
      target_years <- c(5, 10, 15)
   
      # Identify the year(s) with planting operations from the 'result' dataframe
      planting_years <- result %>% filter(PlantingCount > 0) %>% pull(Year)
      
      # Randomly select a target year
      selected_years <- sample(target_years,  length(planting_years))
      result_years_data <- swap_planting_years(years_data_toshift, planting_years, selected_years)
      #browser()
      ##then weite the output file
      modified_content <- replace_and_truncate(file_content, result_years_data, (management_start[1]+1))  # Only replace the first occurrence
      modified_content <- unlist(modified_content) 
    }  
       # Now, update the BIO_INIT value
      # Identify the line that contains "1000.00    | BIO_INIT: Initial biomass"
      target_line_index1 <- grep("         1000.00    | BIO_INIT: Initial biomass", modified_content)
      #browser()
      
      ## now 
      ## grep line with  "         1000.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)"
      #and just before it rewrite 1000.00 given selected_years. If selected years[[1]] is 2, then 1000.00 should be replaced with 17000.00
      # if it is 3, then 15000.00, if it is 5 then 70000.00,it is 10 then 70000.00
      
      # Replace the value based on selected_years[[1]]
      if (length(target_line_index1) > 0) {
        # Find the line just before the target line
        replacement_value <- switch(as.character(selected_years[[1]]), #5,10,8,15
                                    "5" ="       170000.00    | BIO_INIT: Initial biomass",
                                    "10" = "        90000.00    | BIO_INIT: Initial biomass",
                                    "15" = "       150000.00    | BIO_INIT: Initial biomass",
                                    "         1000.00    | BIO_INIT: Initial biomass")  # Default if no match
        
        # Replace the value in the target line
        modified_content[target_line_index1] <- replacement_value
        
        ###### change planitng BIOINI
        # Identify the line that contains "1000.00    | BIO_INIT: Initial biomass"
        # target_line_index2 <- grep("  1  2           1   94      1   1800.00000   2.50   200.00000 0.00   0.00  0.00", modified_content)
        # #browser()
      }
  
      target_line_index2 <- grep("^\\s+0\\s+\\| IGRO: Land cover status: 0-none growing; 1-growing$", modified_content)
      
      #browser()
      
      ## now 
      ## grep line with  "         1000.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)"
      #and just before it rewrite 1000.00 given selected_years. If selected years[[1]] is 2, then 1000.00 should be replaced with 17000.00
      # if it is 3, then 15000.00, if it is 5 then 70000.00,it is 10 then 70000.00
      
      # Replace the value based on selected_years[[1]]
      if (length(target_line_index2) > 0) {
        # Find the line just before the target line
        replacement_value <- switch(as.character(selected_years[[1]]), #5,10,8,15
                                    "5" ="               1    | IGRO: Land cover status: 0-none growing; 1-growing",
                                    "10" = "               1    | IGRO: Land cover status: 0-none growing; 1-growing",
                                    "15" = "               1    | IGRO: Land cover status: 0-none growing; 1-growing",
                                    "               0    | IGRO: Land cover status: 0-none growing; 1-growing")  # Default if no match
        
        modified_content[target_line_index2] <- replacement_value
        
        ###### change planitng BIOINI
        # Identify the line that contains "1000.00    | BIO_INIT: Initial biomass"
       
      }
      
      target_line_index4 <- grep("^\\s+0\\s+\\| PLANT_ID: Land cover ID number \\(IGRO = 1\\)$", modified_content)
      
      #browser()
      
      ## now 
      ## grep line with  "         1000.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)"
      #and just before it rewrite 1000.00 given selected_years. If selected years[[1]] is 2, then 1000.00 should be replaced with 17000.00
      # if it is 3, then 15000.00, if it is 5 then 70000.00,it is 10 then 70000.00
      
      # Replace the value based on selected_years[[1]]
      if (length(target_line_index4) > 0) {
        # Find the line just before the target line
        sampled_number <- 1
        
        # Define the replacement value based on the sampled number
        replacement_value <- case_when(
          sampled_number == 1 ~ "              94    | PLANT_ID: Land cover ID number (IGRO = 1)")
        
        modified_content[target_line_index4] <- replacement_value
        
        ###### change planitng BIOINI
        # Identify the line that contains "1000.00    | BIO_INIT: Initial biomass"
      }
      
      target_line_index3 <- grep("  1  2           1   94      1   1800.00000   2.50   200.00000 0.00   0.00  0.00", modified_content)
      #browser()
      
      # Replace the value based on selected_years[[1]]
      if (length(target_line_index3) > 0) {
        # Sample a number with specified probabilities
        sampled_number <- 1
        
        # Define the replacement value based on the sampled number
        replacement_value <- case_when(
          sampled_number == 1 ~ "  1  2           1   94      1   1800.00000   2.50   10000.00000 0.00   0.00  0.00")
        # Replace the value in the target line
        modified_content[target_line_index3] <- replacement_value
      }
      # Write the modified file to the output directory
      write_lines(modified_content, file.path(output_directory, paste0('mod_', list_of_files[i])))
      
      cat("Modified and saved:", file.path(output_directory, list_of_files[i]))  # Print confirmation
    }
  }

directory_all<-"C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/01/randomfiles_2"
list_of_files <- list.files(
  path = directory_all, 
  pattern = "\\.(mgt)$", 
  full.names = TRUE
)

#Loop through the matched files
for (i in seq_along(list_of_files)) {
  
  # Construct the full file path
  file_path <- file.path(list_of_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "ESC" in any line
  if (any(grepl("ESC", file_content))) {
    
    # Replace "ESC" with "PINE"
    file_content <- gsub("ESC", "PINE", file_content)
    
    # Modify the filename by adding 'mod_' at the beginning of the name
    new_file_path <- file.path(directory_all, paste0("mod_", basename(file_path)))
    
    # Save the updated content back to the new file
    write_lines(file_content, new_file_path)
  }
}

###00 100% ESC is PINE management and all mgr hru and gw files have PINE in header
###in list files we have the files with .mgt extension
esc_files<-list()
for (i in seq_along(list_of_files)) {
  # Construct full file path
  file_path <- file.path(getwd(), list_of_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "PINE" in any line
  if (any(grepl("ESC", file_content)))
    ##then keep it in the list
    esc_files<-c(esc_files,list_of_files[i])
}

# Extract the base names (without extensions) from both lists
base_names <- sub("\\.mgt$", "", esc_files)  # Remove the ".mgt" extension ## for 100% ESC


###find in this other directory file with same name but .hru and .gw and change ESC in header for PINE
directory_all<-"C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/00/"
list_of_files_all <- list.files(
  path = directory_all, 
  pattern = "\\.(hru|gw)$", 
  full.names = TRUE
)

# Filter the list_of_files_all to include only those files whose base names match
matched_files <- list_of_files_all[str_detect(list_of_files_all, paste(base_names, collapse = "|"))]



##select files same name as list_of_files
# Loop through the matched files
for (i in seq_along(matched_files)) {
  
  # Construct the full file path
  file_path <- file.path(matched_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "ESC" in any line
  if (any(grepl("ESC", file_content))) {
    
    # Replace "ESC" with "PINE"
    file_content <- gsub("ESC", "PINE", file_content)
    
    # Modify the filename by adding 'mod_' at the beginning of the name
    new_file_path <- file.path(directory_all, paste0("mod_", basename(file_path)))
    
    # Save the updated content back to the new file
    write_lines(file_content, new_file_path)
  }
}



##########################
#########################
###for 50% ESC the mgt are readi in the directory
output_directory<-("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/01/randomfiles_1")
esc_files_50 <- list.files(output_directory ,pattern = ".mgt$") ##54 files
## list files 
base_names <- sub("\\.mgt$", "", esc_files_50 )


### use this folder to do the files
###find in this other directory file with same name but .hru and .gw and change ESC in header for PINE
directory_all<-"C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/00/"
list_of_files_all <- list.files(
  path = directory_all, 
  pattern = "\\.(hru|gw)$", 
  full.names = TRUE
)

# Filter the list_of_files_all to include only those files whose base names match
matched_files <- list_of_files_all[str_detect(list_of_files_all, paste(base_names, collapse = "|"))]



##select files same name as list_of_files
# Loop through the matched files
for (i in seq_along(matched_files)) {
  
  # Construct the full file path
  file_path <- file.path(matched_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "ESC" in any line
  if (any(grepl("ESC", file_content))) {
    
    # Replace "ESC" with "PINE"
    file_content <- gsub("ESC", "PINE", file_content)
    
    # Modify the filename by adding 'mod_' at the beginning of the name
    new_file_path <- file.path(directory_all, paste0("mod_", basename(file_path)))
    
    # Save the updated content back to the new file
    write_lines(file_content, new_file_path)
  }
}


###for 50% ESC the mgt are readi in the directory
output_directory<-("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/01/randomfiles_2")
esc_files_50 <- list.files(output_directory ,pattern = ".mgt$") ##54 files
## list files 
base_names <- sub("\\.mgt$", "", esc_files_50 )


### use this folder to do the files
###find in this other directory file with same name but .hru and .gw and change ESC in header for PINE
directory_all<-"C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/00/"
list_of_files_all <- list.files(
  path = directory_all, 
  pattern = "\\.(hru|gw)$", 
  full.names = TRUE
)

# Filter the list_of_files_all to include only those files whose base names match
matched_files <- list_of_files_all[str_detect(list_of_files_all, paste(base_names, collapse = "|"))]



##select files same name as list_of_files
# Loop through the matched files
for (i in seq_along(matched_files)) {
  
  # Construct the full file path
  file_path <- file.path(matched_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "ESC" in any line
  if (any(grepl("ESC", file_content))) {
    
    # Replace "ESC" with "PINE"
    file_content <- gsub("ESC", "PINE", file_content)
    
    # Modify the filename by adding 'mod_' at the beginning of the name
    new_file_path <- file.path(directory_all, paste0("mod_", basename(file_path)))
    
    # Save the updated content back to the new file
    write_lines(file_content, new_file_path)
  }
}


###00 100% ESC is PINE management and all mgr hru and gw files have PINE in header
###01 50% ESC is PINE management and all mgr hru and gw files have PINE in header ranodm1
###01 50% ESC is PINE management and all mgr hru and gw files have PINE in header random2
###
#00/modieiedesctopineall
#01/modieiedesctopineall *2

#### now rename
#setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/esc_pine_100_dynamic/")
#setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/esc100pinefinalesincreasebiom5")
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/00/modieiedesctopineall")  ## 545 files*3
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/esc100pinefinalesincreasebiom5") ##545 files
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/01/randomfiles_1")
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/01/randomfiles_1/allready50pine") ## 53 *3 files
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/01/randomfiles_2") ## 53 *3 files
#list_tomod <- list.files()


list_tomod <- list.files()

# Iterate through each file in the list
for (file in list_tomod) {
  # Remove the "mod_" prefix from the filename
  new_file_name <- sub("^mod_", "", file)  # Remove "mod_" from the start of the file name
  
  # Construct full paths for renaming
  file_path <- file.path(getwd(), file)
  new_file_path <- file.path(getwd(), new_file_name)
  
  # Rename the file if the new name is different from the old one
  if (new_file_name != file) {
    # Check if the file actually exists before renaming
    if (file.exists(file_path)) {
      file.rename(file_path, new_file_path)
      cat("Renamed:", file, "to", new_file_name, "\n")
    } else {
      cat("File does not exist:", file, "\n")
    }
  }
}

# Loop through the list of files


#### now rename
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/esc_pine_100_dynamic/")
setwd("C:/Users/Lenovo/Documents/Borracho_April2024/mgt_esctopinenodynamic/esc100pinefinalesincreasebiom5")
list_of_files <- dir(pattern = "\\.mgt$", all.files = FALSE)

# Iterate through each file
for (file in list_of_files) {
  # Generate the new file name by removing everything before the first "0"
  new_file_name <- sub(".*?0", "0", file)
  
  # Rename the file if the new name is different
  if (new_file_name != file) {
    file.rename(file, new_file_name)
  }
}

