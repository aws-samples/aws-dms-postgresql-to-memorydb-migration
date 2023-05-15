#! /bin/bash

echo "Download dataset from S3"
aws s3api get-object --bucket aws-blogs-artifacts-public --key artifacts/DBBLOG-1976/products.csv products.csv
echo "=============================="

echo "Create product_catalog table"
export PGPASSWORD=$DBPASSWORD
psql -h${HOST} -p ${PORT} -U${DBUSER} -d ${DB} <<EOF
	create table product_catalog
	(
	 product_id int not null constraint product_pk primary key,
	 brandname varchar(50),
	 description varchar(300),
	 size varchar(500),
	 maximum_retail_price varchar(15),
	 selling_price decimal,
	 discount int,
	 category varchar(30)
	);
EOF
echo "=============================="

echo "Populate data in the product_catalog table"
psql -h${HOST} -p ${PORT} -U${DBUSER} -d ${DB} <<EOF
	\copy product_catalog from './products.csv' CSV;
EOF
echo "=============================="