# Clean PVI Assumption (Democratic Numbers, Republicans Positive Numbers to maintain left right model we are used to in Political Science)
County_PVI <- read.csv("C:\\Users\\M.M\\Desktop\\2018 Elections\\County PVI.csv")

colnames(County_PVI) <- c("State", "County", "PVI2012", "PVI2016")

# We first want to extract the party labels
County_PVI$Party2012 <- gsub("[[:digit:]]","",County_PVI$PVI2012)
County_PVI$Party2016 <- gsub("[[:digit:]]","",County_PVI$PVI2016)
# We then want to extract the numbers
County_PVI$Point2012 <- gsub("[^[:digit:]]","",County_PVI$PVI2012)
County_PVI$Point2016 <- gsub("[^[:digit:]]","",County_PVI$PVI2016)

# We then want to assign scores of 1 if Republican, 0 if Even and -1 if Democrat for both years
County_PVI$party_standard2012 <- ifelse(County_PVI$Party2012 == "EVEN", 0, 
                                   ifelse(County_PVI$Party2012=="R+",1,-1))
County_PVI$party_standard2016 <- ifelse(County_PVI$Party2016 == "EVEN", 0, 
                                   ifelse(County_PVI$Party2016=="R+",1,-1))

# Before using as.numeric, use as.character when dealing with factor variables. 
# Otherwise values will change.
County_PVI$Converted2012 <- as.numeric(County_PVI$party_standard2012)*as.numeric(as.character(County_PVI$Point2012))
County_PVI$Converted2016 <- as.numeric(County_PVI$party_standard2016)*as.numeric(as.character(County_PVI$Point2016))

# Write a file
# write.csv(County_PVI, file = "C:\\Users\\M.M\\Desktop\\2018 Elections\\County_PVI.csv")
