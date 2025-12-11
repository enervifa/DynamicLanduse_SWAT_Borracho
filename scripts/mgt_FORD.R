library(tidyverse)
library(readr)

# Function to replace specific lines with a replacement chunk, and truncate the file after the replacement
replace_and_truncate <- function(input, replace, start_line) {
  # Create a new vector to hold the modified content
  new_content <- c(input[1:(start_line - 1)], replace)
  return(new_content)
}

# Set a seed for reproducibility
set.seed(123)


#mgt options
####FORQ1  FORESTED UP TO 2015. START MODEL IN 2002 2 NSKIP 13 years. I do this so trees are cut in 9 year
FORD1<-"Management Operations:
               25    | NROT: number of years of rotation
Operation Schedule:
  1  1           1   94     12   1800.00000   3.50 80000.00000 0.00   0.00  0.00
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  4  3           8
  4 15           6    1             0.00000
  4 16           4  231            10.00000   0.00
  4 20           1  184      1   1800.00000   1.00    20000.00000 0.00   0.00  0.00
                17
  4 22           3    7            25.00000   0.00
                17
  4 22           3    7            25.00000   0.00
                17
  4 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  4  3           8
  4 15           6    1             0.00000
  4 16           4  231            10.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17"
###FORQ2 FORESTED UP TO 2015. START MODEL IN 2002 2 NSKIP 13 years. I do this so trees are cut in 11 year as they could have been clear before
FORD2<-"Management Operations:
               25    | NROT: number of years of rotation
Operation Schedule:
  1  1           1   94     12   1800.00000   3.50 90000.00000 0.00   0.00  0.00
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  4  3           8
  4 15           6    1             0.00000
  4 16           4  231            10.00000   0.00
  4 20           1  184      1   1800.00000   1.00    20000.00000 0.00   0.00  0.00
                17
  4 22           3    7            25.00000   0.00
                17
  4 22           3    7            25.00000   0.00
                17
  4 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  8  1           8
  9  1           1   12          1698.34106   0.00  0.00000 0.00   0.00  0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17"
#FORESTED UP TO 2015. START MODEL IN 2002 2 NSKIP 13 years. I do this so trees are cut in 13 year
FORD3<-"Management Operations:
              25    | NROT: number of years of rotation
Operation Schedule:
  1  1           1  119     12   1800.00000   4.00 100000.00000 0.00   0.00  0.00
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  1 15          14  336  45  1       4.2000
                17
  4  3           8
  4 15           6    1             0.00000
  4 16           4  231            10.00000   0.00
  4 20           1  184      1   1800.00000   1.00    20000.00000 0.00   0.00  0.00
                17
  4 22           3    7            25.00000   0.00
                17
  4 22           3    7            25.00000   0.00
                17
  4 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  1 29          14  336  45  1       4.2000
                17
  8  1           8
  9  1           1   12          1698.34106   0.00  0.00000 0.00   0.00  0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  2 10           9  120  45         5.02000   4.01     1.90000
  6  1           9  123  45         5.02000   4.01     1.90000
 10  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17"


############DO NOT FORGET TO SET SEED UPSTREAM
# Example operation schedule read from file ##
# Define the directory where files will be saved
setwd("C:/Users/Lenovo/Desktop/TESTMGT")
output_directory <- "C:/Users/Lenovo/Desktop/TESTMGT"
list_of_files <- list.files(output_directory ,pattern = ".mgt$")

# Loop through the list of files selected for that landuse
for (i in seq_along(list_of_files)) {
  # Construct full file path
  file_path <- file.path(getwd(), list_of_files[i])
  
  # Read the entire file content and grep the LUSE code in the HRU file header
  file_content <- read_lines(file_path)
  
  # Check if the file contains "LULC CODE" 
  if (any(grepl("FORD", file_content))) {
    # Find the line index for "Management Operations:" becasue there is wher the new ngt op would be replaced
    management_start <- grep("Management Operations:", file_content)
    operation_schedule<-file_content[(management_start + 1):length(file_content)]
    
     # If found, replace that line with the replacement chunk rendombly selected
    if (length(management_start) > 0) {
      sampled_number <- sample(c(1, 2, 3), 1)
        # Use the new function to modify the file content
      ##GIVEN NUMBER Select FORQ1, FORQ2 or FORQ3 (established upstream)
      replacement_chunk <- switch(as.character(sampled_number),
                                  "1" = FORD1,
                                  "2" = FORD2,
                                  "3" = FORD3)
        modified_content <- replace_and_truncate(file_content, replacement_chunk, management_start[1]) 
        
 
    }
    
      target_bio_min <- grep("\\| BIO_MIN: Minimum biomass for grazing",  modified_content)
      
      if (length(target_bio_min) > 0) {
        replacement_bio_min <- switch(as.character(sampled_number), #1,3,10
                                      "1" =c("            1.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)"),
                                      "2" =c("            0.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)"),
                                      "3" = c("            2.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)"),
                                      c("            1.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)")) 
        
        modified_content[target_bio_min[1]] <- replacement_bio_min
      }
      
      modified_content <- unlist(modified_content) 
             # Write the modified file to the output directory
      write_lines(modified_content, file.path(output_directory, paste0('mod_', list_of_files[i])))
      
      cat("Modified and saved:", file.path(output_directory, list_of_files[i]))  # Print confirmation
    }
  }


#### now renam after do manual checking
setwd('C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt/FORD_picked3')
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

