create or replace table yelp_businesses (business_text variant)

COPY INTO yelp_businesses FROM 's3://yelp-bucket51025/yelp/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = ''
    AWS_SECRET_KEY = ''
)
FILE_FORMAT = (TYPE = JSON);

create or replace table yelp_businesses_table as
select business_text:business_id::string as business_id,
business_text:categories::string as categories,
business_text:city::string as city,
business_text:state::string as state,
business_text:review_count::number as review_count,
business_text:stars::number as stars
from yelp_businesses

select * from yelp_businesses_table