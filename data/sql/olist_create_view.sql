create materialized view geo_view as (select geolocation_state as g_state,geolocation_city as g_city,geolocation_zip_code_prefix as g_zip_code_prefix, avg(geolocation_lat) as g_lat, avg(geolocation_lng) as g_lng from geolocation group by geolocation_city,geolocation_zip_code_prefix,geolocation_state
);

create materialized view olist_view as (
 select c.customer_id as c_customer_id,c.customer_unique_id as c_customer_unique_id,c.customer_zip_code_prefix as c_customer_zip_code_prefix,c.customer_city as c_customer_city,c.customer_state as c_customer_state,
o.order_id as o_order_id,o.customer_id as o_customer_id,o.order_status as o_order_status,o.order_purchase_timestamp as o_order_purchase_timestamp,o.order_approved_at as o_order_approved_at,o.order_delivered_carrier_date as o_order_delivered_carrier_date,o.order_delivered_customer_date as o_order_delivered_customer_date,o.order_estimated_delivery_date as o_order_estimated_delivery_date,
i.order_id as i_order_id,i.order_item_id as i_order_item_id,i.product_id as i_product_id,i.seller_id as i_seller_id,i.shipping_limit_date as i_shipping_limit_date,i.price as i_price,i.freight_value as i_freight_value,
p.product_id as p_product_id,coalesce(m.product_category_name_english,p.product_category_name) as p_product_category_name,m.high_category_name as p_high_category_name,p.product_name_lenght as p_product_name_lenght,p.product_description_lenght as p_product_description_lenght,p.product_photos_qty as p_product_photos_qty,p.product_weight_g as p_product_weight_g,p.product_length_cm as p_product_length_cm,p.product_height_cm as p_product_height_cm,p.product_width_cm as p_product_width_cm,
pa.order_id as pa_order_id,pa.payment_sequential as pa_payment_sequential,pa.payment_type as pa_payment_type,pa.payment_installments as pa_payment_installments,pa.payment_value as pa_payment_value,
r.review_id as r_review_id,r.order_id as r_order_id,r.review_score as r_review_score,r.review_comment_title as r_review_comment_title,r.review_comment_message as r_review_comment_message,r.review_creation_date as r_review_creation_date,r.review_answer_timestamp as r_review_answer_timestamp,
6371*pi()/180*sqrt( power((g.g_lat+25.429993156086567),2) + power((g.g_lng+49.291907420319355),2) ) as distance,
g.g_lat as lat,
g.g_lng as lng,
DATE_PART('day',o.order_delivered_customer_date - o.order_estimated_delivery_date) as estimation_error
from customers c
left outer join orders o on c.customer_id = o.customer_id
left outer join order_items i on i.order_id = o.order_id
left outer join products p on p.product_id = i.product_id        
left outer join cat_mapping m on m.product_category_name = p.product_category_name 
left outer join order_payments pa on pa.order_id = o.order_id
left outer join order_reviews r on r.order_id = o.order_id
left outer join geo_view g on g.g_state = c.customer_state and g.g_zip_code_prefix = c.customer_zip_code_prefix and g.g_city = c.customer_city
);

