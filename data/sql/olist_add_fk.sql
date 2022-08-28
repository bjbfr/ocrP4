alter table orders add foreign key(customer_id) references customers(customer_id);
alter table order_items add foreign key(order_id) references orders(order_id);
alter table order_payments add foreign key(order_id) references orders(order_id);
alter table order_reviews add foreign key(order_id) references orders(order_id);
alter table order_items add foreign key(product_id) references products(product_id);

