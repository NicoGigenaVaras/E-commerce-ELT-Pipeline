-- TODO: This query will return a table with two columns; State, and 
-- Delivery_Difference. The first one will have the letters that identify the 
-- states, and the second one the average difference between the estimate 
-- delivery date and the date when the items were actually delivered to the 
-- customer.
-- HINTS:
-- 1. You can use the julianday function to convert a date to a number.
-- 2. You can use the CAST function to convert a number to an integer.
-- 3. You can use the STRFTIME function to convert a order_delivered_customer_date to a string removing hours, minutes and seconds.
-- 4. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL


-- Select the state and the average delivery delay for each state
SELECT 
    c.customer_state AS State, -- Rename customer_state column to 'State' for readability
    CAST(
        AVG(julianday(STRFTIME('%Y-%m-%d',o.order_estimated_delivery_date)) - julianday(STRFTIME('%Y-%m-%d',o.order_delivered_customer_date))
        ) AS INTEGER
    ) AS Delivery_Difference -- Calculate average difference (in days) between estimated and actual delivery, casted to integer
FROM olist_orders o
-- Join orders with customers to get the state information
INNER JOIN olist_customers c ON c.customer_id = o.customer_id 
WHERE
    o.order_status = 'delivered' -- Consider only delivered orders
    AND o.order_delivered_customer_date IS NOT NULL -- Exclude records with missing delivery date
GROUP BY State -- Group results by state to calculate the average per state
ORDER BY Delivery_Difference; -- Order the results by delivery difference in ascending order