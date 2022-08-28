alter TABLE order_items alter price TYPE real using order_items.price::real;
alter TABLE order_items alter freight_value TYPE real using order_items.freight_value::real;
alter TABLE order_payments alter payment_value TYPE real using order_payments.payment_value::real;
alter TABLE order_payments alter payment_sequential TYPE integer using order_payments.payment_sequential::integer;
alter TABLE order_payments alter payment_installments TYPE integer using order_payments.payment_installments::integer;
alter TABLE order_reviews  alter review_score TYPE integer using order_reviews.review_score::integer;
alter TABLE orders alter order_estimated_delivery_date TYPE TIMESTAMP using order_estimated_delivery_date::TIMESTAMP;
alter TABLE orders alter order_delivered_customer_date TYPE TIMESTAMP using order_delivered_customer_date::TIMESTAMP;
alter TABLE orders alter order_purchase_timestamp TYPE TIMESTAMP using order_purchase_timestamp::TIMESTAMP;
alter TABLE order_reviews alter review_creation_date TYPE TIMESTAMP using review_creation_date::TIMESTAMP;
alter TABLE products alter product_weight_g TYPE real using products.product_weight_g::real;
alter TABLE products alter product_height_cm TYPE real using products.product_height_cm::real;
alter TABLE products alter product_width_cm TYPE real using products.product_width_cm::real;
alter TABLE products alter product_length_cm TYPE real using products.product_length_cm::real;
alter TABLE geolocation alter column geolocation_lat TYPE decimal(19,16) using geolocation_lat::numeric(19,16);
alter TABLE geolocation alter column geolocation_lat TYPE decimal(19,16) using geolocation_lat::numeric(19,16);

