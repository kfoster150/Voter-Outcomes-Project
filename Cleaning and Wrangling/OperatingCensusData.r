setwd('C:\\Users\\M.M\\Desktop\\States 2016-2018\\Ohio July 2018\\OHIO_COUNTIES\\')
library(foreign)
OH_PVI <- read.csv("PVI_OH.csv",header=FALSE)

Symbols2016 <- gsub("[[:digit:]]","",OH_PVI$V4)
Raw2016 <- gsub("[^[:digit:]]","",OH_PVI$V4)
OH_PVI$Raw2016 <- ifelse(Symbols2016 == "R+",as.numeric(as.character(Raw2016)),-1*as.numeric(as.character(Raw2016)))

County_Data <- read.csv("ACS_16_5YR_S0701_with_ann.csv",header=TRUE)
County_Variable_Detail <- as.data.frame(t(as.vector(County_Data[1,])))
County_Variable_Detail <- cbind(1:nrow(County_Variable_Detail),County_Variable_Detail)
County_Data <- County_Data[2:nrow(County_Data),]

OH_PVI[,6] <- as.numeric(as.character(County_Data[,104]))
OH_PVI[,7] <- as.numeric(as.character(County_Data[,105]))

OH_PVI[,8] <- County_Data[,104]
OH_PVI[,9] <- County_Data[,105]
summary(lm(OH_PVI$Raw2016~OH_PVI[,8]))

summary(lm(data = OH_PVI, formula = Raw2016~HC01_EST_VC13))
