# Homework Assignment 5

Due Date: 10/11/2021 6:00 PM

Please check all homework assignments into GitHub according to the steps described in Exercise 5. You will be required to check-in two files:
 - A markdown (.md) file for explaining your code 
 - A SQL (.sql) file that will run without error in PostgreSQL

As always, if you experience an error message, write it up and record your work in the [MATH_290_Knowledge_Base](https://docs.google.com/spreadsheets/d/1cTduVN-MqKQnQ6DTwRQYigieR1N7aov7YIvcbDXLXQ0/edit?usp=sharing). 

Almost everybody in the class should have imported the [2018 Yellow Taxi Fare](https://data.cityofnewyork.us/Transportation/2018-Yellow-Taxi-Trip-Data/t29m-gskq). We will be exploring this dataset. If, for any reason, you could not get the dataset imported, attempt the exercise with the  [2020 Yellow Taxi Fare](https://data.cityofnewyork.us/Transportation/2020-Yellow-Taxi-Trip-Data-January-June-/kxp8-n2sj) dataset instead.

Please indicate if you were using the 2020 dataset in your answers. Also, some of you will be working with a truncated (incomplete dataset), please note that when you submit your asnwers.

1. Exercise 
 
 Download and install [PowerBI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494) and  create an [AWS account](https://portal.aws.amazon.com/billing/signup#/start). 

2. Exercise

Calculate the number of trips by vendorID by hour(based on drop_off_date) in 2018.

Using the previous query, what was the daily(based on drop_off_date) mean, median, minimum, and maximum number of trips by vendorID in 2018?  

|drop_off_date|vendor_id| min_cnt_trip| mean_cnt_trip| max_cnt_trip|
|--|--|--|--|--|
|2018-01-01  |1  |4  |
|2018-01-01  |2  |5  |
...

What is the mean, median, minimum, and maximum trip_distance by vendor between 5:00 and 6:00 AM (not including 6:00 AM)?

What day in 2018 had the least / most amount of unique trips?


Hint: There is no explicit median function in PostgreSQL. Use the [percentile_count](https://www.postgresql.org/docs/9.4/functions-aggregate.html) function instead.
3. Exercise

What was the average tip percentage (tip_amount/total_amount) for unique trips in 2018?

What was the average  tip percentage by drop off hour for unique trips in 2018?
|drop_off_hour_of_day| average_tip_percentage |
|--|--|
|0:00  |15%  |
|1:00  |8%  |

...


Hint: use the [EXTRACT](https://www.postgresql.org/docs/9.1/functions-datetime.html) function to get the hour of the day from your timestamp.

4. Exercise

Do longer trips have higher tip percentages?

Create a view called `daily_tip_percentage_by_distance`

|date|trip_mileage_band  | tip_percentage  |
|--|--|--|
|2018-01-01  |0-1 mile  | 15%
...

The mileage bands are:
 - 0-1 mile (not including 1)
 - 1-2 mile
 - 2-3 mile
 - 3-4 mile
 - 4 - 5 mile
 - 5+ miles

Hint: to calculate the trip_mileage_band use a [CASE](https://www.postgresqltutorial.com/postgresql-case/) statement
This code would need to be completed, however, it should give you a gist of how a CASE statement works.

    SELECT CASE WHEN trip_mileage >= 0 and trip_mileage < 1 then '0-1 mile'
                WHEN trip_mileage ...
                END as trip_mileage_band

5. Exercise
All your homework is going to be carried out in your local GitHub branch.

Create a branch called hw05_fname1_fname2 (use your and your buddy's actual first names).
![Create a branch in GitHub UI](https://github.com/bzombory/QC_Math_290_Fall_2021/blob/master/homework/hw05/images/create_branch.jpg)

Select your local branch.

![make sure local branch is selected](https://github.com/bzombory/QC_Math_290_Fall_2021/blob/main/homework/hw05/images/local_branch.jpg)

Create a folder under hw05 with your first names separated by an underscore (fname1_fname2). This is going to be your working directory.
![enter image description here](https://github.com/bzombory/QC_Math_290_Fall_2021/blob/main/homework/hw05/images/create_working_folder.JPG)

Commit your homework assignment to your local branch as you have done in your last homework.
![Start Pull Request](https://github.com/bzombory/QC_Math_290_Fall_2021/blob/main/homework/hw05/images/images/PR01.JPG)
Start a Pull Request (PR) 

Tag your buddy and me in it for comments, leave your comments, and click create a pull request.
![Tag Commenter](https://github.com/bzombory/QC_Math_290_Fall_2021/blob/main/homework/hw05/images/PR02.JPG)

If all goes well, you should see a screen showing your files and no conflict.
![enter image description here](https://github.com/bzombory/QC_Math_290_Fall_2021/blob/main/homework/hw05/images/Merge.JPG)
Once all comments are resolved, merge your pull request.

 



