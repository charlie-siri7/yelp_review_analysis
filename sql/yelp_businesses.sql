create or replace table yelp_businesses (business_text variant)

COPY INTO yelp_businesses FROM 's3://yelp-bucket51025/yelp/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = ''
    AWS_SECRET_KEY = ''
)
FILE_FORMAT = (TYPE = JSON);

select * from yelp_businesses limit 10