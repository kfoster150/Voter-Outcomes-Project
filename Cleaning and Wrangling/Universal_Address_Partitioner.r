# This will read in directories of where to read and write files
# This will partition csv files into smaller chunks
# Select the start and end columns representing address (apt or what not included as a single column with space), city/town, state, zip.

# We want to abstract to read to any county in a loop
COUNTY_LIST <- c('ADAMS', 'ALLEN', 'ASHLAND', 'ASHTABULA','ATHENS', 'AUGLAIZE','BELMONT', 'BROWN', 'BUTLER', 'CARROLL', 'CHAMPAIGN',  'CLARK',  'CLERMONT', 'CLINTON', 'COLUMBIANA',  'COSHOCTON',  'CRAWFORD',  'CUYAHOGA',  'DARKE', 'DEFIANCE', 'DELAWARE', 'ERIE',  'FAIRFIELD',  'FAYETTE','FRANKLIN',  'FULTON', 'GALLIA', 'GEAUGA', 'GREENE', 'GUERNSEY',  'HAMILTON', 'HANCOCK', 'HARDIN', 'HARRISON', 'HENRY', 'HIGHLAND', 'HOCKING',  'HOLMES', 'HURON',  'JACKSON', 'JEFFERSON',  'KNOX',  'LAKE', 'LAWRENCE',  'LICKING',  'LOGAN', 'LORAIN',  'LUCAS',  'MADISON','MAHONING',  'MARION', 'MEDINA', 'MEIGS',  'MERCER', 'MIAMI',  'MONROE',  'MONTGOMERY', 'MORGAN',  'MORROW', 'MUSKINGUM',  'NOBLE',  'OTTAWA', 'PAULDING', 'PERRY', 'PICKAWAY', 'PIKE',  'PORTAGE', 'PREBLE', 'PUTNAM', 'RICHLAND',  'ROSS', 'SANDUSKY','SCIOTO', 'SENECA','SHELBY', 'STARK', 'SUMMIT', 'TRUMBULL', 'TUSCARAWAS', 'UNION', 'VANWERT', 'VINTON', 'WARREN', 'WASHINGTON', 'WAYNE', 'WILLIAMS', 'WOOD', 'WYANDOT')

# COUNTY_LIST - vector of names of counties
# path_from - folder of csv files to read
# path_to - folder to save geocode
# name_of_file1 - "MONTH YEAR" - To indicate the relevance of the dataset
# default file_type = .csv
# chunk - 10000 is the default, good for geocoding
# a = 10 - start of address column for Ohio, can be changed to suit state
# z = 14 - end of address column for Ohio, can be changed to suit state

path_from = "C:\\Users\\M.M\\Desktop\\States 2016-2018\\Ohio July 2018\\Ohio VF\\"
path_to = "C:\\Users\\M.M\\Desktop\\States 2016-2018\\Ohio July 2018\\Ohio to Geocode\\"
name_of_file1 = "Ohio July 2018"
file_type = '.csv'
chunk = 10000
a=10
z=14

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

AA = "C:\\Users\\M.M\\Desktop\\States 2016-2018\\Ohio July 2018\\Ohio VF\\"
BB = "C:\\Users\\M.M\\Desktop\\States 2016-2018\\Ohio July 2018\\Ohio to Geocode\\"
CC = "Ohio July 2018"

partition_list(COUNTY_LIST = COUNTY_LIST, path_from = AA , path_to = BB , name_of_file1 = CC, file_type = ".csv", chunk = 10000, a = 10, z = 14)
