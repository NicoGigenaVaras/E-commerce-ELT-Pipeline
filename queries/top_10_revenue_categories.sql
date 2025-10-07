-- TODO: This query will return a table with the top 10 revenue categories in 
-- English, the number of orders and their total revenue. The first column will 
-- be Category, that will contain the top 10 revenue categories; the second one 
-- will be Num_order, with the total amount of orders of each category; and the 
-- last one will be Revenue, with the total revenue of each catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.

SELECT 
    pt.product_category_name_english AS Category, -- Select the product category in English
    COUNT(DISTINCT o.order_id) AS Num_order, -- Count the number of distinct delivered orders per category
    SUM(p.payment_value) AS Revenue -- Sum the payment values to calculate total revenue per category
FROM olist_orders o
JOIN olist_order_items oi ON o.order_id = oi.order_id -- Join orders with items to get products
JOIN olist_products pr ON pr.product_id = oi.product_id -- Join with products to get category info
JOIN product_category_name_translation pt -- Join to translate category name to English
    ON pt.product_category_name = pr.product_category_name
JOIN olist_order_payments p ON p.order_id = o.order_id -- Join with payments to get revenue
WHERE 
    o.order_status = 'delivered'-- Filter only delivered orders
    AND o.order_delivered_customer_date IS NOT NULL -- Ensure delivery date is not null
    AND pt.product_category_name_english IS NOT NULL -- Exclude categories without English translation
GROUP BY pt.product_category_name_english -- Group results by category
ORDER BY Revenue DESC -- Order by revenue in descending order
LIMIT 10; -- Limit results to top 10 categories by revenue