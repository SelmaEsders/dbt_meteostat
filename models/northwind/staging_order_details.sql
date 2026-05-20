SELECT	ORDERID AS order_id
		,PRODUCTID AS product_id
		,unitprice::numeric AS unit_price -- cast to numer
		,QUANTITY::int -- float ok?
		,DISCOUNT::numeric --cast to number
FROM {{source('northwind_data','order_details')}}