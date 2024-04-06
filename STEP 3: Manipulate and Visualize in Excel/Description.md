To explore the Excel Workbook instead of seeing the steps listed out, download the excel file from the repository's main page.<br>
<br>
I will describe the path of the day data. I followed similar paths for the night data as well as the 24hr day data.
<br>
<br>

## Created 3 sheets for different groups of data
<br>

### The first sheet was 'Day' and started as a copy of the cleaned data.
<br>
I added a helper column to the end with formula =ISODD(ROW()) on all values.<br>
I used that column as a filter and set it to filter for "False".<br>
I was left with all the columns with time_period = 'Night' so I selected all the rows and deleted them.<br>
I then deleted my filter to be left will all "Day" data.<br>
I added two columns on my table that would populate with seed germination temperature low and high values that I can add onto my graph.<br>
  - These columns will use VLOOKUP to grab their temperatures based on a user selected grass type in a dropdown list.<br>
I added a column in front of my table that would check if the date in a row is within the user selected date range.<br>
  - This column used an IF(AND()) statement to assign a 'Y' or 'N' to the row depending on if it was in the date range or not.<br>
I then added a final column to the left of that which would assign a number to each accepted value, or set unaccepted values to 0.<br>
  - This is what will be used for VLOOKUP in my next filtering sheet.<br>
<br>

### I followed the same steps on another sheet for night values.<br>
<br>

### The 24 hour day sheet '24hr' had a few differences.
<br>
For this sheet I followed a similar process but before starting the process I filtered by the =ISODDD(ROW()) function again.<br>
I then set all the even rows to be the average of themselves and the next odd row. This combined my data.<br>
Then I filtered the odd rows and deleted them all, leaving myself with just the combined data.<br>
I then followed the same steps as the previous sheets.<br>
<br>

## Next I created 3 new sheets to filter the data.<br>
<br>

I copied over my first row of column names into the new sheet from 'Day' and called this sheet 'DayFilter'.<br>
I created a column that would assign the numbers from the accepted values in the 'Day' sheet to rows on 'DayFilter'.<br>
To populate the cells of the table I used VLOOKUP to use the row's number that was assigned, compare it to the data on 'Day', compare<br>
the current column name to the column names on 'Day', grab the value for the cell, and finally return no value if there was an error.<br>
This populated my filter table and made it dynamic based on user selections.<br>
I followed a similar process for 'NightFilter' and '24hrFilter'.<br>
<br>

## I then created tables to help with user selection.<br>
<br>

I created sheet 'Grass' with the grass types and their minimum and maximum temperatures for germination.<br>
  - This table would be used in a VLOOKUP for my data tables to grab the germination range based on the user selected grass type.<br>
  
I created sheet 'Months' with the month name and the corresponding first date in the month.<br>
  - This would be used to get the range of dates based on a user selected month.<br>
<br>

## Lastly I created dashboards with visuals.<br>
<br>

I made 4 graphs using 'DayFilter' so that my graphs would be dynamic and change with user selection.<br>
  - The graphs were taken with the date data along with the columns of their type of data: 'temp', 'dwpt', 'relh', or 'wind'.<br>
I created a band that highlighted the space between lowest and highest average recorded by creating a stacked area chart and setting the lower value to 'no fill'.<br>
I used the 'avg' for each type to create a line going through the band.<br>
I colored and adjusted titles to make the charts look nicer.<br>
I added 3 dropdowns for users to select grass type, start date, and end date.<br>
I added small pictures to represent the other dashboards and linked the pictures to the other sheets for easy navigation.<br>
<br>
The same steps were followed for the night and 24 hour dashboards.<br>
