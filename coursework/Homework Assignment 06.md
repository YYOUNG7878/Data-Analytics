# Homework Assignment 6

Due Date: 10/25/2021 6:00 PM

Please check all homework assignments into GitHub according to the steps described in HW05 Exercise 5. Please create your folder in your local branch as it was done in the previous exercise.  You will be required to check-in two files:
 - A markdown (.md) file for explaining your code 
 - A SQL (.sql) file that will run without error in PostgreSQL

As always, if you experience an error message, write it up and record your work in the [MATH_290_Knowledge_Base](https://docs.google.com/spreadsheets/d/1cTduVN-MqKQnQ6DTwRQYigieR1N7aov7YIvcbDXLXQ0/edit?usp=sharing). 

In this homework, you will download the [IMDB database](https://datasets.imdbws.com/), import it with the COPY command, and establish relationships between the tables primary and foreign keys. Once you successfully established the relationships between the tables, you will answer some questions regarding the dataset.

 1. Exercise 
Make sure you can log in to [app.powerbi.com/](http://app.powerbi.com/). 

 2. Exercise

In this exercise, you will download and import the TSV files into pre-created tables in Postgres. After you imported the tables, you will export them into CSV.

Step 1: Download the [IMDB database](https://datasets.imdbws.com/) files and unzip them.

Step 2: Create a database called *IMDb* in your Postgre instance.
Use the `CREATE DATABASE` command to do this.

Step 3: Create your target tables in the public schema by consulting the [IMDB database documentation](https://www.imdb.com/interfaces/) page to obtain the column names. Only use the column names, *ignore* the corresponding datatypes. When building your target schema, use the **varchar** datatype. I have provided an example of how to do this for the **title.akas.tsv.gz** file in the **create_titile_akas.sql** file.  Complete and run the create table scripts for the other six tables.  

Step 4: Use the `COPY FROM` command to import **title.akas.tsv** into the `title_akas` table in the `imdb` database. Below is my example:

    copy  imdb.public.title_akas from 'C:\Users\balaz\Documents\Teaching\Spring 2021\MATH 2902\Lecture 7\imdb\title_akas.tsv\data.tsv' delimiter E'\t';
Build your own example for the rest of the `imdb` tables.
This step is completed once every table is populated with values.

Step 5: Take a look at your tables with a select statement and see if you notice something strange. Use the `DELETE` statement to correct the unintended row in each table. 
Hint: compare the column names and the values of the first row. 

Step 6: Use the `COPY TO` to export all your tables into CSV. Here is how to do it for the `title_akas` table.

    COPY title_akas(titleId, ordering, title, region, language, types, attributes, isOriginalTitle) 
    TO 'C:\Users\balaz\Documents\Teaching\Spring 2021\MATH 2902\Lecture 7\imdb\title.akas.tsv\title_akas.csv' DELIMITER ',' CSV HEADER;

3. Exercise

In this exercise, you will check the cardinality of each column, and based on this analysis and the IMDB database documentation; you will assign primary key constraints to each table. 

Step 1: Calculate the cardinality of each column in each table. 

Step 2: Pick a candidate primary key in each table based on your analysis (remember, you may have a composite primary key). Check your analysis against the [IMDB database documentation](https://www.imdb.com/interfaces/).

Step 3: Using the `ALTER TABLE` statement to add a primary key constraint to each table. Here is an example of how the `title_akas` table's composite primary key should be added.

    ALTER TABLE imdb.public.title_akas ADD PRIMARY KEY (titleId, ordering);

This step is completed once you added a primary key for every table.


4. Exercise

In this exercise, you will learn how to detect foreign key relationships between two tables, and you will attempt to assign foreign key constraint to one of your tables.

Recall that to establish a primary key - foreign key relationship between two tables, all values of the child table's foreign key columns need to be represented in the parent table's primary key columns.

Example: Think about the student and the student interest tables in the class Google sheet. The student sheet is the parent table, and the student interest sheet is the child table. There shouldn't be a student interest that isn't associated with a particular student. If there were any, it would be a violation of the foreign key constraint.

Step 1: Use the `EXCEPT` set operation and count how many `tconst` values are presented in `imdb.public.title_ratings`
that aren't present in `imdb.public.title_basic`. 

Step 2: Calculate the same count but this time return the values of `tconst` column that are present in `imdb.public.title_basic`
but not in  `imdb.public.title_ratings`. 

Step 3: Use the `INTERSECT` operation to count how many records of `tconst` column show op in both `imdb.public.title_ratings` and `imdb.public.title_ratings` tables.

Step 4: Based on your analysis, which table should be the parent table and which table should be the child table?

Step 5: Attempt to use the `ALTER TABLE` statement to add a foreign key relationship between the two tables. 

Step 6: Did it work? Explain why or why not. 


5. Exercise

Log in to PowerBI cloud and upload the converted CSV files. Note that it will take time for the files to upload.

6. Exercise (extra credit)

If you have PowerBI desktop downloaded (Windows machines only), import the CSV files into PowerBI by clicking on **Get Data** menu and follow the prompts to import.
