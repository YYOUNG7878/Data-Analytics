-- Q1 What is the average runtime of a Nicolas Cage movie?
select avg(tb."runtimeMinutes") 
from "xf_title_basics" tb, "xf_title_principals" tp, "xf_name_basics" nb 
where tb.tconst = tp.tconst and tp.nconst = nb.nconst and tb."titleType" = 'movie' and nb."primaryName" = 'Nicolas Cage'; 

-- Q2 What percentage of 2010 movies are longer than the average runtime of a Nicolas Cage movie?
with average_nicolas as (
	select avg(tb."runtimeMinutes") as average
	from "xf_title_basics" tb, "xf_title_principals" tp, "xf_name_basics" nb 
	where tb.tconst = tp.tconst and tp.nconst = nb.nconst and tb."titleType" = 'movie' and nb."primaryName" = 'Nicolas Cage'
)
, count_longer as (
	select count(tb2."runtimeMinutes") as longer
	from "xf_title_basics" tb2, average_nicolas an
	where tb2."runtimeMinutes" > an.average and tb2."startYear" = 2010 and tb2."titleType" = 'movie'
)
, count_total as (
	select count(tb3."runtimeMinutes") as total
	from "xf_title_basics" tb3
	where tb3."startYear" = 2010 and tb3."titleType" = 'movie'
)
select to_char(100.0*(cl.longer)/ct.total, '999D99%') as results
from count_longer cl, count_total ct;

-- Q3 Calculate the change (in percentage) of annual average runtime movies with 'Action' genre (use a window function).
with annual_avg_runtime as (
	select avg("runtimeMinutes") as average, "startYear" as startYear
	from xf_title_basics
	where "titleType" = 'movie' and 'Action' = ANY("generes")
	group by "startYear" 
)
,previous_year_avg_runtime as (
	select startYear, average, lag(average) over (order by startYear) as pre_average
	from annual_avg_runtime
)
select startYear, round(average, 2) as average, round(pre_average, 2) as pre_average, 
		to_char(100.0*(average-pre_average)/pre_average, '999D99%') as growth
from previous_year_avg_runtime;

-- Q4 What is the average number of seasons a TV Series with over 4.2 average ratings has?
select round(avg(te."seasonNumber"), 2) as results 
from "xf_title_episode" te, "xf_title_ratings" tr
where te."tconst" = tr."tconst" and tr."averageRating" > 4.2

-- Q5 What is the highest rated Hungarian movie, and how many standard deviations away is it from the mean rating of all Hungarian movies?
select ta."title", tr."averageRating"
from "title_akas" ta, "xf_title_ratings" tr
where ta."titleId" = tr."tconst" and ta."region" = 'HU'
order by tr."averageRating" desc limit 5; -- !

select stddev(tr."averageRating") 
from "title_akas" ta, "xf_title_ratings" tr
where ta."titleId" = tr."tconst" and ta."region" = 'HU';

-- Q6 What are the top 10 regions with the most votes per movie published?
select ta."region", round(avg(tr."numVotes"))
from "title_akas" ta, "xf_title_ratings" tr
where ta."titleId" = tr."tconst"
group by ta."region" 
order by avg(tr."numVotes") desc limit 10;

-- Q7 What are the top 10 writer and director combinations with the highest average rating between 2000 and 2020 by year?
select tc."directors", tc."writers", tr."averageRating", tb."startYear" 
from "xf_title_crew" tc, "xf_title_ratings" tr, "xf_title_basics" tb
where tc."tconst" = tr."tconst" and tb."tconst" = tc."tconst" and tc."directors" is not null and tc."writers" is not null
		and tb."startYear" between 2000 and 2020
order by tr."averageRating" desc limit 10;