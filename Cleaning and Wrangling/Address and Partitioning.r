# https://stackoverflow.com/questions/13673894/suppress-nas-in-paste
paste2 <- function(...,sep=", ") {
    L <- list(...)
    L <- lapply(L,function(x) {x[is.na(x)] <- ""; x})
    gsub(paste0("(^",sep,"|",sep,"$)"),"",
                gsub(paste0(sep,sep),sep,
                     do.call(paste,c(L,list(sep=sep)))))
}


# Create a new variable called full_registered_address without apartment/unit specifier. 
VF_data_full$full_registered_address <- paste2(VF_data_full$registered_new_address,
                                               VF_data_full$registered_address__city,
                                               VF_data_full$registered_address__state,
                                               VF_data_full$registered_address__zip, sep = ", ")

# Transfer that list over 
full_registered_list <- VF_data_full$full_registered_address

# Turn that list to a dataset
full_registered_list <- as.data.frame(full_registered_list)

# Separate according to the requirements
full_registered_list <- separate(full_registered_list, 
                                  col = full_registered_list, 
                                  into = c("street","city","state","zip"), 
                                  sep = ",")

# There are 1143 rows without addresses that need to be accounted for later.
# Expected 4 pieces. Missing pieces filled with `NA` in 1143 rows [3934, 4318, 4494, 4584, 5140, 9547, 9590, 10899, 10944, 11006, 11306, 11872, 11926, 12118, 13229, 13266, 19933, 19984, 23580, 24134, ...].

# Add column for row numbers
full_registered_list <- cbind(1:nrow(full_registered_list), full_registered_list)

# We want to partition by 10000
chunk <- 10000
n <- nrow(INSERT_DATASET_HERE)
r <- rep(1:ceiling(n/chunk), each = chunk)[1:n]
LIST_OF_PARTITIONED_DATASETS <- split(INSERT_DATASET_HERE, r)

# Run this loop
for(i in 1:52){
  form = sprintf('SPECIFY FOLDER HERE!!!!! \\AddressToGeocode.2.%s.csv', i)
  write.csv2(LIST_OF_PARTITIONED_DATASETS[[i]], file = form)
}
