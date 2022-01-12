-- Exercise 1 
select count(distinct "VendorID") as VendorID,
count(distinct "tpep_pickup_datetime") as tpep_pickup_datetime,
count(distinct "tpep_dropoff_datetime") as tpep_dropoff_datetime,
count(distinct "passenger_count") as passenger_count,
count(distinct "trip_distance") as trip_distance,
count(distinct "RatecodeID") as RatecodeID,
count(distinct "store_and_fwd_flag") as store_and_fwd_flag,
count(distinct "PULocationID") as PULocationID,
count(distinct "DOLocationID") as DOLocationID,
count(distinct "payment_type") as payment_type,
count(distinct "fare_amount") as fare_amount,
count(distinct "extra") as extra,
count(distinct "mta_tax") as mta_tax,
count(distinct "tip_amount") as tip_amount,
count(distinct "tolls_amount") as tolls_amount,
count(distinct "improvement_surcharge") as improvement_surcharge,
count(distinct "total_amount") as total_amount
from "2018_Yellow_Taxi_Trip_Data";

-- Exercise 2
select count(*) as distinct_observation_count from 
 	(select distinct "VendorID", "tpep_pickup_datetime", "tpep_dropoff_datetime", "passenger_count", "trip_distance",
 	"RatecodeID", "store_and_fwd_flag", "PULocationID", "DOLocationID", "payment_type", "fare_amount", "extra", "mta_tax",
 	"tip_amount", "tolls_amount", "improvement_surcharge", "total_amount"
 	from "qcmath290"."public"."2018_Yellow_Taxi_Trip_Data") as sub_query;

-- Exercise 3
select count(*) from "2018_Yellow_Taxi_Trip_Data" where passenger_count = 5;
select count(*) from "2018_Yellow_Taxi_Trip_Data" where passenger_count > 3;
select count("tpep_pickup_datetime") from "2018_Yellow_Taxi_Trip_Data" 
	where tpep_pickup_datetime between '2018-04-01 00:00:00' and '2018-05-01 00:00:00';
select count(*) from "2018_Yellow_Taxi_Trip_Data" 
	where tip_amount > 5 and 
	tpep_pickup_datetime between '2018-06-01 00:00:00' and '2018-07-01 00:00:00';
select count(*) from "2018_Yellow_Taxi_Trip_Data"
	where passenger_count > 3 and 
	tip_amount between 2 and 5 and 
	tpep_pickup_datetime between '2018-05-01 00:00:00' and '2018-06-01 00:00:00';
select sum("tip_amount") from "2018_Yellow_Taxi_Trip_Data";