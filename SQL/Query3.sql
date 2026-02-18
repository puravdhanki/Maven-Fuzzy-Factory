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

SELECT 
    YEAR(wp.created_at) AS Year,
    MONTH(wp.created_at) AS Month,
    COUNT(DISTINCT wp.website_session_id) AS session_to_product_page,
    COUNT(DISTINCT next_wp.website_session_id) AS clicked_to_next_page,
    COUNT(DISTINCT next_wp.website_session_id) / COUNT(DISTINCT wp.website_session_id) AS click_through_rate,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT wp.website_session_id) AS product_order_rate
FROM
    website_pageviews AS wp
        LEFT JOIN
    website_pageviews AS next_wp ON next_wp.website_session_id = wp.website_session_id
        AND next_wp.website_pageview_id > wp.website_pageview_id
        LEFT JOIN
    orders AS o ON o.website_session_id = wp.website_session_id
WHERE
    wp.pageview_url = '/products'
GROUP BY Year , Month
ORDER BY Year , Month; 


SELECT 
    o.primary_product_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 1 THEN o.order_id
            ELSE NULL
        END) AS cross_sell_p1,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 2 THEN o.order_id
            ELSE NULL
        END) AS cross_sell_p2,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 3 THEN o.order_id
            ELSE NULL
        END) AS cross_sell_p3,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 4 THEN o.order_id
            ELSE NULL
        END) AS cross_sell_p4,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 1 THEN o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT o.order_id) AS p1_xsell_rt,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 2 THEN o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT o.order_id) AS p2_xsell_rt,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 3 THEN o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT o.order_id) AS p3_xsell_rt,
    COUNT(DISTINCT CASE
            WHEN oi.product_id = 4 THEN o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT o.order_id) AS p4_xsell_rt
FROM
    orders o
        LEFT JOIN
    order_items oi ON oi.order_id = o.order_id
        AND oi.is_primary_item = 0
WHERE
    o.created_at > '2014-12-05'
GROUP BY 1; -- Primary Product ID ke hisaab se group kiya

