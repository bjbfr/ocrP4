CREATE TABLE if not exists customers (  
customer_id VARCHAR(250) PRIMARY KEY,
customer_unique_id VARCHAR(250),
customer_zip_code_prefix VARCHAR(250),
customer_city  VARCHAR(250),
customer_state VARCHAR(250) 
);

CREATE TABLE if not exists geolocation (
geolocation_zip_code_prefix VARCHAR(250),
geolocation_lat VARCHAR(250),
geolocation_lng VARCHAR(250),
geolocation_city VARCHAR(250),
geolocation_state VARCHAR(250)
);

CREATE TABLE if not exists order_items (
order_id VARCHAR(250),
order_item_id VARCHAR(250),
product_id VARCHAR(250),
seller_id VARCHAR(250),
shipping_limit_date VARCHAR(250),
price VARCHAR(250),
freight_value VARCHAR(250)
);

CREATE TABLE if not exists order_payments (
order_id VARCHAR(250),
payment_sequential VARCHAR(250),
payment_type VARCHAR(250),
payment_installments VARCHAR(250),
payment_value VARCHAR(250)
);

CREATE TABLE if not exists order_reviews (
review_id VARCHAR(250),
order_id VARCHAR(250),
review_score VARCHAR(250),
review_comment_title VARCHAR(250),
review_comment_message VARCHAR(250),
review_creation_date VARCHAR(250),
review_answer_timestamp VARCHAR(250)
);

CREATE TABLE if not exists orders (
order_id VARCHAR(250) PRIMARY KEY,
customer_id VARCHAR(250),
order_status VARCHAR(250),
order_purchase_timestamp VARCHAR(250),
order_approved_at VARCHAR(250),
order_delivered_carrier_date VARCHAR(250),
order_delivered_customer_date VARCHAR(250),
order_estimated_delivery_date VARCHAR(250)
);

CREATE TABLE if not exists products (
product_id VARCHAR(250) PRIMARY KEY,
product_category_name VARCHAR(250),
product_name_lenght VARCHAR(250),
product_description_lenght VARCHAR(250),
product_photos_qty VARCHAR(250),
product_weight_g VARCHAR(250),
product_length_cm VARCHAR(250),
product_height_cm VARCHAR(250),
product_width_cm VARCHAR(250)
);

CREATE TABLE if not exists sellers (
seller_id VARCHAR(250) PRIMARY KEY,
seller_zip_code_prefix VARCHAR(250),
seller_city VARCHAR(250),
seller_state VARCHAR(250)
);

CREATE TABLE if not exists cat_mapping(
product_category_name VARCHAR(250),
product_category_name_english VARCHAR(250),
high_category_name VARCHAR(250)
);

