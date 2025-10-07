-- TODO: This query will return a table with two columns; order_status, and
-- Ammount. The first one will have the different order status classes and the
-- second one the total ammount of each.

-- utilizaremos, la funcion SUM(), para sumar los valores de cada status
-- y order by para ordenarlos y simplificar las filas, 

-- Select the status of orders and the total number of distinct orders for each status
SELECT
    o.order_status AS order_status, -- Select the order status column and rename it as 'order_status'
    COUNT(DISTINCT o.order_id) AS Ammount -- Count the number of unique orders per status, rename as 'Ammount'
FROM olist_orders o -- Source table containing order information
GROUP BY o.order_status -- Group the results by each order status
ORDER BY o.order_status; -- Sort the result alphabetically by order status


