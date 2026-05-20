SELECT	PRODUCTID AS product_id
		,PRODUCTNAME AS product_name
		,SUPPLIERID AS supplier_id
		,CATEGORYID AS category_id
		,UNITPRICE::numeric AS unit_price
FROM {{source('northwind_data', 'products')}}