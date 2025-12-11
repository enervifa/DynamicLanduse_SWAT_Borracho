library(tidyverse)

# Load required libraries
library(readr)

# Function to replace specific lines with a replacement chunk, and truncate the file after the replacement
replace_and_truncate <- function(input, replace, start_line) {
  # Create a new vector to hold the modified content
  new_content <- c(input[1:(start_line - 1)], replace)
  return(new_content)
}

# Set a seed for reproducibility
set.seed(123)

# Function to split the lines into years based on "17" markers
split_lines_into_years <- function(input_text) {
  # Split the input text into lines
  #browser()
  lines <- str_split(input_text, "\n")#[[1]]
  
  # Initialize variables to store the results
  years <- list()  # List to store the years
  current_year <- 1  # Start with Year 1
  year_lines <- character()  # Temporary variable to store the lines for the current year
  
  # Loop through the lines and assign them to the appropriate year
  for (line in lines) {
    year_lines <- c(year_lines, line)  # Add the line to the current year's lines
    
    # Check if the line contains "17", which marks the end of the current year
    if (grepl("17", line)) {
      years[[current_year]] <- year_lines  # Save the collected lines for the current year
      year_lines <- character()  # Reset for the next year
      current_year <- current_year + 1  # Move to the next year
    }
  }
  
  return(years)  # Return the list of years with their lines
}



# Split the operation schedule into years based on the occurrence of "17"
years_data <- split_lines_into_years(operation_schedule)

# Print out the lines for Year 1 and Year 2
#cat("Year 1 Operations:\n", paste(years_data[[1]], collapse = "\n"), "\n\n")
#cat("Year 2 Operations:\n", paste(years_data[[2]], collapse = "\n"), "\n\n")
#cat("Year 25 Operations:\n", paste(years_data[[25]], collapse = "\n"), "\n\n")

## then map years that have planting operations mapping 1 in third column
#9 30           1   94      1   1800.00000   2.50   200.00000 0.00   0.00  0.00
#4 20           1  119      1   1800.00000   1.00   200.00000 0.00   0.00  0.00

# Function to check if a year has planting operations (where third column is 1)
has_planting_operations <- function(year_lines, year_number) {
  # Initialize a counter for planting operations
  planting_count <- 0
  
  for (line in year_lines) {
    columns <- str_split(line, "\\s+")[[1]]  # Split line into columns by whitespace
    if (length(columns) >= 3 && columns[3] == "1") {
      planting_count <- planting_count + 1  # Increment planting count
    }
  }
  
  return(data.frame(Year = year_number, PlantingCount = planting_count))
}

# Map over years_data to check for planting operations
result <- map2_df(years_data, seq_along(years_data), ~ has_planting_operations(.x, .y))

# head(result )
# Year PlantingCount
# 1    1             1
# 2    2             0
# 3    3             0
# 4    4             0
# 5    5             0
# 6    6             0

## as there planting count is 1 in eyar 1, then find element1 in years_data and exchange it with year from set seed 123 choosing between 2,10,15,20
# head(years_data)
# [[1]]
# [1] ""                                                                                
# [2] "1  1          14  200  45  1       4.2000"                                       
# [3] "  8 15           8"                                                              
# [4] "  9 30           1   94      1   1800.00000   2.50   200.00000 0.00   0.00  0.00"
# [5] " 10  1           3    7            25.00000   0.00"                              
# [6] "                17"                                                              
# 
# [[2]]
# [1] "  1 15          14  336  45  1       4.2000" "                17"                         
# 
# [[3]]
# [1] "  1 15          14  336  45  1       4.2000" "                17"                         
# 
# [[4]]
# [1] "  1 15          14  336  45  1       4.2000" "                17"                         
# 
# [[5]]
# [1] "  1 15          14  336  45  1       4.2000" "                17"                         
# 
# [[6]]
# [1] "  1 15          14  336  45  1       4.2000" "                17"      


## Now I need to move planting year 5 years without altering the schedule for other years, but muving the planting year
#Eg. Exchange year planting with year 5, year 10 and year 15. 
# Function to shift planting operations to specific year selected from 5 10 50 using set seed. This meens the year in that position woyld be located in tha plantin location. 

# Eliminate NA lines from all years
# years_data <- lapply(years_data, function(year) year[!is.na(year)])

# Specify target years for planting operations
# Define target years
target_years <- c(5, 10, 15)

# Identify the year(s) with planting operations from the 'result' dataframe
planting_years <- result %>% filter(PlantingCount > 0) %>% pull(Year)

# Randomly select a target year
selected_years <- sample(target_years,  length(planting_years))

# Print the selected target year
#cat("The selected target year is/are:", selected_year, "\n")

years_data_toshift<-years_data


# Define the function to swap planting years with selected target years
swap_planting_years <- function(years_data, planting_years, selected_years) {
  # Create a copy of years_data to modify
  years_data_toshift <- years_data
  
  # Loop through each year in years_data
  for (i in 1:length(years_data_toshift)) {
    # Check if the current position corresponds to a planting year
    if (i %in% planting_years) {  ## checking positions, not values
      # Find the corresponding target index in selected_years
      target_idx <- which(planting_years == i)
      years_data_toshift[i] <- years_data[selected_years[target_idx]]  # Swap based on position
    } else if (i %in% selected_years) {
      # Find the corresponding planting year index in planting_years
      planting_idx <- which(selected_years == i)
      years_data_toshift[i] <- years_data[planting_years[planting_idx]]  # Swap based on position
    }
  }
  
  # Return the modified years_data_toshift
  return(years_data_toshift)
}

# Apply the function
modified_years_data <- swap_planting_years(years_data, planting_years, selected_years)


#####format


# Example operation schedule read from file ##
# Define the directory where files will be saved
setwd('C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt')
output_directory <- "C:/Users/Lenovo/Documents/Borracho_April2024/Borracho/Scenarios/prueba_mgt"
list_of_files <- list.files(output_directory ,pattern = ".mgt$")

# Loop through the list of files
for (i in seq_along(list_of_files)) {
  # Construct full file path
  file_path <- file.path(getwd(), list_of_files[i])
  
  # Read the entire file content
  file_content <- read_lines(file_path)
  
  # Check if the file contains "PINE" in any line
  if (any(grepl("PINE", file_content))) {
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
      
      
      # Now, update the BIO_INIT value
      # Identify the line that contains "1000.00    | BIO_INIT: Initial biomass"
      target_line_index <- grep("         1000.00    | BIO_INIT: Initial biomass", modified_content)
      #browser()
      
      ## now 
      ## grep line with  "         1000.00    | BIO_INIT: Initial biomass (kg/ha) (IGRO = 1)"
      #and just before it rewrite 1000.00 given selected_years. If selected years[[1]] is 2, then 1000.00 should be replaced with 17000.00
      # if it is 3, then 15000.00, if it is 5 then 70000.00,it is 10 then 70000.00
      
      # Replace the value based on selected_years[[1]]
      if (length(target_line_index) > 0) {
        # Find the line just before the target line
        replacement_value <- switch(as.character(selected_years[[1]]), #5,10,8,15
                                    "5" ="         20000.00    | BIO_INIT: Initial biomass",
                                    "10" = "       90000.00    | BIO_INIT: Initial biomass",
                                    "15" = "       150000.00    | BIO_INIT: Initial biomass",
                                    "         1000.00    | BIO_INIT: Initial biomass")  # Default if no match
        
        # Replace the value in the target line
        modified_content[target_line_index] <- replacement_value
        
        ###### change planitng BIOINI
        # Identify the line that contains "1000.00    | BIO_INIT: Initial biomass"
        target_line_index <- grep("  1  2           1   94      1   1800.00000   2.50   200.00000 0.00   0.00  0.00", modified_content)
        #browser()
      }
      # Replace the value based on selected_years[[1]]
      if (length(target_line_index) > 0) {
        # Sample a number with specified probabilities
        sampled_number <- 1
        
        # Define the replacement value based on the sampled number
        replacement_value <- case_when(
          sampled_number == 1 ~ "  1  2           1   94      1   1800.00000   2.50   10000.00000 0.00   0.00  0.00")
        # Replace the value in the target line
        modified_content[target_line_index] <- replacement_value
      }
      # Write the modified file to the output directory
      write_lines(modified_content, file.path(output_directory, paste0('mod_', list_of_files[i])))
      
      cat("Modified and saved:", file.path(output_directory, list_of_files[i]))  # Print confirmation
    }
  }
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

