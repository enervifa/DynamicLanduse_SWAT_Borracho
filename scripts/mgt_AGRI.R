library(tidyverse)
library(readr)

setwd('C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt')
output_directory <- "C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt"
list_of_files <- list.files(output_directory ,pattern = ".mgt$")

#mgt options for agriculture rotations

AGRPA<-"Management Operations:
               5    | NROT: number of years of rotation
Operation Schedule:
  1  1           9  314  45        12.14000   9.72     9.58000
 11 11           8
 11 12           1   56             0.00000   0.00     0.00000 0.00   0.00  0.00
 11 12           3    2            20.00000   0.00
                17
  4 21           5                  0.00000
  4 22           1   32             0.00000   0.00     0.00000 0.00   0.00  0.00
 11 10           4    1             0.00000   0.00
 11 11           8
 11 12           1   56             0.00000   0.00     0.00000 0.00   0.00  0.00
 11 12           3    2            20.00000   0.00
                17
  4 21           5                  0.00000
  4 22           1   12             0.00000   0.00     0.00000 0.00   0.00  0.00
  4 22           3   18           150.00000   0.00
 10 30           9  253  45        12.14000   9.72     9.58000
                17
  1  1           9  365  45        12.14000   9.72     9.58000
  4 16           3   18            80.00000   0.00
                17
  1  1           9  365  45        12.14000   9.72     9.58000
  4 16           3   18            80.00000   0.00
                17" 
###F
AGR3B<-"Management Operations:
               2    | NROT: number of years of rotation
Operation Schedule:
  2 20           5                  0.00000
  2 21           1   32             0.00000   0.00     0.00000 0.00   0.00  0.00
 11 10           4    1             0.00000   0.00
 11 11           8
 11 12           1   56             0.00000   0.00     0.00000 0.00   0.00  0.00
 11 12           3    2            20.00000   0.00
                17
  4 21           5                  0.00000
  4 22           1   32             0.00000   0.00     0.00000 0.00   0.00  0.00
  9 21           4    1             0.00000   0.00
  9 22           8
  9 23           1   19             0.00000   0.00     0.00000 0.00   0.00  0.00
  9 23           3   18           150.00000   0.00
 11  2           3    4           200.00000   0.00
                17"
 #
AGR2A<-"Management Operations:
               2    | NROT: number of years of rotation
Operation Schedule:
  5  1           5                  0.00000
  6 14           1   31             0.00000   0.00     0.00000 0.00   0.00  0.00
  6 14           3   18           100.00000   0.00
  7 24           3    4            80.00000   0.00
  8 24           3    4            80.00000   0.00
 11 25           5                  0.00000
 12 10           1  176             0.00000   0.00     0.00000 0.00   0.00  0.00
 12 10           3    2            20.00000   0.00
                17
  5  1           5                  0.00000
  6 14           1   28             0.00000   0.00     0.00000 0.00   0.00  0.00
  6 14           3   18           100.00000   0.00
  7 24           3    4            80.00000   0.00
  8 24           3    4            80.00000   0.00
 11 25           5                  0.00000
 12 10           1  176             0.00000   0.00     0.00000 0.00   0.00  0.00
 12 10           3    2            20.00000   0.00
                17"


AGRRR<-"Management Operations:
              26    | NROT: number of years of rotation
Operation Schedule:
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  1  1           1   12             0.00000   0.80     1.00000 0.00   0.00  0.00
  1 10           9  120  45         5.02000   4.01     1.90000
  5  1           9  123  45         5.02000   4.01     1.90000
  9  1           9  122  45         5.02000   4.01     1.90000
 12 31           4  231             0.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17
  2  5           5                  0.00000
  3  1           1  157          1800.00000   0.00     0.00000 0.00   0.00  0.00
  3 10           4    1             0.00000   0.00
  9 12          10    1   1         0.80000   0.85    20.00000 0.00                        1
  9 15           1   33          1552.14368   0.00     0.00000 0.00   0.00  0.00
  9 15           3    1            46.00000   0.00
 10 15           3    1            46.00000   0.00
 11 12           3    2            24.00000   0.00
 12 15           3    1            46.00000   0.00
                17"




# # Loop through the list of files


for (i in seq_along(list_of_files)) {
  # Construct full file path
  file_path <- file.path(getwd(), list_of_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "PINE" in any line
  if (any(grepl("AGRI", file_content))) {
    modified_content <- replace_lines(file_content, sampled_number)
    
  }
}

      replace_lines <- function(content, sampled_number) {
        # Replace Initial Plant Growth Parameters block
        target_start <- grep("Initial Plant Growth Parameters", content)
        sampled_number <- sample(c(1, 2, 3), 1)
        
        if (length(target_start) > 0) {
          replacement_block <- switch(as.character(sampled_number),
                                      "1" = c(
                                        "Initial Plant Growth Parameters",
                                        "               1    | IGRO: Land cover status: 0-none growing; 1-growing",
                                        "              12    | PLANT_ID: Land cover ID number (IGRO = 1)",
                                        "            1.00    | LAI_INIT: Initial leaf are index (IGRO = 1)",
                                        "          100.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)",
                                        "            0.00    | PHU_PLT: Number of heat units to bring plant to maturity (IGRO = 1)"
                                      ),
                                      "2" = c(
                                        "Initial Plant Growth Parameters",
                                        "               1    | IGRO: Land cover status: 0-none growing; 1-growing",
                                        "             176    | PLANT_ID: Land cover ID number (IGRO = 1)",
                                        "            3.60    | LAI_INIT: Initial leaf are index (IGRO = 1)",
                                        "         1000.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)",
                                        "            0.00    | PHU_PLT: Number of heat units to bring plant to maturity (IGRO = 1)"
                                        
                                       ),
                                      "3" = c(
                                        "Initial Plant Growth Parameters",
                                        "               1    | IGRO: Land cover status: 0-none growing; 1-growing",
                                        "              19    | PLANT_ID: Land cover ID number (IGRO = 1)",
                                        "            4.50    | LAI_INIT: Initial leaf are index (IGRO = 1)",
                                        "         1000.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)",
                                        "            0.00    | PHU_PLT: Number of heat units to bring plant to maturity (IGRO = 1)"
                                        
                                  )
          )
          
          # Replace lines in the content
          content <- c(
            content[1:(target_start[1] - 1)],
            replacement_block,
            content[(target_start[1] + 6):length(content)]
          )
        }
        
        # Replace BIO_MIN values
        target_bio_min <- grep("\\| BIO_MIN: Minimum biomass for grazing", content)
        
        if (length(target_bio_min) > 0) {
          management_start <- grep("Management Operations:",content)
          replacement_bio_min <- switch(as.character(sampled_number),
                                        "1" = "           10.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)",
                                        "2" = "            0.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)",
                                        "3" = "            0.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)")
          content[target_bio_min[1]] <- replacement_bio_min
        }
        
        # Add Operation Schedule replacement logic
          # Use the new function to modify the file content
          ##gIVEN NUMBER Select FORQ1, FORQ2 or FORQ3
          replacement_chunk <- switch(as.character(sampled_number),
                                      "1" = AGRPA,
                                      "2" = AGR2A,
                                      "3" = AGR3B)
          modified_content <- replace_and_truncate(content, replacement_chunk, management_start[1]) 
          
          modified_content <- unlist(modified_content) 
          
          # Write the modified file to the output directory
          write_lines(modified_content, file.path(output_directory, paste0('mod_', list_of_files[i])))
          
          cat("Modified and saved:", file.path(output_directory, list_of_files[i]))  # Print confirmation
        }
       
    
      
      #### now rename
      setwd('C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt/AGRI_picked3/WITHRICE')
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
      
###### Add Rice to selected subbasins 
      
      
      
      setwd('C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt/AGRI_picked3/WITHRICE')
      output_directory <- "C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt/AGRI_picked3/WITHRICE"
      list_of_files <- list.files(output_directory ,pattern = ".mgt$")
      
      
      
replace_lines_arroz <- function(content, sampled_number) {
  
  # Replace Initial Plant Growth Parameters block
  target_start <- grep("Initial Plant Growth Parameters", content)
 
  
  if (length(target_start) > 0) {
    replacement_block <-c(
                                  "Initial Plant Growth Parameters",
                                  "               0    | IGRO: Land cover status: 0-none growing; 1-growing",
                                  "              12    | PLANT_ID: Land cover ID number (IGRO = 1)",
                                  "            1.00    | LAI_INIT: Initial leaf are index (IGRO = 1)",
                                  "          100.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)",
                                  "            0.00    | PHU_PLT: Number of heat units to bring plant to maturity (IGRO = 1)"
                                )
    
    # Replace lines in the content
    content <- c(
      content[1:(target_start[1] - 1)],
      replacement_block,
      content[(target_start[1] + 6):length(content)]
    )
  }
  
  # Replace BIO_MIN values
  target_bio_min <- grep("\\| BIO_MIN: Minimum biomass for grazing", content)
  
  if (length(target_bio_min) > 0) {
    management_start <- grep("Management Operations:",content)
    replacement_bio_min <- c("           10.00    | BIO_MIN: Minimum biomass for grazing (kg/ha)")
    content[target_bio_min[1]] <- replacement_bio_min
  }
  
  # Add Operation Schedule replacement logic
  # Use the new function to modify the file content
  ##gIVEN NUMBER Select FORQ1, FORQ2 or FORQ3
  replacement_chunk =AGRRR
  modified_content <- replace_and_truncate(content, replacement_chunk, management_start[1]) 
  
  modified_content <- unlist(modified_content) 
  
  # Write the modified file to the output directory
  write_lines(modified_content, file.path(output_directory, paste0('mod_', list_of_files[i])))
  
  cat("Modified and saved:", file.path(output_directory, list_of_files[i]))  # Print confirmation
}



for (i in seq_along(list_of_files)) {
  # Construct full file path
  file_path <- file.path(getwd(), list_of_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Define the patterns to match
  subbasins <- c("Subbasin:37", "Subbasin:3", "Subbasin:14", "Subbasin:15", "Subbasin:21")
  
  # Check if the file contains both "AGRI" and any of the subbasin patterns
  if (any(grepl("AGRI", file_content)) && 
      any(sapply(subbasins, function(sub) grepl(sub, file_content)))) {
    modified_content <-       
      replace_lines_arroz(file_content, sampled_number)
    
  }
}


#### now rename
setwd('C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt/AGRI_picked3/WITHRICE')
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


