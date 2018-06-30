# This File was prepared by Kenneth Foster

setwd("--------insert working directory---------")

# Read in the dataset
votes <- read.csv("CA-County-Orange-VH.csv", header = TRUE)

# Create two subsets for testing cleaning methods
votes.a <- votes[1:1000,]
votes.b <- votes[2001:3000,]

# Subset the variables, since we already know the country, state, and county we're looking at
votes.a2 <- subset(votes.a, select = -c(registered_address_country_code,ballots__state,registered_address__state))
votes.b2 <- subset(votes.b, select = -c(registered_address_country_code,ballots__state,registered_address__state))

library(tidyr)
library(dplyr)

# Use spread() to expand the election timing into a wide set of variables
votes.a3 <- spread(votes.a2, election_at, vote_method, sep = ".", fill = 0)

# Convert values into 0 if a vote did not occur in that cell, 1 if any type did.
votes.a3[,3:61] <- ifelse(is.na(votes.a3[,3:61]), 0,1)

# Remove election period (for now) in order to aggregate the data
votes.a4 <- subset(votes.a3, select = -election_period)
votes.a4 <- aggregate(. ~ state_file_id, data = votes.a4, FUN = sum)

# Now we have a simplified dataset. Each file id is a person and each variable shows an election date with a 1 or 0 to indicate if they voted or not.

# SPARE CODE - This is used to create sums of how many times a critter participated in various kinds of elections. It hasn't been integrated into the rest of the code.
votes.a3$general <- ifelse(votes.a3$election_period == "General", rowSums(!is.na(votes.a3[3:61]), na.rm = TRUE, dims = 1),NA)
votes.a3$other <- ifelse(votes.a3$election_period == "Other", rowSums(!is.na(votes.a3[3:61]), na.rm = TRUE, dims = 1),NA)
votes.a3$president <- ifelse(votes.a3$election_period == "Presidential Primary", rowSums(!is.na(votes.a3[3:61]), na.rm = TRUE, dims = 1),NA)
votes.a3$primary <- ifelse(votes.a3$election_period == "Primary", rowSums(!is.na(votes.a3[3:61]), na.rm = TRUE, dims = 1),NA)
votes.a3$special <- ifelse(votes.a3$election_period == "Special", rowSums(!is.na(votes.a3[3:61]), na.rm = TRUE, dims = 1),NA)
votes.a3$recall <- ifelse(votes.a3$election_period == "Recall", rowSums(!is.na(votes.a3[3:61]), na.rm = TRUE, dims = 1),NA)
