'''
modified ohio/parse.py for florida. 
Parses Ohio voter file into csv files, one per county, does not work yet.
with the following variables:
'''

newvars = ["voter_id","Suffix","first_name","middle_name",\
           "last_name","gender","race","birth_date",\
           "registration_date","voter_status","party_affiliation",\
           "voter_status","party_affiliation","residential_address",\
           "City","Zipcode","Precinct","PrecinctGroup","PrecinctSuffix"]

################# correspondence of variables (0-index variables)
# voter_id = 1
# Suffix = 3
# first_name = 4
# middle_name = 5
# last_name = 2
# gender = 19
# race = 20
# birth_date = 21
# registration_date = 22
# voter_status = 27
# party_affiliation = 23.strip?
# residential_address = 7 + 8
# City = 10
# Zipcode = 11
# Precinct = 24
# PrecinctGroup = 25
# PrecinctSuffix = 26
# turnout2008 = '11/04/2008' in votes
# turnout2010 = '11/02/2010' in votes
# turnout2012 = '11/06/2012' in votes
# turnout2014 = '11/04/2014' in votes
# turnout2016 = '11/08/2016' in votes
#################
        
# voter file(s)
import os
vfsf = 'C:\\Users\\M.M\\Desktop\\States 2016-2018\\Florida May 2018\\20180612_VoterDetail\\'
vfs = os.listdir(vfsf)
vfs = [f for f in vfs if 'H_20180612.txt' in f]

print(vfs)

# outfolder
outfolder = 'C:\\Users\\M.M\\Desktop\\States 2016-2018\\Ohio July 2018'

county_keys = {}

county_keys["01"] ="ADAMS"     
county_keys["02"] ="ALLEN"     
county_keys["03"] ="ASHLAND"   
county_keys["04"] ="ASHTABULA" 
county_keys["05"] ="ATHENS"    
county_keys["06"] ="AUGLAIZE"  
county_keys["07"] ="BELMONT"   
county_keys["08"] ="BROWN"     
county_keys["09"] ="BUTLER"    
county_keys["10"] = "CARROLL"   
county_keys["11"] = "CHAMPAIGN" 
county_keys["12"] = "CLARK"     
county_keys["13"] = "CLERMONT"  
county_keys["14"] = "CLINTON"   
county_keys["15"] = "COLUMBIANA"
county_keys["16"] = "COSHOCTON" 
county_keys["17"] = "CRAWFORD"  
county_keys["18"] = "CUYAHOGA"  
county_keys["19"] = "DARKE"     
county_keys["20"] = "DEFIANCE"  
county_keys["21"] = "DELAWARE"  
county_keys["22"] = "ERIE"      
county_keys["23"] = "FAIRFIELD" 
county_keys["24"] = "FAYETTE"   
county_keys["25"] = "FRANKLIN"  
county_keys["26"] = "FULTON"    
county_keys["27"] = "GALLIA"    
county_keys["28"] = "GEAUGA"    
county_keys["29"] = "GREENE"    
county_keys["30"] = "GUERNSEY"  
county_keys["31"] = "HAMILTON"  
county_keys["32"] = "HANCOCK"   
county_keys["33"] = "HARDIN"    
county_keys["34"] = "HARRISON"  
county_keys["35"] = "HENRY"     
county_keys["36"] = "HIGHLAND"  
county_keys["37"] = "HOCKING"   
county_keys["38"] = "HOLMES"    
county_keys["39"] = "HURON"     
county_keys["40"] = "JACKSON"   
county_keys["41"] = "JEFFERSON" 
county_keys["42"] = "KNOX"      
county_keys["43"] = "LAKE"      
county_keys["44"] = "LAWRENCE"  
county_keys["45"] = "LICKING"   
county_keys["46"] = "LOGAN"     
county_keys["47"] = "LORAIN"    
county_keys["48"] = "LUCAS"     
county_keys["49"] = "MADISON"   
county_keys["50"] = "MAHONING"  
county_keys["51"] = "MARION"    
county_keys["52"] = "MEDINA"    
county_keys["53"] = "MEIGS"     
county_keys["54"] = "MERCER"    
county_keys["55"] = "MIAMI"     
county_keys["56"] = "MONROE"    
county_keys["57"] = "MONTGOMERY"
county_keys["58"] = "MORGAN"    
county_keys["59"] = "MORROW"    
county_keys["60"] = "MUSKINGUM" 
county_keys["61"] = "NOBLE"     
county_keys["62"] = "OTTAWA"    
county_keys["63"] = "PAULDING"  
county_keys["64"] = "PERRY"     
county_keys["65"] = "PICKAWAY"  
county_keys["66"] = "PIKE"      
county_keys["67"] = "PORTAGE"   
county_keys["68"] = "PREBLE"    
county_keys["69"] = "PUTNAM"    
county_keys["70"] = "RICHLAND"  
county_keys["71"] = "ROSS"      
county_keys["72"] = "SANDUSKY"  
county_keys["73"] = "SCIOTO"    
county_keys["74"] = "SENECA"    
county_keys["75"] = "SHELBY"    
county_keys["76"] = "STARK"     
county_keys["77"] = "SUMMIT"    
county_keys["78"] = "TRUMBULL"  
county_keys["79"] = "TUSCARAWAS"
county_keys["80"] = "UNION"     
county_keys["81"] = "VANWERT"   
county_keys["82"] = "VINTON"    
county_keys["83"] = "WARREN"    
county_keys["84"] = "WASHINGTON"
county_keys["85"] = "WAYNE"     
county_keys["86"] = "WILLIAMS"  
county_keys["87"] = "WOOD"      
county_keys["88"] = "WYANDOT"

# voters by county
counties = {}

# reading voter file 1
reader = csv.reader(open(vfsf))
vars = next(reader)
for row in reader:
    county = county_keys[row[1]]
    counties[county] = counties.get(county, 0) + 1
    
print(counties)

print(str(len(counties)) + ' counties')
# 88 counties

voters = sum(counties.values())
print(str(voters) + ' registered voters')
# 7,507,906 registered voters

# preparing empty files by county
for county in counties.keys():
    outf = open(outfolder + ' ' + county + '.csv','w', newline='')
    out = csv.writer(outf)
    out.writerow(newvars)
    outf.close()

# preparing empty dict for data
i = 0
data = {}
for county in counties:
    data[county] = []

# extracting voter variables into dict (file 1)
reader = csv.reader(open(vfsf))
vars = next(reader)

# I modified the column 

for row in reader:
    i += 1
    if i % 100000 == 0:
        print(str(i) + '/' + str(voters))
        address = row[7].strip() + ' ' + row[8].strip()
        values = [[row[1], row[3], row[4],row[5], row[2],
                  row[19],row[20],row[21],row[22],row[27],
                  row[23].strip(),address,row[10],row[11],
                  row[24],row[25],row[26],turnout2008, 
                  turnout2010,turnout2012,turnout2014, 
                  turnout2016]]
    
# writing to disk
for county in counties:
    outf = open(outfolder + ' ' + county + '.csv', 'w', newline='')
    out = csv.writer(outf)
    for row in data[county]:
        out.writerow(row)
outf.close()
