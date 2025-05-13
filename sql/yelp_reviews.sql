
create or replace table yelp_reviews (review_text variant)

COPY INTO yelp_reviews FROM 's3://yelp-bucket51025/yelp/'
CREDENTIALS = (
    AWS_KEY_ID = ''
    AWS_SECRET_KEY = ''
)
FILE_FORMAT = (TYPE = JSON);

create or replace table yelp_reviews_table as
select review_text:business_id::string as business_id, review_text:date::date as review_date, review_text:stars::number as review_stars, 
review_text:text::string as review_text,
analyze_sentiment(review_text) as sentiments,
review_text:user_id::string as user_id
from yelp_reviews

select count(*) from yelp_reviews_table
select * from yelp_reviews_table limit 100
select * from yelp_businesses_table limit 100