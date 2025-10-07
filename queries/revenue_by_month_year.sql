-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).

-- Calculate monthly revenue per year using the minimum payment value per order
WITH min_payments AS (
    -- Select the minimum payment per order to avoid overcounting in case of multiple payment entries
    SELECT 
        order_id,
        MIN(CAST(payment_value AS REAL)) AS min_payment
    FROM olist_order_payments
    GROUP BY order_id
)
SELECT 
    strftime('%m', o.order_delivered_customer_date) AS month_no, -- Extract the month number from delivery date (01 to 12)
    CASE strftime('%m', o.order_delivered_customer_date) -- Map month numbers to 3-letter month abbreviations
        WHEN '01' THEN 'Jan'
        WHEN '02' THEN 'Feb'
        WHEN '03' THEN 'Mar'
        WHEN '04' THEN 'Apr'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'Jun'
        WHEN '07' THEN 'Jul'
        WHEN '08' THEN 'Aug'
        WHEN '09' THEN 'Sep'
        WHEN '10' THEN 'Oct'
        WHEN '11' THEN 'Nov'
        WHEN '12' THEN 'Dec'
    END AS month,
    -- Sum the minimum payments per order for 2016, rounded to 2 decimal places
    ROUND(SUM(CASE 
        WHEN strftime('%Y', o.order_delivered_customer_date) = '2016'
        THEN p.min_payment ELSE 0 END), 2) AS Year2016,
    -- Sum the minimum payments per order for 2017, rounded to 2 decimal places
    ROUND(SUM(CASE 
        WHEN strftime('%Y', o.order_delivered_customer_date) = '2017'
        THEN p.min_payment ELSE 0 END), 2) AS Year2017,
    -- Sum the minimum payments per order for 2018, rounded to 2 decimal places
    ROUND(SUM(CASE 
        WHEN strftime('%Y', o.order_delivered_customer_date) = '2018'
        THEN p.min_payment ELSE 0 END), 2) AS Year2018
FROM olist_orders o
JOIN min_payments p ON o.order_id = p.order_id -- Join orders with the pre-aggregated minimum payment per order
WHERE o.order_status = 'delivered' -- Only include delivered orders with valid delivery dates
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY month_no, month -- Group results by month number and month name
ORDER BY month_no; -- Order results chronologically by month number