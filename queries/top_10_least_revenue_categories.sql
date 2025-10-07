-- TODO: This query will return a table with the top 10 least revenue categories 
-- in English, the number of orders and their total revenue. The first column 
-- will be Category, that will contain the top 10 least revenue categories; the 
-- second one will be Num_order, with the total amount of orders of each 
-- category; and the last one will be Revenue, with the total revenue of each 
-- catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.

-- Get the 10 product categories with the lowest revenue, based on payment_value

SELECT 
    pt.product_category_name_english AS Category, -- Select the product category in English
    COUNT(DISTINCT o.order_id) AS Num_order, -- Count the number of distinct delivered orders for each category
    SUM(p.payment_value) AS Revenue -- Calculate the total revenue per category using payment values
FROM olist_orders o
JOIN olist_order_items oi ON o.order_id = oi.order_id -- Join orders with order items to get product IDs
JOIN olist_products pr ON pr.product_id = oi.product_id -- Join with products to get product category
JOIN product_category_name_translation pt -- Join to translate the category to English
    ON pt.product_category_name = pr.product_category_name
JOIN olist_order_payments p ON p.order_id = o.order_id -- Join with payments to get payment values
WHERE 
    o.order_status = 'delivered' -- Filter only delivered orders
    AND o.order_delivered_customer_date IS NOT NULL -- Ensure delivery date exists (exclude NULLs)
    AND pt.product_category_name_english IS NOT NULL -- Exclude categories without English translation
GROUP BY pt.product_category_name_english -- Group results by product category
ORDER BY Revenue ASC -- Order results by revenue in ascending order
LIMIT 10; -- Keep only the 10 categories with the lowest revenue