

# Homework Assignment 7

Due Date: 11/01/2021 6:00 PM

Please check all homework assignments into GitHub according to the steps described in HW05 Exercise 5.  You will be required to check in two files:
 - A markdown (.md) file for explaining your code 
 - A SQL (.sql) file that will run without error in PostgreSQL

As always, if you experience an error message, write it up and record your work in the [MATH_290_Knowledge_Base](https://docs.google.com/spreadsheets/d/1cTduVN-MqKQnQ6DTwRQYigieR1N7aov7YIvcbDXLXQ0/edit?usp=sharing). 

You will be working with the previously downloaded [IMDB database](https://datasets.imdbws.com/).

 1. Exercise 
When you imported the IMDB tables in the last homework, we used varchar values for every destination table. We did this because we wanted to ensure that the COPY command doesn't run into data integrity errors. These tables with varchar data types don't lend themselves well for future analysis. We will create a view for each table where we ensure that the data types are more conducive to analysis.  

Step 1: Run the script below to make sure that all fields are varchar values in your first table (title_basic)

        select table_name, column_name, data_type 
        from IMDB.information_schema.columns
        where  table_schema = 'public' and table_name = 'title_basic';

Step 2: With the help of the online [IMDB documentation](https://www.imdb.com/interfaces/) create views for every table where you cast every column to the matching target data type.
Below you can see the title_basic view as an example.

    create view imdb.public.etl_title_basic_v
    as
    select 
     tb.tconst
    ,tb.titletype
    ,tb.primarytitle
    ,tb.originaltitle
    ,cast(tb.isadult as boolean) as isadult
    ,cast(tb.startyear as integer) as startyear
    ,cast(tb.endyear as integer) as endyear
    ,cast(tb.runtimeminutes as integer) as runtimeminutes
    ,regexp_split_to_array(tb.genres,',')::varchar[] as genres       
    from imdb.public.title_basic tb;

Keep the title_akas.types column as varchar for the time being.

Notice that the last column, `genres`, is of a data type array in the document. We had it import it as regular text. However, it can be interpreted as a comma-separated array. Here I used the [regexp_split_to_array](https://www.postgresql.org/docs/9.4/functions-string.html)  function to turn the varchar string into an array. The function requires a varchar column and a separator as input to produce the array.

Have a separate SQL file for every table.

Step 3: Create a physical table using the views from step 2. Use the `xf_` prefix to differentiate these new tables (with the correct data types) from the raw imported tables.

    create table imdb.public.xf_title_basic
    as
    select * from imdb.public.etl_title_basic_v;

Step 4: Use the `ALTER TABLE` statements from the previous homework to establish the primary and foreign key relationships.
 
 2. Exercise

Now that all of our tables are in the correct data type, let's try and answer the following questions:

Question 1:  How many movies are in the `xf_title_basic` table with runtimes between 42 and 77 minutes?
Question 2: What is the average runtime of movies for adults?
Question 3: Without running the SQL below, what number should it return? In other words, what is the cartesian product of the xf_title_basic table with itself?

    select count(*) from (
    select xtb_a.runtimeminutes, xtb_b.runtimeminutes
    from imdb.public.xf_title_basic xtb_a, imdb.public.xf_title_basic xtb_b
    )x;
Why do you think it is advised against running the above query?

Question 4: Calculate the average runtime (rounded to 0 decimals) of movies where the genre's first element is 'Action'.
(Hint: the first element of an array in Postgres can be referenced like this: array_name[1])
How many of all moves in the `xf_title_basic` has the previously calculated average runtime? 

Question 5: What is the relative frequency of each distinct genre array (combination of genres)?

Question 6: (optional): How many distinct genres are used to build the genres array? Hint: [unnest](https://www.postgresql.org/docs/9.2/functions-array.html) the array first.


3. Exercise

In this exercise, you will check the cardinality of the relationship between two tables: `title_basic` and `title_crew`.
 
Step 1: To establish cardinality, we first need to join the two tables together. Use a `FULL OUTER JOIN` and join the two tables together with the help of the tconst column.

Step 2: Take the count of the `title_crew.tconst` column grouped by the title_basic.tconst column.

Step 3: Take the min() and max() of the previously calculated count.

Step 4: repet step 2 & 3 for `title_basic.tconst` 

Based on these, what is the cardinality of the relationship between these two tables?

4. Exercise

Repeat exercise 3 for every relationship that `title_basic` has.

Note down how many different cardinalities are there between `title_basic` and the rest of the tables.

 



