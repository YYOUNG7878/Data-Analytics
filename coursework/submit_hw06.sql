-- Exercise 2
-- Step 2 and Step 3
create table "title_akas"(
	"titleId" varchar,
	"ordering" varchar,
	"title" varchar,
	"region" varchar,
	"language" varchar,
	"types" varchar,
	"attributes" varchar,
	"isOriginalTitle" varchar
)

create table "title_basics"(
	"tconst" varchar,
	"titleType" varchar,
	"primaryTitle" varchar,
	"originalTitle" varchar,
	"isAdult" varchar,
	"startYear" varchar,
	"endYear" varchar,
	"runtimeMinutes" varchar,
	"genres" varchar
)

create table "title_crew"(
	"tconst" varchar,
	"directors" varchar,
	"writers" varchar
)

create table "title_episode"(
	"tconst" varchar,
	"parentTconst" varchar,
	"seasonNumber" varchar,
	"episodeNumber" varchar
)

create table "title_principals"(
	"tconst" varchar,
	"ordering" varchar,
	"nconst" varchar,
	"category" varchar,
	"job" varchar,
	"characters" varchar
)

create table "title_ratings"(
	"tconst" varchar,
	"averageRating" varchar,
	"numVotes" varchar
)

create table "name_basics"(
	"nconst" varchar,
	"primaryName" varchar,
	"birthYear" varchar,
	"deathYear" varchar,
	"primaryProfession" varchar,
	"knownForTitles" varchar
)

-- Step 4
copy "title_akas" from '/Users/yy/Desktop/title.akas.tsv' delimiter E'\t';
copy "title_basics" from '/Users/yy/Desktop/title.basics.tsv' delimiter E'\t';
copy "title_crew" from '/Users/yy/Desktop/title.crew.tsv' delimiter E'\t';
copy "title_episode" from '/Users/yy/Desktop/title.episode.tsv' delimiter E'\t';
copy "title_principals" from '/Users/yy/Desktop/title.principals.tsv' delimiter E'\t';
copy "title_ratings" from '/Users/yy/Desktop/title.ratings.tsv' delimiter E'\t';
copy "name_basics" from '/Users/yy/Desktop/name.basics.tsv' delimiter E'\t';

-- Step 5
select * from title_akas;
delete from title_akas where "titleId" = 'titleId';
select * from title_basics;
delete from title_basics where "tconst" = 'tconst';
select * from title_crew;
delete from title_crew where "tconst" = 'tconst';
select * from title_episode;
delete from title_episode where "tconst" = 'tconst';
select * from title_principals;
delete from title_principals where "tconst" = 'tconst';
select * from title_ratings;
delete from title_ratings where "tconst" = 'tconst';
select * from name_basics;
delete from name_basics where "nconst" = 'nconst';

-- Step 6
COPY "title_akas" TO '/Users/yy/Desktop/title_akas.csv' DELIMITER ',' CSV HEADER;
COPY "title_basics" TO '/Users/yy/Desktop/title_basics.csv' DELIMITER ',' CSV HEADER;
COPY "title_crew" TO '/Users/yy/Desktop/title_crew.csv' DELIMITER ',' CSV HEADER;
COPY "title_episode" TO '/Users/yy/Desktop/title_episode.csv' DELIMITER ',' CSV HEADER;
COPY "title_principals" TO '/Users/yy/Desktop/title_principals.csv' DELIMITER ',' CSV HEADER;
COPY "title_ratings" TO '/Users/yy/Desktop/title_ratings.csv' DELIMITER ',' CSV HEADER;
COPY "name_basics" TO '/Users/yy/Desktop/name_basics.csv' DELIMITER ',' CSV HEADER;

-- Exercise 3
select count(distinct "titleId") from "title_akas";
select count(distinct "ordering") from "title_akas";
select count(distinct "title") from "title_akas";
select count(distinct "region") from "title_akas";
select count(distinct "language") from "title_akas";
select count(distinct "types") from "title_akas";
select count(distinct "attributes") from "title_akas";
select count(distinct "isOriginalTitle") from "title_akas";
select count(*) from (select distinct "titleId", "ordering" from "title_akas") as subquery; 
select count(*) from "title_akas";

select count(distinct "tconst") from "title_basics";
select count(distinct "titleType") from "title_basics";
select count(distinct "primaryTitle") from "title_basics";
select count(distinct "originalTitle") from "title_basics";
select count(distinct "isAdult") from "title_basics";
select count(distinct "startYear") from "title_basics";
select count(distinct "endYear") from "title_basics";
select count(distinct "runtimeMinutes") from "title_basics";
select count(distinct "genres") from "title_basics";
select count(*) from "title_basics";

select count(distinct "tconst") from "title_crew";
select count(distinct "directors") from "title_crew";
select count(distinct "writers") from "title_crew";
select count(*) from "title_crew";

select count(distinct "tconst") from "title_episode";
select count(distinct "parentTconst") from "title_episode";
select count(distinct "seasonNumber") from "title_episode";
select count(distinct "episodeNumber") from "title_episode";
select count(*) from "title_episode";

select count(distinct "tconst") from "title_principals";
select count(distinct "ordering") from "title_principals";
select count(distinct "nconst") from "title_principals";
select count(distinct "category") from "title_principals";
select count(distinct "job") from "title_principals";
select count(distinct "characters") from "title_principals";
select count(*) from (select distinct "tconst", "ordering" from "title_principals") as subquery; 
select count(*) from "title_principals";

select count(distinct "tconst") from "title_ratings";
select count(distinct "averageRating") from "title_ratings";
select count(distinct "numVotes") from "title_ratings";
select count(*) from "title_ratings";

select count(distinct "nconst") from "name_basics";
select count(distinct "primaryName") from "name_basics";
select count(distinct "birthYear") from "name_basics";
select count(distinct "deathYear") from "name_basics";
select count(distinct "primaryProfession") from "name_basics";
select count(distinct "knownForTitles") from "name_basics";
select count(*) from "name_basics";

ALTER TABLE "title_akas" ADD PRIMARY KEY ("titleId", "ordering");
ALTER TABLE "title_basics" ADD PRIMARY KEY ("tconst");
ALTER TABLE "title_crew" ADD PRIMARY KEY ("tconst");
ALTER TABLE "title_episode" ADD PRIMARY KEY ("tconst");
ALTER TABLE "title_principals" ADD PRIMARY KEY ("tconst", "ordering");
ALTER TABLE "title_ratings" ADD PRIMARY KEY ("tconst");
ALTER TABLE "name_basics" ADD PRIMARY KEY ("nconst");

-- Exercise 4
-- Step 1
select count(*) from (select "tconst" from "title_basics" except select "tconst" from "title_ratings") as subquery;
-- Step 2
select "tconst" from "title_basics" except select "tconst" from "title_ratings";
-- Step 3
select count(*) from (select "tconst" from "title_basics" intersect select "tconst" from "title_ratings") as subquery;
-- Step 5 
alter table "title_ratings" add Foreign key ("tconst") references "title_basics"("tconst");