-- Exercise 1
-- Step 1
select table_name, column_name, data_type from "IMDb".information_schema.columns
where table_schema = 'public' and table_name = 'title_basics';

-- Step 2
create view "IMDb".public.etl_title_basics_v as
select tb."tconst", tb."titleType", tb."primaryTitle", tb."originalTitle"
,cast(tb."isAdult" as boolean) as "isAdult", cast(tb."startYear" as integer) as "startYear"
,cast(tb."endYear" as integer) as "endYear", cast(tb."runtimeMinutes" as integer) as "runtimeMinutes"
,regexp_split_to_array(tb."genres",',')::varchar[] as "generes"
from "IMDb".public.title_basics tb;

create view "IMDb".public.etl_title_crew_v as
select tc."tconst", regexp_split_to_array(tc."directors",',')::varchar[] as "directors"
,regexp_split_to_array(tc."writers",',')::varchar[] as "writers" 
from "IMDb".public.title_crew tc;

create view "IMDb".public.etl_title_episode_v as
select te."tconst", te."parentTconst"
,cast(te."seasonNumber" as integer) as "seasonNumber", cast(te."episodeNumber" as integer) as "episodeNumber"
from "IMDb".public.title_episode te;

create view "IMDb".public.etl_title_principals_v as
select tp."tconst", cast(tp."ordering" as integer) as "ordering", tp."nconst", tp."category", tp."job", tp."characters"
from "IMDb".public.title_principals tp;

create view "IMDb".public.etl_title_ratings_v as
select tr."tconst", cast(tr."averageRating" as real) as "averageRating", cast(tr."numVotes" as integer) as "numVotes"
from "IMDb".public.title_ratings tr;

create view "IMDb".public.etl_name_basics_v as
select nb."nconst", nb."primaryName", cast(nb."birthYear" as integer) as "birthYear", cast(nb."deathYear" as integer) as "deathYear"
,regexp_split_to_array(nb."primaryProfession",',')::varchar[] as "primaryProfession"
,regexp_split_to_array(nb."knownForTitles",',')::varchar[] as "knownForTitles"
from "IMDb".public.name_basics nb;

-- Step 3
create table "IMDb".public.xf_title_basics as select * from "IMDb".public.etl_title_basics_v;
create table "IMDb".public.xf_title_crew as select * from "IMDb".public.etl_title_crew_v;
create table "IMDb".public.xf_title_episode as select * from "IMDb".public.etl_title_episode_v;
create table "IMDb".public.xf_title_principals as select * from "IMDb".public.etl_title_principals_v;
create table "IMDb".public.xf_title_ratings as select * from "IMDb".public.etl_title_ratings_v;
create table "IMDb".public.xf_name_basics as select * from "IMDb".public.etl_name_basics_v;

-- Step 4
ALTER TABLE "xf_title_basics" ADD PRIMARY KEY ("tconst");
ALTER TABLE "xf_title_crew" ADD PRIMARY KEY ("tconst");
ALTER TABLE "xf_title_episode" ADD PRIMARY KEY ("tconst");
ALTER TABLE "xf_title_principals" ADD PRIMARY KEY ("tconst", "ordering");
ALTER TABLE "xf_title_ratings" ADD PRIMARY KEY ("tconst");
ALTER TABLE "xf_name_basics" ADD PRIMARY KEY ("nconst");
alter table "xf_title_ratings" add Foreign key ("tconst") references "xf_title_basics"("tconst"); 

-- Exercise 2
-- Q1
select count(*) from "xf_title_basics" where "runtimeMinutes" between 42 and 77;
-- Q2
select avg("runtimeMinutes") from "xf_title_basics" where "isAdult" = '1';
-- Q3
select count(*) from
(select xtb_a."runtimeMinutes", xtb_b."runtimeMinutes" 
from "IMDb".public.xf_title_basics xtb_a, "IMDb".public.xf_title_basics xtb_b)x;
-- Q4
select cast(avg("runtimeMinutes") as integer) from "xf_title_basics" where "generes"[1] = 'Action';
-- Q5
select "generes", count(*) from "xf_title_basics" group by "generes";
-- Q6
select count(*) from (select distinct unnest("generes") from "xf_title_basics") as subquery;

-- Exercise 3
-- Step 1
select * from "xf_title_basics"
full outer join "xf_title_crew"
on "xf_title_basics"."tconst" = "xf_title_crew"."tconst";
-- Step 2
select "xf_title_basics"."tconst", count("xf_title_crew"."tconst") from "xf_title_basics"
full outer join "xf_title_crew"
on "xf_title_basics"."tconst" = "xf_title_crew"."tconst"
group by "xf_title_basics"."tconst";
-- Step 3
select min(c) from (select count("xf_title_crew"."tconst") as c from "xf_title_basics"
full outer join "xf_title_crew"
on "xf_title_basics"."tconst" = "xf_title_crew"."tconst"
group by "xf_title_basics"."tconst") as subquery;

select max(c) from (select count("xf_title_crew"."tconst") as c from "xf_title_basics"
full outer join "xf_title_crew"
on "xf_title_basics"."tconst" = "xf_title_crew"."tconst"
group by "xf_title_basics"."tconst") as subquery;
-- Step 4
select min(c) from (select count("xf_title_basics"."tconst") as c from "xf_title_basics"
full outer join "xf_title_crew"
on "xf_title_basics"."tconst" = "xf_title_crew"."tconst"
group by "xf_title_crew"."tconst") as subquery;

select max(c) from (select count("xf_title_basics"."tconst") as c from "xf_title_basics"
full outer join "xf_title_crew"
on "xf_title_basics"."tconst" = "xf_title_crew"."tconst"
group by "xf_title_crew"."tconst") as subquery;
-- Exercise 4
select min(c), max(c) from (select count("xf_title_basics"."tconst") as c from "xf_title_basics"
full outer join "xf_title_episode"
on "xf_title_basics"."tconst" = "xf_title_episode"."tconst"
group by "xf_title_episode"."tconst") as subquery;

select min(c), max(c) from (select count("xf_title_episode"."tconst") as c from "xf_title_basics"
full outer join "xf_title_episode"
on "xf_title_basics"."tconst" = "xf_title_episode"."tconst"
group by "xf_title_basics"."tconst") as subquery;

select min(c), max(c) from (select count("xf_title_basics"."tconst") as c from "xf_title_basics"
full outer join "xf_title_principals"
on "xf_title_basics"."tconst" = "xf_title_principals"."tconst"
group by "xf_title_principals"."tconst") as subquery;

select min(c), max(c) from (select count("xf_title_principals"."tconst") as c from "xf_title_basics"
full outer join "xf_title_principals"
on "xf_title_basics"."tconst" = "xf_title_principals"."tconst"
group by "xf_title_basics"."tconst") as subquery;

select min(c), max(c) from (select count("xf_title_basics"."tconst") as c from "xf_title_basics"
full outer join "xf_title_ratings"
on "xf_title_basics"."tconst" = "xf_title_ratings"."tconst"
group by "xf_title_ratings"."tconst") as subquery;

select min(c), max(c) from (select count("xf_title_ratings"."tconst") as c from "xf_title_basics"
full outer join "xf_title_ratings"
on "xf_title_basics"."tconst" = "xf_title_ratings"."tconst"
group by "xf_title_basics"."tconst") as subquery;