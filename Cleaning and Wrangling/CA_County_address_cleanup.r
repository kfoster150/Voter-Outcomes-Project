
#Load the File
VF_data <- read.csv(file = "load your file source here")

# Cleaning code
## Source: https://stackoverflow.com/questions/13673894/suppress-nas-in-paste

paste2 <- function(...,sep=", ") {
    L <- list(...)
    L <- lapply(L,function(x) {x[is.na(x)] <- ""; x})
    gsub(paste0("(^",sep,"|",sep,"$)"),"",
                gsub(paste0(sep,sep),sep,
                     do.call(paste,c(L,list(sep=sep)))))
}

# Address
VF_data$full_registered_address <- paste2(VF_data$registered_address__address1,VF_data$registered_address__address2,sep = " ")

# I had to do this one at a time because for some reason, city and state kept mutating to numbers.
df_file <- as.data.frame(VF_data$full_registered_address)
df_file[,2] <- VF_data$registered_address__city
df_file[,3] <- VF_data$registered_address__state
df_file[,4] <- VF_data$registered_address__zip
a = 1# Beginning of address
z = 4 # End of address
chunk = 10000

# Subset the file to the areas of interest
df_file <- df_file[,a:z]
  
# You want to partition and create csv
    
# How many rows are there in your data file?
df_file_rows <- nrow(df_file)
      
# This will help partition the 
df_file_r <- rep(1:ceiling(df_file_rows/chunk), each = chunk)[1:df_file_rows]
      
# Put the datasets into rows
LIST_OF_PARTITIONED_DATASETS <- split(df_file, df_file_r)

# Specify the address before the loop
path_to = 'INSERT LINK WHERE YOU WANT TO PUT IT'
name_of_file1 = '_OC_County_CA'
file_type = '.csv'

# Create Files
for(k in 1:length(LIST_OF_PARTITIONED_DATASETS)){
  #assign a designated file address for the k-th dataframe 
  file_to <- paste0(path_to,"Geocode ",name_of_file1," "  
              ,".%d",file_type ,sep='')
  # formatting before writing table
  form = sprintf(file_to, k)
  # Write table
  write.table(LIST_OF_PARTITIONED_DATASETS[[k]], file = form, sep= "," ,col.names = FALSE)
}
