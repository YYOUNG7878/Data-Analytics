-- Exercise 2
-- Calculate the number of trips by vendorID by hour(based on drop_off_date) in 2018
select distinct to_char("tpep_pickup_datetime", 'YYYY-MM-DD hh') as drop_off_date, 
	   			"VendorID" as vendor_id, 
	  			count("tpep_pickup_datetime") as count_trips 
from "2018_Yellow_Taxi_Trip_Data"
where extract(year from "tpep_pickup_datetime") = 2018 
group by to_char("tpep_pickup_datetime", 'YYYY-MM-DD hh'), vendor_id;

-- what was the daily(based on drop_off_date) mean, median, minimum, and maximum number of trips by vendorID in 2018?  
select vendor_id, 
	   cast(avg(count_trips) as int), 
	   percentile_cont(0.5) within group (order by count_trips asc) as median, 
	   MIN(count_trips), 
	   MAX(count_trips) 
from (select distinct to_char("tpep_pickup_datetime", 'YYYY-MM-DD') as drop_off_date, 
				 	  "VendorID" as vendor_id, 
				      count("tpep_pickup_datetime") as count_trips
		from "2018_Yellow_Taxi_Trip_Data"
		where extract(year from "tpep_pickup_datetime") = 2018 
		group by to_char("tpep_pickup_datetime", 'YYYY-MM-DD'), "VendorID") as subquery 
group by vendor_id;

-- What is the mean, median, minimum, and maximum trip_distance by vendor between 5:00 and 6:00 AM (not including 6:00 AM)?
select vendor_id, 
	   cast(avg(count_trips) as int), 
	   percentile_cont(0.5) within group (order by count_trips asc) as median, 
	   MIN(count_trips), 
	   MAX(count_trips) 
from (select distinct to_char("tpep_pickup_datetime", 'YYYY-MM-DD hh') as drop_off_date, 
				 	  "VendorID" as vendor_id, 
				      count("tpep_pickup_datetime") as count_trips 
		from "2018_Yellow_Taxi_Trip_Data"
		where extract(year from "tpep_pickup_datetime") = 2018 and extract(hour from "tpep_pickup_datetime") = 05
		group by to_char("tpep_pickup_datetime", 'YYYY-MM-DD hh'), "VendorID") as subquery 
group by vendor_id;

-- What day in 2018 had the least / most amount of unique trips?
--the day with most amount 
select distinct to_char("tpep_pickup_datetime", 'YYYY-MM-DD') as drop_off_date,
			    count("tpep_pickup_datetime") as count_trips 
from "2018_Yellow_Taxi_Trip_Data"
where extract(year from "tpep_pickup_datetime") = 2018 
group by to_char("tpep_pickup_datetime", 'YYYY-MM-DD') order by count_trips desc limit 1;
-- the day with least amount
select distinct to_char("tpep_pickup_datetime", 'YYYY-MM-DD') as drop_off_date, 
				count("tpep_pickup_datetime") as count_trips
from "2018_Yellow_Taxi_Trip_Data"
where extract(year from "tpep_pickup_datetime") = 2018 
group by to_char("tpep_pickup_datetime", 'YYYY-MM-DD') order by count_trips asc limit 1;

-- Exercise 3
-- What was the average tip percentage (tip_amount/total_amount) for unique trips in 2018?
select to_char(sum(tip_amount)/sum(total_amount)*100,'99%') as average_tip_percentage 
from "2018_Yellow_Taxi_Trip_Data"
where extract(year from "tpep_pickup_datetime") = 2018;

-- What was the average  tip percentage by drop off hour for unique trips in 2018?
select extract(hour from "tpep_pickup_datetime") as drop_off_hour_of_date, 
	   to_char(sum(tip_amount)/sum(total_amount)*100,'99%') as average_tip_percentage
from "2018_Yellow_Taxi_Trip_Data"
where extract(year from "tpep_pickup_datetime") = 2018
group by drop_off_hour_of_date;

-- Exercise 4
select date, 
	   trip_mileage_band, 
	   to_char(sum(tip_amount)/sum(total_amount)*100,'99%') as tip_percentage 
from (select to_char("tpep_pickup_datetime", 'YYYY-MM-DD') as date,
			 case
			   	when trip_distance >= 0 and trip_distance < 1 then '0-1 mile'
			   	when trip_distance >= 1 and trip_distance < 2 then '1-2 mile'
			   	when trip_distance >= 2 and trip_distance < 3 then '2-3 mile'
			   	when trip_distance >= 3 and trip_distance < 4 then '3-4 mile'
			   	when trip_distance >= 4 and trip_distance < 5 then '4-5 mile'
			   	when trip_distance >= 5 then '5+ mile'
		   	   	end  as trip_mileage_band,
		   	 tip_amount,
		   	 total_amount
		from "2018_Yellow_Taxi_Trip_Data"
		where extract(year from "tpep_pickup_datetime") = 2018
		group by to_char("tpep_pickup_datetime", 'YYYY-MM-DD'), trip_distance, tip_amount, total_amount) as subquery
group by date, trip_mileage_band;