create or replace warehouse airbnb_demo
warehouse_size = 'LARGE';

create or replace database airbnb;

create or replace schema airbnb.airbnb_schema;

use role accountadmin;

-- DDL For My Tables
CREATE OR REPLACE TABLE airbnb.airbnb_schema.HOSTS (
    host_id NUMBER,
    host_name STRING,
    host_since DATE,
    is_superhost BOOLEAN,
    response_rate NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (host_id)
);

CREATE OR REPLACE TABLE airbnb.airbnb_schema.LISTINGS (
    listing_id NUMBER,
    host_id NUMBER,
    property_type STRING,
    room_type STRING,
    city STRING,
    country STRING,
    accommodates NUMBER,
    bedrooms NUMBER,
    bathrooms NUMBER,
    price_per_night NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (listing_id)
);

CREATE OR REPLACE TABLE airbnb.airbnb_schema.BOOKINGS (
    booking_id STRING,
    listing_id NUMBER,
    booking_date TIMESTAMP,
    nights_booked NUMBER,
    booking_amount NUMBER,
    cleaning_fee NUMBER,
    service_fee NUMBER,
    booking_status STRING,
    created_at TIMESTAMP,
    PRIMARY KEY (booking_id)
);

-- Creating file format such as csv, avro, parquet etc.
create file format if not exists csv_format
type = 'csv'
field_delimiter = ','
skip_header = 1
error_on_column_count_mismatch = FALSE;


-- Example S3 integration
CREATE STORAGE INTEGRATION s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::214494099224:role/snowflake'
  STORAGE_ALLOWED_LOCATIONS = ('s3://snowflake-khan/airbnb/');

-- View storage integration properties
desc integration s3_int;

-- Display existing file formats 
show file formats;

-- Creating stage for intermediate data store
create or replace stage snow_stage
file_format = csv_format
url = 's3://snowflake-khan/airbnb/';

-- To display list of stages
show stages;


-- Loading data into tables from S3
copy into bookings
from @snow_stage
files = ('reviews.csv')
credentials = (aws_key_id = 'AKIATD4GYG4MO75VBMMF', aws_secret_key='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');


copy into listings
from @snow_stage
files = ('listings.csv')
credentials = (aws_key_id = 'AKIATD4GYG4MO75VBMMF', aws_secret_key='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');


copy into hosts
from @snow_stage
files = ('hosts.csv')
credentials = (aws_key_id = 'AKIATD4GYG4MO75VBMMF', aws_secret_key='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');


select * from listings;

