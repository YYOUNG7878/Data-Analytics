-- Q1 What is the total runtime of all movies in the IMDB database where Nicolas Cage appeared as an actor?
select sum(tb."runtimeMinutes") 
from "xf_title_basics" tb, "xf_title_principals" tp, "xf_name_basics" nb 
where tb.tconst = tp.tconst and tp.nconst = nb.nconst and tb."titleType" = 'movie' and nb."primaryName" = 'Nicolas Cage'; 

-- Q2 Which actor had the most number of titles in 2012?
select nb."primaryName", count(tb."primaryTitle") 
from "xf_name_basics" nb, "xf_title_principals" tp, "xf_title_basics" tb
where nb.nconst = tp.nconst and tp.tconst = tb.tconst and tb."startYear" = 2012
group by nb."primaryName" 
order by count(tb."primaryTitle") desc limit 1;

-- Q3 What Nicolas Cage's moive received the highest average rating?
select tb."primaryTitle", tr."averageRating" 
from "xf_title_basics" tb, "xf_title_principals" tp, "xf_name_basics" nb, "xf_title_ratings" tr 
where tb.tconst = tp.tconst and tp.nconst = nb.nconst and tb."titleType" = 'movie' and nb."primaryName" = 'Nicolas Cage'
		and tb.tconst = tr.tconst
order by tr."averageRating" desc limit 1; 

-- Q4 Which short moive received the highest average rating in 2009?
select tb."primaryTitle", tr."averageRating" 
from "xf_title_basics" tb, "xf_title_ratings" tr 
where tb."titleType" = 'short' and tb."startYear" = 2009 and tb.tconst = tr.tconst
order by tr."averageRating" desc limit 1; 

-- Q5 Return the top 10 actors with most movies where the runtime is between 45 and 60 minutes and the start year is between 2000 and 2010?
select nb."primaryName", count(tb."primaryTitle") 
from "xf_title_basics" tb, "xf_title_principals" tp, "xf_name_basics" nb 
where tb.tconst = tp.tconst and tp.nconst = nb.nconst and tb."startYear" between 2000 and 2010
		and tb."runtimeMinutes" between 45 and 60 and tb."titleType" = 'movie'
group by nb."primaryName"
order by count(tb."primaryTitle") desc limit 10;

-- Q6 What are the top 10 highly rated movies with only three words in their titles?
select tb."primaryTitle", tr."averageRating" 
from "xf_title_basics" tb, "xf_title_ratings" tr
where tb.tconst = tr.tconst and tb."titleType" = 'movie' 
		and array_length(regexp_split_to_array(tb."primaryTitle" , ' '), 1) = 3
order by tr."averageRating" desc limit 10;

-- Q7 Are three-word movie titles more popular than two-word titles?
select count(tb."primaryTitle") as "# three-word"
from "xf_title_basics" tb
where tb."titleType" = 'movie' and array_length(regexp_split_to_array(tb."primaryTitle" , ' '), 1) = 3;

select count(tb."primaryTitle") as "# two-word"
from "xf_title_basics" tb
where tb."titleType" = 'movie' and array_length(regexp_split_to_array(tb."primaryTitle" , ' '), 1) = 2;


-- Q8 Does this (see question 7) change over time?
select subquery.y as "year", "# three-word", "# two-word" 
from (select tb."startYear" as y, count(tb."primaryTitle") as "# three-word"
		from "xf_title_basics" tb
		where tb."titleType" = 'movie' and array_length(regexp_split_to_array(tb."primaryTitle" , ' '), 1) = 3
		group by tb."startYear") as subquery,
	 (select tb."startYear" as y, count(tb."primaryTitle") as "# two-word"
		from "xf_title_basics" tb
		where tb."titleType" = 'movie' and array_length(regexp_split_to_array(tb."primaryTitle" , ' '), 1) = 2
		group by tb."startYear") as subquery2
where subquery.y = subquery2.y;

