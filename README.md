# Voter Outcomes Project
Repo Objective: The repository commits itself to curating election outcomes data by integrating precinct level data and various levels of census tract as well as auxilliary files that prove to be useful in forecasting election outcomes and examining covariates of interest.

The only way these datasets can be useful for future research projects in the realm of Voter Outcomes in the United States (at the very least) is if it becomes easy to contribute more data from past census and election results. This implies that a good portion of data cleaning and wrangling code will be written to making sure that the process is independent of year. This can only be improved with time, since census estimations may differ from year to year as well as changes to what is asked.

# Files
Our Code of Conduct.md - Reasonable rules so we won't get sued or suffer unnecessary issues.

README.md - About repository, its goals and File descriptions.

links.md - Data Source List, Team Members, List of Coding Packages Used and URLs.

## Cleaning and Wrangling 

Gender Prediction.rmd - Created to assign gender to observations in datasets where the variable is missing.

VH-Cleaning-and-Wrangling.R- Cleaning and Wrangling of support file in a time series format that takes year of vote and type of vote into consideration.

Applied Regionalization.rmd - Created to account for high Margin of Error in the tract level and block level data.

## GIS Resources
2014 Precinct Tracts
2016 Precinct Tracts
2018 Precinct Tracts

## Econometrics Resources
links.md - name and link to papers and maybe a description of the paper to save time. Particularly, answer - Why is this useful to our voter outcomes project?
Or alternatively, pdfs if possible with a description as to why its useful in the commit changes extended description section.

## Political Science Resources
links.md - - name and link to papers and maybe a description of the paper to save time. Particularly, answer - Why is this useful to our voter outcomes project or to a related project?
Or alternatively, pdfs if possible with a description as to why its useful in the commit changes extended description section, especially if they are for paywall articles.

## Covariates

Covariates.md - two types (Traditional (t), Treatment (e)) used to forecast election results from the US Census as well as other sources such as interest rates. Some of these covariates might have authors and publications attached to them if they are mentioned either as a main variable of interest or as a control. (main variable of interest (i) or control variable (cv))

Example: 
	average_income_tract - (Smith, 1999,e,i), (Adams, 2000, t, i), (Douglas, 2000, t,cv) 

# Research/Project Ideas Related to the Voter Outcomes Project and About

## Political Science Research on the Feasibility and Quality of the Method of Regionalization to Account for High Margin of Error in Census Tract and Block Level Data (Current)
- Mel Maniwan

## Political Science Research on Voter Behavior Based on Industry Affiliation and Rank of Workers (Current)
- Mel Maniwan and Lorenzo Giamartino

## Psephology - Predicting the 2018 Congressional Races - A Case Study of Orange County Voting Outcomes (Current)
- Mel Maniwan, Kenneth Foster, Wesley Bridle, Lorenzo Giamartino

## Psephology - Extending the 2018 OC Congressional Predictions to the Battleground Congressional Districts (Queue)
- Mel Maniwan, Kenneth Foster, Wesley Bridle, Lorenzo Giamartino

## Psephology - Examining Past Presidential and Congressional Elections (Queue)
- Mel Maniwan

## Political Science Research on Voter Behavior Given Economic Political Signals (Queue)
- Mel Maniwan 

## Psephology - Predicting the 2020 Presidential and Congressional Races - National Case Study (Queue - Mid 2019)
- Mel Maniwan 

