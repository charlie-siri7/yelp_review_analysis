-- 1. # of businesses in each category
with businesses as 
(
    select business_id, trim(A.value) as category from yelp_businesses_table,
    lateral split_to_table(categories, ',') A
) -- set businesses to the table sorting all rows by category

select category, count(*) as business_count from businesses // get the category, count of each row of the table
group by 1 -- group by category (column 1)
order by 2 desc -- descending by count (column 2)

-- 2. Top 10 users who have reviewed the most businesses in the restaurant category
select r.user_id, count(distinct r.business_id) from yelp_reviews_table r inner join yelp_businesses_table b on r.business_id
=b.business_id where b.categories ilike '%restaurant%' and r.user_id is not null
group by 1 
order by 2 desc 
limit 10 -- From all reviews for restaurants

-- 3. Most popular (most reviewed) business categories - based on # of reviews
with businesses as 
(
    select business_id, trim(A.value) as category from yelp_businesses_table,
    lateral split_to_table(categories, ',') A
) select category, count(*) as review_count from businesses
inner join yelp_reviews_table r on businesses.business_id = r.business_id
group by 1 -- group by category
order by 2 desc -- order by count (descending)

-- 4. 3 most recently reviews for each business
with businesses as (
select r.*, b.name, row_number() 
over(
    partition by r.business_id order by review_date desc
)
as review_num
from yelp_reviews_table r 
inner join yelp_businesses_table b on r.business_id=b.business_id
) select * from businesses where review_num <= 4 and review_num > 1