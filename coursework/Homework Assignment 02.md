
# Homework Assignment 2

Due Date: 09/20/2021 6:00 PM

This assignment’s output will be a Google Document that you will have to share in the **#homework** slack channel. Please make sure that it is readable and well-formatted.

1. Exercise

The class Google sheet has two new tabs: `homework_submission` and `homework`.

The `homework_submission` table records when a student turns in a particular assignment by establishing a relation between the `class_roster` and the `homework` tables. As a result, it has student_id, homework_id, and submission_date as attributes.

The `homework` table holds attributes on the homework (name, posted_date, and due date). Your first task is to look at the **#homework** Slack channel and populate the submission_date column in the `homework_submissions` table. Only do yours and your coding partner’s. Describe the steps you had to take to populate the field in your shareable document.

Hint: There are two ids, also known as foreign keys, in the `homework_submissions` table:
- student_id: references the id field in the `class_roster` table
- homework_id: references the id field in the `homework` table

In the previous homework, you have already created a schema with a primary key. Now, you are going to create a schema with both primary and foreign keys.

You will find the schema definition script for the `homework` and the `homework_submissions` tables in the *create_homework.sql* and *create_homework_submission.sql* files. These scripts establish the relationship between the `homework` and the `homework_submission` tables. Alter the *create_homework_submission.sql* script to reference the `class_roster` table as well.

Hint: you can find PostgreSQL documentation on how to do this [here](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-FK).

2. Exercise

Download the `class_roster`, `homework_submission`, and `homework` tabs.

Run the 3 create statements in the correct order that you created in Exercise 1.

Import the three tables into the `qcmath290` database. Please define the schema (write and run the CREATE TABLE statements) for the three tables (see HW01 for an example for a CREATE TABLE statement). Record your schema creation statements in the same shareable document.

Take a screenshot of the 3 tables and paste it into your document alongside the final create statements.

3. Exercise

When you import data to PostgreSQL, you instruct the RDBMS to store the source file’s copy as it sees fit. It will take the file from your source folder and move it into the location it manages on the filesystem. You can find out where this location is by running the following command in DBeaver: `show data_directory;`

Navigate to this location on the file system and note the size of the folder called “base”.

Go back to DBeaver and run the following command: `select * from pg_catalog.pg_stat_database;`

The above script will return two essential pieces of information: datid and datname. The former is the database id, and the latter is the corresponding database name. Take a note of the current size of the `qcmath290` database by finding the datid corresponding to `qcmath290` and checking the size of the folder (named after datid) in the base folder on your file system. Put the size of the db into the same shareable document.

4. Exercise

Using DBeaver's UI isn't the only way to import data into PostgreSQL. You can use the `COPY` command when working with large files. It is a bulk import SQL utility that allows you to import data with an SQL scritp.

Download the [2018 Yellow Taxi Fare dataset](https://data.cityofnewyork.us/api/views/t29m-gskq/rows.csv?accessType=DOWNLOAD).

While waiting on the file to download, create a schema for it. You will find useful informaiton for this task at the below two locations:

- [Data Dictionary](https://data.cityofnewyork.us/api/views/t29m-gskq/files/89042b9b-8280-4339-bda2-d68f428a7499?download=true&filename=data_dictionary_trip_records_yellow.pdf)

- [NYC Open Data page](https://data.cityofnewyork.us/Transportation/2018-Yellow-Taxi-Trip-Data/t29m-gskq)
  
Complete the COPY command to import the previously downloaded CSV into the defined schema.

    COPY TABLE_NAME (colmn_name1, column_name2)
    FROM 'filename' DELIMITER ' ';

Note: the above code needs to be altered to run. The TABLE_NAME (column_name1, column_name2) portion needs to be changed to the target schema you created for the dataset.

Copy and paste the completed code into your shareable document. Query the table and paste screenshots into your document.

Here is the [link](https://www.postgresql.org/docs/13/sql-copy.html) to the PostgreSQL documentation on the COPY command.

Since this is a massive CSV it is possible that you will max out your system resources. Once PostgreSQL (like any other RDBMS) gets hold of system resoures (like storage or RAM) it doesn't like to give it up. This means you would need to restart the Postgre Servie to force Postgres to yield back unused resources to the operating system.
Here is a [link] (https://tableplus.com/blog/2018/10/how-to-start-stop-restart-postgresql-server.html) on how to do this on Mac, Windows, or Linux.

  
5. Exercise

Repeat exercise 3 and see how the size of the PostgreSQL file have changed. Compare the size of the downloaded CSV (int step 5) and the size of the DB you inserted the data. Which one is bigger? Can you guess why?
Perovide the size of the csv and the corresponding database in your shareable document with your answer to the question.


6. Exercise

At the end of our first lecture, we briefly touched upon some data visualization concepts. The problem we discussed was how to visualize huge numbers. We looked at the example of 59 zettabytes (ZB) and tried to wrap our minds around it.

The below is an example of how you could create a meaningful visualization of this vast number.

1. Convert 59 ZB into something more manageable (TB is a good bet, it is the largest amount of data a layperson would be familiar with).
2. Go to [newegg.com](https://www.newegg.com/) and find the largest hard drive that money could buy.
3. Take any attribute of this hard drive (size or $ value, for example) and come up with a conversion. Your statement should be something like 59 ZB = $X given the current price of the largest hard disk money can buy.
4. Use this number and put it into context

The above is just one example meant to get your creativity going. Come up with a conversion of your own.

Copy and paste the visual you created into your shareable document.

7.  Exercise - Extra credit

Download and unzip the files of the [IMDB database](https://datasets.imdbws.com/)
Create a new database called imdb
Create the schema definition files associated with each and every table.
Import all tables into their corresponding table using the `COPY` command.


8. Exercise - Extra credit

Download the [Motor Carrier Census Information](https://ai.fmcsa.dot.gov/SMS/files/FMCSA_CENSUS1_2021Jan.zip) from the [FMCSA](https://ai.fmcsa.dot.gov/SMS/Tools/Downloads.aspx) website.

If you succeeded take a screenshot and paste it into your document.  

Try and import the file by using any means that are now familiar to you.

Do not spend too long on this exercise.

If you cannot solve it, document the issue you experienced clearly and describe what actions you think might help you solve it.
