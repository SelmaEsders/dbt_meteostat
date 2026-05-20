SELECT 	CATEGORYID AS category_id
		,CATEGORYNAME AS category_name
		,DESCRIPTION 
		,PICTURE 
FROM {{source('northwind', 'categories')}}