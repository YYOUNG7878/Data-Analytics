create table qcmath290.public."2018_Yellow_Taxi_Trip_Data" (
	"VendorID" int,
	"tpep_pickup_datetime" timestamp,
	"tpep_dropoff_datetime" timestamp,
	"passenger_count" int,
	"trip_distance" float,
	"RatecodeID" int,
	"store_and_fwd_flag" varchar,
	"PULocationID" int,
	"DOLocationID" int,
	"payment_type" int,
	"fare_amount" float,
	"extra" float,
	"mta_tax" float,
	"tip_amount" float,
	"tolls_amount" float,
	"improvement_surcharge" float,
	"total_amount" float
);

copy "2018_Yellow_Taxi_Trip_Data" from '/Users/yy/Desktop/2018_Yellow_Taxi_Trip_Data.csv' delimiter ',' csv header;

select count(*) from "2018_Yellow_Taxi_Trip_Data";

select count(distinct "VendorID") from "2018_Yellow_Taxi_Trip_Data";