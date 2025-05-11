USE DATABASE yelp_database;
create table reviews (review varchar(200));
insert into reviews values('I love this product! It ;works perfectly!');
insert into reviews values('This product is okay, but it could be better.');
insert into reviews values('I hate this product. It stopped working after a week.');
insert into reviews values('This product is okay.Not that great.');
insert into reviews values('This product is not good.But i can use');

select * from reviews
SELECT review, analyze_sentiment(review) AS sentiment FROM reviews;
CREATE OR REPLACE FUNCTION analyze_sentiment(text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'
AS $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'Positive'
    elif analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;