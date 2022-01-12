-- Q1 Are movie ratings normally distributed? 
select count("averageRating") as n, min("averageRating"), max("averageRating"), avg("averageRating"),
		variance("averageRating"), stddev("averageRating") 
from "xf_title_ratings";

-- Skewness
with Skew as(
	select sum(1.0*"averageRating") as rx,
		sum(power(1.0*"averageRating",2)) as rx2,
		sum(power(1.0*"averageRating",3)) as rx3,
		count(1.0*"averageRating") as rn,
		stddev(1.0*"averageRating") as stdv,
		avg(1.0*"averageRating") as av
	from "xf_title_ratings"
)
select (rx3 - 3*rx2*av + 3*rx*av*av - rn*av*av*av)
		/(stdv*stdv*stdv) * rn / (rn-1) / (rn-2) as Skewness
from Skew;

-- Kurtosis
with Kurt as(
	select sum(1.0*"averageRating") as rx,
		sum(power(1.0*"averageRating",2)) as rx2,
		sum(power(1.0*"averageRating",3)) as rx3,
		sum(power(1.0*"averageRating",4)) as rx4,
		count(1.0*"averageRating") as rn,
		stddev(1.0*"averageRating") as stdv,
		avg(1.0*"averageRating") as av
	from "xf_title_ratings"
)
select (rx4 - 4*rx3*av + 6*rx2*av*av - 4*rx*av*av*av + rn*av*av*av*av)
		/ (stdv*stdv*stdv*stdv) * rn * (rn+1) / (rn-1) / (rn-2) / (rn-3)
		- 3.0 * (rn-1) * (rn-1) / (rn-2) / (rn-3) as Kurtosis
from Kurt;

-- Relative frequency
with total as (
	select count(*) as sum_ratings from "xf_title_ratings"
)
select distinct "averageRating", count("averageRating") as frequency, (count("averageRating")+0.0)/sum_ratings as "relative frequency"
from "xf_title_ratings", total
group by "averageRating", sum_ratings;

-- Q2 What are the first and last names of all the actors cast in the movie 'Lord of war'? What roles did they play in that production?
select nb."primaryName", tp."characters"
from "xf_title_basics" tb, "xf_title_principals" tp, "xf_name_basics" nb
where tb."primaryTitle" = 'Lord of War' and tb."tconst" = tp."tconst" and nb."nconst" = tp."nconst"
		and (tp."category" = 'actor' or tp."category" = 'actress');
	
-- Q3 What are the highest-rated Comedy shorts between 2000 and 2010?
select tb."primaryTitle", tb."startYear", tr."averageRating"
from "xf_title_basics" tb, "xf_title_ratings" tr
where tb."tconst" = tr."tconst" and tb."titleType" = 'short' and 'Comedy' = ANY(tb."generes") and tb."startYear" between 2000 and 2010
order by tr."averageRating" desc limit 10;
	
-- Q4 What is the average number of votes for movies rated between 0-1, 1-2, 2-3, 3-4, 4-5?
select case
		when "averageRating" > 0 and "averageRating" <= 1 then '0-1'
		when "averageRating" > 1 and "averageRating" <= 2 then '1-2'
		when "averageRating" > 2 and "averageRating" <= 3 then '2-3'
		when "averageRating" > 3 and "averageRating" <= 4 then '3-4'
		when "averageRating" > 4 and "averageRating" <= 5 then '4-5'
		else 'other'
		end as rating_range,
		round(avg("numVotes")) as avg_votes
from "xf_title_ratings"
group by rating_range;