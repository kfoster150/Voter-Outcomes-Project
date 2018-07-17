# County FIPS data
COUNTY_FIPS <- read.csv("C:\\Users\\M.M\\Desktop\\2018 Elections\\County\\CountyFips.csv")
# County PVI data
COUNTY_PVI <- read.csv("C:\\Users\\M.M\\Desktop\\2018 Elections\\County PVI Raw.csv")
# EMPLOYMENT_INCOME_WELFARE_HEALTH data
EMPLOYMENT_INCOME_WELFARE_HEALTH <- read.csv("C:\\Users\\M.M\\Desktop\\2018 Elections\\County\\EMPLOYMENT_INCOME_WELFARE_HEALTH.csv")

# REMOVE FIRST ROW SINCE ITS LABELS
EMPLOYMENT_INCOME_WELFARE_HEALTH <- EMPLOYMENT_INCOME_WELFARE_HEALTH[2:821,]

# Paste for matching
COUNTY_FIPS$FullName <- paste0(COUNTY_FIPS$Name, " " , COUNTY_FIPS$State)
County_PVI$FullName <- paste0(County_PVI$County, " ", County_PVI$State)

# Create Column names for COUNTY_FIPS files
colnames(COUNTY_FIPS) <- c("FIPS","Name","State","FullName")

# Assign FIPS to County PVI based on FullName Condition
Conditional <-  County_PVI$FullName %in% COUNTY_FIPS$FullName
County_PVI$FIPS <- if(Conditional){
    COUNTY_FIPS$FIPS
}

# MERGE THEM BASED ON SIMILAR VECTOR IDENTITIES WITHIN EACH DATAFRAME
COUNTY_DATA <- merge(County_PVI, COUNTY_FIPS, by.x="FullName", by.y="FullName", all.x=TRUE)

# Subset the Data on what we need
COUNTY_DATA <- COUNTY_DATA[,1:14]

#write.csv(COUNTY_DATA, file = "C:\\Users\\M.M\\Desktop\\2018 Elections\\County_Data.csv")

COUNTY_DATA <- read.csv("C:\\Users\\M.M\\Desktop\\2018 Elections\\County_Data.csv")

colnames(COUNTY_DATA) <- c("FullName", "State.x", "County", "PVI2012","PVI2016",       "Party2012","Party2016","Point2012","Point2016","party_standard2012",
"party_standard2016", "Converted2012","Converted2016","GEO.id2") 


RegressionTestData <- merge(COUNTY_DATA, EMPLOYMENT_INCOME_WELFARE_HEALTH, by.x = "GEO.id2", by.y ="GEO.id2", all.x = TRUE)

data <- RegressionTestData[complete.cases(RegressionTestData), ]

data$HC01_VC11 <- as.numeric(as.character(data$HC01_VC11))
data$HC02_VC41 <- as.numeric(as.character(data$HC02_VC41))

lm(data$Converted2016 ~ data$HC01_VC11+data$HC03_VC11+data$HC01_VC12)

