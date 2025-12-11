
##This is the step after changing landuse name change CN2 initial condition considering the new land use and soil from SWAT

## plant database CN2
library(tibble)

# Create the tibble with consistent types
plant_CN2 <- tibble(
  luse = c("PINE", "PAST"),
  A = c(25, 49),
  B = c(55, 69),
  C = c(70, 79),
  D = c(77, 84)
)


hydosoil_data_full <- tibble(
  SNAM = 1:161,
  HYDGRP = c("C", "D", "C", "B", "C", "C", "C", "D", "D", "C", "C", "D", "D", "D", "D", "D", "D", "D", "C", "D", "C", "D", "D", "D", "D", "D", "D", "D", "D", 
             "D", "D", "B", "C", "C", "C", "C", "C", "C", "C", "C", "C", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", 
             "D", "B", "B", "C", "D", "C", "C", "D", "D", "D", "D", "C", "C", "D", "D", "D", "D", "B", "B", "B", "C", "B", "B", "B", "C", "C", "C", "C", "C", 
             "C", "D", "C", "C", "B", "C", "C", "C", "C", "C", "C", "C", "D", "C", "C", "C", "C", "B", "B", "D", "D", "B", "B", "C", "D", "C", "D", "C", "D", 
             "D", "D", "D", "D", "C", "C", "C", "C", "C", "C", "C", "D", "C", "D", "C", "C", "A", "A", "D", "C", "A")
)
plant_CN2_long <- plant_CN2 %>%
  pivot_longer(
    cols = c(A,B,C,D),  # Select columns to pivot
    names_to = "HYDGRP",        # Create the HYDGRP column
    names_prefix = "CN2",       # Remove "CN2" prefix
    values_to = "CN2_value"     # Column for values
  )

# Merge the two datasets based on soil HYDGRP
merged_data <- hydosoil_data %>%
  left_join(plant_CN2_long, by = "HYDGRP")


# List all .mgt files, excluding "SUFI2" and other unnecessary files
list_of_files <- dir(pattern = "\\.mgt$", all.files = FALSE)
list_of_files <- list_of_files[!grepl("SUFI2", list_of_files)]

## read the first line of the file and grepl the word PINE or PAST and grep letter after Soil:
## then in the line that grepl '| CN2: Initial SCS CN II' and add the value corresponding 
#to that luse and soil from the database before so it ends as  55.00    | CN2: Initial SCS CN II value

# Iterate through each file
for (file in list_of_files) {
  # Read the content of the file
  lines <- readLines(file)
  
  # Extract land use (PINE or PAST) from the first line
  luse <- ifelse(grepl("PINE", lines[1]), "PINE", "PAST")
  
  # Extract the soil hydrological group from the line containing "Soil:"
  soil_line <- grep("Soil:", lines, value = TRUE)
  if (length(soil_line) > 0) {
    soil_group <- sub(".*Soil: ([A-Z]).*", "\\1", soil_line)
    
    # Find the corresponding CN2 value from `merged_data`
    cn2_value <- merged_data %>%
      filter(luse == luse, HYDGRP == soil_group) %>%
      pull(CN2_value)
    
    if (length(cn2_value) == 1) {
      # Locate the line with `| CN2: Initial SCS CN II`
      cn2_line_index <- grep("\\| CN2: Initial SCS CN II", lines)
      if (length(cn2_line_index) > 0) {
        # Replace the CN2 value in that line
        lines[cn2_line_index] <- sub(
          "\\d+\\.\\d+\\s+\\| CN2: Initial SCS CN II",
          sprintf("%.2f    | CN2: Initial SCS CN II", cn2_value),
          lines[cn2_line_index]
        )
      }
    }
  }
  
  # Write the updated content back to the file
  writeLines(lines, file)
}



setwd("C:/Users/Lenovo/Documents/Calib y Valid La Corona Sydney/LCnewsoil/Scenario_LC_new_del/prueba_CN_mgt4")

#### las change
# Load required packages
library(tibble)
library(tidyr)
library(dplyr)

# Create the plant_CN2 tibble
plant_CN2 <- tibble(
  luse = c("PINE", "PAST"),
  A = c(25, 49),
  B = c(55, 69),
  C = c(70, 79),
  D = c(77, 84)
)

# Create the hydosoil_data tibble
hydosoil_data <- tibble(
  SNAM = c("A", "B", "C", "D", "E", "F", "G", "H", "L", "W"),
  HYDGRP = c("D", "C", "B", "B", "D", "C", "D", "D", "C", "C")
)

# Pivot `plant_CN2` longer to match hydosoil_data
plant_CN2_long <- plant_CN2 %>%
  pivot_longer(
    cols = c(A, B, C, D),  # Select columns to pivot
    names_to = "HYDGRP",   # Create the HYDGRP column
    values_to = "CN2_value"  # Column for values
  )

# Merge the two datasets based on HYDGRP
merged_data <- hydosoil_data %>%
  left_join(plant_CN2_long, by = "HYDGRP")

# List all `.mgt` files, excluding those with "SUFI2"
list_of_files <- dir(pattern = "\\.mgt$", all.files = FALSE)
list_of_files <- list_of_files[!grepl("SUFI2", list_of_files)]

### Take scenario 3 files and change name of land use to PINE in every of them

# Iterate through each file
for (file in list_of_files) {
  # Read the content of the file
  lines <- readLines(file)
  
  # Check the first line and perform replacements
  if (grepl("PINE", lines[1])) {
    # Replace PINE with PAST
    lines[1] <- sub("PINE", "PINE", lines[1])
  } else if (grepl("PAST", lines[1])) {
    # Replace PAST with PINE
    lines[1] <- sub("PAST", "PINE", lines[1])
  }
    else if (grepl("GRAS", lines[1])) {
      # Replace PAST with PINE
      lines[1] <- sub("GRAS", "PINE", lines[1])
  }
  
  # Write the modified content back to the file
  writeLines(lines, file)
}

# Iterate through each file
for (file in list_of_files) {
  # Read the content of the file
  lines <- readLines(file)
  
  # Extract land use (PINE or PAST) from the first line
  land_use  <- ifelse(grepl("PINE", lines[1]), "PINE", "PAST")
  #browser()
  # Extract the soil hydrological group from the line containing "Soil:"
  soil_line <- grep("Soil:", lines, value = TRUE)
 
  if (length(soil_line) > 0) {
    # Extract just the soil group (the letter) using regular expressions
    soil_group <- sub(".*Soil:\\s([A-Z]).*", "\\1", soil_line)
     
    # Find the corresponding CN2 value from `merged_data`
    cn2_value <- merged_data %>%
      ungroup()%>%
      filter(SNAM == soil_group)
    
    value <- cn2_value %>%
      filter(luse == land_use ) %>%
      pull(CN2_value)
    
    if (length(value) == 1) {
      # Locate the line with `| CN2: Initial SCS CN II`
      cn2_line_index <- grep("\\| CN2: Initial SCS CN II", lines)
      if (length(cn2_line_index) > 0) {
        # Replace the CN2 value in that line
        lines[cn2_line_index] <- sub(
          "\\d+\\.\\d+\\s+\\| CN2: Initial SCS CN II",
          sprintf("%.2f    | CN2: Initial SCS CN II", value),
          lines[cn2_line_index]
        )
      }
    }
  }
  
  # Create a new filename with "_mod" suffix
  new_file <- paste0('mod_', file )
  
  # Write the updated content to the new file
  writeLines(lines, new_file)
}

#### now rename

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

