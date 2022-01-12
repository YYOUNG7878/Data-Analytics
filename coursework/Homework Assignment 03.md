
# Homework Assignment 3

Due Date: 09/27/2021 6:00 PM

This assignment’s output will be a Google Document that you will have to share in the **#homework** slack channel on the due date. Please make sure that it is readable and well-formatted. All code needs to be in text format (not just a screen shot) and it should run on PostgreSQL without an error to receive full marks.

Posting an error message as a resolution to an exercise will yield 0 for the particular exercise. Research the error and use the resources offered by the class to resolve it.

 1. Exercise

During our last session we learned about a new Google Spreadsheet: [MATH_290_Knowledge_Base](https://docs.google.com/spreadsheets/d/1cTduVN-MqKQnQ6DTwRQYigieR1N7aov7YIvcbDXLXQ0/edit?usp=sharing). The aim of this sheet is to track our experience throughout the semester. It has four sheets:
 - `creators`: the primary key is the id column and relation has first_name, last_name, creator_name, and operating_system attributes. It has one row for every person who would create content in the Google Sheet. It has no foreign keys.
 - `errors`: the primary key is the id column and the relation has reporter_id, reported_date, error_message, short_description, and link_to_error_write_up attributes. The relation has one tuple for every error a creator experienced.  Reporter_id is the foreign key referencing the id field in the `creators` table. 
 - `error_resolution`: the primary key is the id column and the relation has error_id, reporter_id, resolution_link attributes. The relation has one tuple for every resolution a creator has reported.  It has two foreign keys error_id and reporter_id. Error_id references the id field in the `errors` relation and reporter_id references the id field in the `creators` relation.
 - `learning_point`: the primary key is the id column and the relation has creator_id, concept_name, short_description, link_to_explanation_document attributes. The relation has one tuple for every learning point a creator posted. It has a foreign key creator_id referencing the id field in the `creators` relation.

We are **not** going to create a schema for these relations in this homework on your local DB.

Your first task is to fill in your operating system in the `creators` table.

Once done, think back to your experience in HW02 and pick an error message you have experienced (preferably one you have actually resolved) and create a write up of the error and its resolution. 

Once done with the writeup populate the `errors` and the `error_resolutions` tables as indicated above.

Everybody should have at least one error documented.

2. Exercise

In exercise 5 of the previous homework you imported the [2018 Yello Yellow Taxi Fare] (https://data.cityofnewyork.us/Transportation/2018-Yellow-Taxi-Trip-Data/t29m-gskq) dataset using the COPY command. If you haven't managed it using the server-side COPY command try importing it the client-side UI approach (importing it using the DBeaver GUI as you have done it in HW01).
Use the usual channels of asking for help if you run into any issues. We are going to be using this table for the rest of the homework. 

I used this(create_table_2018_Yellow_Taxi_Trip_Data.sql) schema definition script to create the 2018_Yellow_Taxi_Trip_Data table 

And I used this (windos_copy_import_table_2018_Yellow_Taxi_Trip_Data.sql) command on a Windows machine to import the file.

If you are working on a Linux or Mac you have two options:
 - use the UI to import the file if you haven't done it in the previous exercise
 - use gzip and zip up the downloaded csv then use mac_copy_gzip_import_table_2018_Yellow_Taxi_Trip_Data.sql file


3. Exercise

Let's write a couple of SELECT statements against this large dataset that is now in your database.

The code below will return the count of rows you have imported.

    select count(*) as observation_count from "qcmath290"."public"."2018_Yellow_Taxi_Trip_Data"

Cross reference this count with the approximate record count found on the [NYC Open Data page](https://data.cityofnewyork.us/Transportation/2018-Yellow-Taxi-Trip-Data/t29m-gskq)

It is a good best practice to check if the entireity of your dataset have imported or not.

4. Exercise
One aspect of a primary key is that it is unique. Let's check if the vendor_id could be a candidate to be a primary key by checking if it is unique.

`select count(distinct  "vendorID") from "qcmath290"."public"."2018_Yellow_Taxi_Trip_Data"`

Based on these two numbers do you think vendorID is a good candidate for being primary key?

