
# ABOUT: Insert all code relevant and code that is buggy.

# Create a dataframe, states as a column name
# Counties are row elements corresponding to their state

# Once above is created, read.csv it
countynames <- read.csv("C:\\Users\\M.M\\Desktop\\2018 Elections\\County Names.csv", sep=",")
# error: cannot open file 'C:\Users\M.M\Desktop\2018 Elections\County Names.csv': No such file or directoryError in file(file, "rt") : cannot open the connection

# This needs work
# Can we just immediately get all counties at the very least? Needs to be tested
# Can we create a really large object called tracts_STORE?
for(i in 1:ncol(state.name)){
  for(j in 1:nrow(county_name_in_state[i,j]))
    tracts_STORE <- tracts(state = state.name[i], county = county_name[j], cb=TRUE)
}


####################################
NEW ISSUES THAT NEED FIXING BELOW
####################################

