## Making the data usable  
<br>
Upon first inspecting my data I found many columns that wouldn't be needed in my analysis for grass germination.  
**See 1.1.sql**  
<br>
I then renamed my columns so I could more easily work with the data.  
**See 1.2.sql**  
<br>
I changed values in column 'sky' from METAR codes to weather conditions since I wasn't  
familiar with the codes and I wanted my data to be easy to read.  
I first grouped my data to see the counts of the codes. Then I dropped ones that were low (<5 occurrences in the last 10 years)  
I created a new grouping for the weather types and set them to:  
'hvy_precip', 'lt_precip' , 'med_precip', 'shaded', 'clear'  
**See 1.3.sql**  
<br>
I checked for NULL data (didn't have any), checked numerical columns for non-numeric values,  
Deleted missing data, and changed my column types to useful ones  
**See 1.4.sql**  
<br>
