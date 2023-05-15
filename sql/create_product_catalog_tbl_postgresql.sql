create table product_catalog
(
 product_id int not null constraint product_pk primary key,
 brandname varchar(50),
 description varchar(300),
 size varchar(500),
 maximum_retail_price varchar(15),
 selling_price decimal,
 discount varchar(15),
 category varchar(30)
);
