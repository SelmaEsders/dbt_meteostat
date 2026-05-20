SELECT	ORDERID AS order_id
		,CUSTOMERID AS customer_id
		,EMPLOYEEID AS employee_id
		,ORDERDATE AS order_date
		,REQUIREDDATE AS require_date
		,SHIPPEDDATE AS shipped_date
		,SHIPVIA AS ship_via
		,SHIPCITY AS ship_city
		,SHIPCOUNTRY  AS ship_country
FROM {{source('northwind_data', 'orders')}}