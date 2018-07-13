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
