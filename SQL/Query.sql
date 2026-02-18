show databases;
USE mavenfuzzyfactory;
SHOW TABLES;

select * from website_pageviews;
select * from website_sessions;
select * from order_item_refunds;
select * from orders;
select * from products;
select * from order_items;


SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
GROUP BY 1,2
ORDER BY 1,2;


----


SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM
    website_sessions ws
        LEFT JOIN
    orders o ON ws.website_session_id = o.website_session_id
WHERE
    ws.utm_source = 'gsearch'
GROUP BY 1 , 2
ORDER BY 1 , 2;


SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    ws.utm_campaign,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
GROUP BY 1,2,3
ORDER BY 1,2;

SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    ws.utm_campaign,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM
    website_sessions ws
        LEFT JOIN
    orders o ON ws.website_session_id = o.website_session_id
WHERE
    ws.utm_source = 'gsearch'
GROUP BY 1 , 2 , 3
ORDER BY 1 , 2;






SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    ws.device_type,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
  AND ws.utm_campaign = 'nonbrand'
GROUP BY 1,2,3
ORDER BY 1,2;


SELECT 
    YEAR(created_at) AS yr,
    MONTH(created_at) AS mo,
    CASE 
        WHEN utm_source = 'gsearch' THEN 'gsearch'
        WHEN utm_source = 'bsearch' THEN 'bsearch'
        WHEN utm_source IS NULL THEN 'direct'
        ELSE utm_source
    END AS channel,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
GROUP BY 1,2,3
ORDER BY 1,2;



SELECT 
    YEAR(created_at) AS yr,
    MONTH(created_at) AS mo,
    CASE 
        WHEN utm_source = 'gsearch' THEN 'gsearch'
        WHEN utm_source = 'bsearch' THEN 'bsearch'
        WHEN utm_source IS NULL THEN 'direct'
        ELSE utm_source
    END AS channel,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
GROUP BY 1,2,3
ORDER BY 1,2;


SELECT 
    YEAR(created_at) AS year,
    MONTH(created_at) AS month,
    utm_source,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
GROUP BY 1, 2, utm_source
ORDER BY 1, 2;


SELECT 
    YEAR(ws.created_at) AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT o.order_id) / 
    COUNT(DISTINCT ws.website_session_id) AS conversion_rate
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY 1,2;


SELECT 
COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) AS test_cvr
FROM website_sessions ws
LEFT JOIN orders o
ON ws.website_session_id=o.website_session_id
WHERE ws.created_at BETWEEN '2012-06-19' AND '2012-07-28'
AND ws.utm_source='gsearch'
AND ws.utm_campaign='nonbrand';


SELECT 
SUM(o.price_usd) AS revenue,
COUNT(DISTINCT ws.website_session_id) AS sessions
FROM website_sessions ws
LEFT JOIN orders o
ON ws.website_session_id=o.website_session_id
WHERE ws.created_at > '2012-07-28'
AND ws.utm_source='gsearch'
AND ws.utm_campaign='nonbrand';


SELECT 
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE
            WHEN pageview_url = '/products' THEN website_session_id
        END) AS to_products,
    COUNT(DISTINCT CASE
            WHEN pageview_url = '/cart' THEN website_session_id
        END) AS to_cart,
    COUNT(DISTINCT CASE
            WHEN pageview_url = '/thank-you-for-your-order' THEN website_session_id
        END) AS to_order
FROM
    website_pageviews
WHERE
    created_at BETWEEN '2012-06-19' AND '2012-07-28';
    
    


SELECT 
    MONTH(created_at) AS Month,
    SUM(CASE
        WHEN product_id = 1 THEN price_usd
        ELSE 0
    END) AS prouduct1_revenue,
    SUM(CASE
        WHEN product_id = 1 THEN price_usd - cogs_usd
        ELSE 0
    END) AS product1_margin,
    SUM(CASE
        WHEN product_id = 2 THEN price_usd
        ELSE 0
    END) AS prouduct2_revenue,
    SUM(CASE
        WHEN product_id = 2 THEN price_usd - cogs_usd
        ELSE 0
    END) AS product2_margin,
    SUM(CASE
        WHEN product_id = 3 THEN price_usd
        ELSE 0
    END) AS prouduct3_revenue,
    SUM(CASE
        WHEN product_id = 3 THEN price_usd - cogs_usd
        ELSE 0
    END) AS product3_margin,
    SUM(CASE
        WHEN product_id = 4 THEN price_usd
        ELSE 0
    END) AS prouduct4_revenue,
    SUM(CASE
        WHEN product_id = 4 THEN price_usd - cogs_usd
        ELSE 0
    END) AS product4_margin,
    SUM(price_usd) AS total_revenue
FROM
    order_items
GROUP BY month; 

