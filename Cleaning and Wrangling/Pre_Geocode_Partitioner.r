# This will read in directories of where to read and write files
# This will partition csv files into smaller chunks
# Select the start and end columns representing address (apt or what not included as a single column with space), city/town, state, zip.

# We want to abstract to read to any county in a loop
COUNTY_LIST <- c('INSERT','COUNTIES','IN','HERE')

# COUNTY_LIST - vector of names of counties
# path_from - folder of csv files to read
# path_to - folder to save geocode
# name_of_file1 - "MM/YYYY" - To indicate the relevance of the dataset
# default file_type = .csv

path_from = ""
path_to = ""
name_of_file1 = " "
file_type = '.csv'

# chunk - 10000 is the default, good for our batch geocoding requirements
chunk = 10000 

# Street address ()
a= # Column to start reading data
z= # Column to stop. 
# If it's non-continuous, create a dataframe of subsets of the specific addresses then feed in the start and end.

partition_list <- function(COUNTY_LIST = COUNTY_LIST, name_of_file1 = name_of_file1, path_from = path_from, path_to = path_to, file_type = '.csv', chunk = 10000, a = 10, z = 14 ){
  for(i in 1:length(COUNTY_LIST)){
    # Select County i in index 
    name_of_file2 <- toString(COUNTY_LIST[i]) 
    # Append County i name to file_link
    file_link <- paste0(path_from,name_of_file1," ",name_of_file2,file_type,sep='')
    df_file <- read.csv(file_link,header=FALSE)
    df_file <- df_file[,a:z]
  
    # You want to partition and create csv
    # How many rows are there in your data file?
    df_file_rows <- nrow(df_file)
      
    # This will help partition the 
    df_file_r <- rep(1:ceiling(df_file_rows/chunk), each = chunk)[1:df_file_rows]
      
    # Put the datasets into rows
    LIST_OF_PARTITIONED_DATASETS <- split(df_file, df_file_r)
      
    # Create Files
    for(k in 1:length(LIST_OF_PARTITIONED_DATASETS)){
        file_to <- paste0(path_to,"Geocode ",name_of_file1," " ,name_of_file2,".%d",file_type ,sep='')
        form = sprintf(file_to, k)
        write.table(LIST_OF_PARTITIONED_DATASETS[[k]], file = form, sep= "," , col.names = FALSE)
      }
    }
  }

# EXAMPLE (WILL NOT RUN AS INTENDED)

# AA = "...\\DIRECTORY OF COUNTY FILES\\"
# BB = "...\\DIRECTORY OF TO STORE NEW FILES\\"
# CC = "ADDITIONAL NAME TO FOR SPECIFICATION if not wanted just type in '' "

partition_list(COUNTY_LIST = COUNTY_LIST, 
               path_from = AA , 
               path_to = BB , 
               name_of_file1 = CC, 
               file_type = ".csv", 
               chunk = 10000,
               a = 1, 
               z = 4)
