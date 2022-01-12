-- Exercise 1 
create database "BBDN";

create table bus_nyc (
"School Year" varchar,
"Busbreakdown_ID" int,
"Run_Type" varchar,
"Bus_No" varchar,
"Route_Number" varchar,
"Reason" varchar,
"Schools_Serviced" varchar,
"Occurred_On" timestamp,
"Created_On" timestamp,
"Boro" varchar,
"Bus_Company_Name" varchar,
"How_Long_Delayed" varchar,
"Number_Of_Students_On_The_Bus" int,
"Has_Contractor_Notified_Schools" varchar,
"Has_Contractor_Notified_Parents" varchar,
"Have_You_Alerted_OPT" varchar,
"Informed_On" timestamp,
"Incident_Number" varchar,
"Last_Updated_On" timestamp,
"Breakdown_or_Running_Late" varchar,
"School_Age_or_PreK" varchar
);

copy "bus_nyc" from '/Users/yy/Desktop/Bus_Breakdown_and_Delays.csv' delimiter ',' csv header;

-- Exercise 2
-- Q1 Count how many bus breakdowns occurred from 2015 to 2016, 2016 to 2017, 2017 to 2018, 2018 to 2019, and 2019 to 2020.
select "School Year", count(*)
from "bus_nyc"
group by "School Year";

-- Q2 In the Busbreakdown_ID column, Using COUNT() command to calculate the how many BusBreakdown_ID.
-- Using DISTINCT COUNT() to return a row for each unique count.
-- Find out which Busbreakdown _ID has the most occurrences.
select count("Busbreakdown_ID") from "bus_nyc"; 

select count(distinct "Busbreakdown_ID") from "bus_nyc";

select "Busbreakdown_ID", count(*) as occurrence from "bus_nyc"
group by "Busbreakdown_ID"
order by occurrence desc limit 10;

-- Q3  In the Run_Type column, find out what kind of Run_Types has and what are they? 
-- What is the proportion of each Run_type of total Run_type?
select distinct "Run_Type" from "bus_nyc";

with total_number as(
	select count("Run_Type") as total from "bus_nyc"
)
select "Run_Type", (count("Run_Type")+0.0)/"total" as Proportion
from "bus_nyc", "total_number"
group by "Run_Type", "total";

-- Q4 In the Route_Number column, what kind of route numbers has and what are they? 
-- What is the proportion of each route number of total route number?
select distinct "Route_Number" from "bus_nyc";

with total_number as(
	select count("Route_Number") as total from "bus_nyc"
)
select "Route_Number", (count("Route_Number")+0.0)/"total" as Proportion
from "bus_nyc", "total_number"
group by "Route_Number", "total";

-- Q5 In the Reason column, what kind of reason has and what are they. 
-- What is the proportion of each reason of the total Reason column?
select distinct "Reason" from "bus_nyc";

with total_number as(
	select count("Reason") as total from "bus_nyc"
)
select "Reason", (count("Reason")+0.0)/"total" as Proportion
from "bus_nyc", "total_number"
group by "Reason", "total";

-- Q6  In the Schools_Serviced, what kind of schools serviced has and what are they? 
-- What is the proportion of each school serviced of total Schools Serviced?
select distinct "Schools_Serviced" from "bus_nyc";

with total_number as(
	select count("Schools_Serviced") as total from "bus_nyc"
)
select "Schools_Serviced", (count("Schools_Serviced")+0.0)/"total" as Proportion
from "bus_nyc", "total_number"
group by "Schools_Serviced", "total";

-- Q7 In the Occurred_On column, how many times happened in the morning in each year? 
-- How many times happened in the afternoon each year(2015-2016， 2016-2017，....).
select "School Year", count(*)
from "bus_nyc"
where extract(day from "Occurred_On") between 06 and 12
group by "School Year";

select "School Year", count(*)
from "bus_nyc"
where extract(day from "Occurred_On") between 12 and 18
group by "School Year";

-- Q8 In the Boro column, what kind of Boro has and what are they? 
-- What is the proportion of each Boro of total Boro?
select distinct "Boro" from "bus_nyc";

with total_number as(
	select count("Boro") as total from "bus_nyc"
)
select "Boro", (count("Boro")+0.0)/"total" as Proportion
from "bus_nyc", "total_number"
group by "Boro", "total";

-- Exercise 3 In 2016-2017, how many times did Pre-K/EI bus breakdowns occur?
select count(*)
from "bus_nyc"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI';

-- Exercise 4 In 2016-2017, how many times did Pre-K/EI bus breakdowns in Brox?
-- In 2016-2017, how many times did Pre-K/EI bus breakdowns in Manhattan?
select count(*)
from "bus_nyc"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and "Boro" = 'Bronx';

select count(*)
from "bus_nyc"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and "Boro" = 'Manhattan';

-- Exercise 5 In 2016-2017, how many times did the Pre-K/El bus break down in the morning? 
-- In 2016-2017, how many times did the Pre-K/El bus break down in the afternoon?
select count(*)
from "bus_nyc"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and extract(day from "Occurred_On") between 06 and 12;

select count(*)
from "bus_nyc"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and extract(day from "Occurred_On") between 12 and 18;

-- Exercise 6 In 2016-2017, what proportion of each Pr-K/EI bus in Manhattan breakdown reason corresponds to the total breakdown reason?
with total_number as(
	select count("Reason") as total from "bus_nyc" 
	where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and "Boro" = 'Manhattan'
)
select "Reason", (count("Reason")+0.0)/"total" as Proportion
from "bus_nyc", "total_number"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and "Boro" = 'Manhattan'
group by "Reason", "total";

-- Exercise 7 In 2016-2017, in Bronx, which line of Pre-K/EI bus the most?
select "Route_Number", count(*) as frequency
from "bus_nyc"
where "School Year" = '2016-2017' and "Run_Type" = 'Pre-K/EI' and "Boro" = 'Bronx'
group by "Route_Number"
order by frequency desc limit 1;