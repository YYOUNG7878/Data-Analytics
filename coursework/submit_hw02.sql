create table qcmath290.public.class_roster (
 "id" bigint
,"name" varchar
,"last_name" varchar
,"first_name" varchar
,"passion" varchar
,"last_updated_timestamp" timestamp
,"link_to_interest" varchar
,"email_address" varchar
,"github_handle" varchar
,"coding_buddy" varchar
,constraint "id" primary key ("id")
);

create table homework (
	id bigint,
	homework_name varchar,
	posted_date timestamp,
	due_date timestamp,
	constraint pk_homework primary key (id)
)

create table homework_submission (
	id bigint,
	student_id bigint,
	homework_id bigint,
	submission_date timestamp,
	homework_duration bigint,
	primary key (id),
	constraint fk_homework foreign key (homework_id) references homework(id),
	constraint fk_student foreign key (student_id) references class_roster(id)
)

create table taxi_trip (
	VendorID int,
	tpep_pickup_datetime timestamp,
	tpep_dropoff_datetime timestamp,
	passenger_count int,
	trip_distance float,
	RatecodeID int,
	store_and_fwd_flag varchar,
	PULocationID int,
	DOLocationID int,
	payment_type int,
	fare_amount float,
	extra float,
	mta_tax float,
	tip_amount float,
	tolls_amount float,
	improvement_surcharge float,
	total_amount float
)

insert into homework values('1','Homework1','09/09/2021 00:00','09/13/2021 00:00');
insert into homework values('2','Homework2','09/17/2021 00:00','09/20/2021 00:00');

insert into homework_submission values('1','8','1','09/12/2021 21:17','60');
insert into homework_submission values('2','7','1','09/12/2021');

copy taxi_trip from '/private/tmp/2018_Yellow_Taxi_Trip_Data.csv' delimiter ',' csv header;