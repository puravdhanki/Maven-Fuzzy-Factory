SELECT 
    YEAR(ws.created_at) AS Year,
    QUARTER(ws.created_at) AS Quarter,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM
    website_sessions AS ws
        LEFT JOIN
    orders AS o ON ws.website_session_id = o.website_session_id
GROUP BY Year , Quarter; 

SELECT 
    YEAR(ws.created_at) AS Year,
    QUARTER(ws.created_at) AS Quarter,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS conversation_rate,
    SUM(o.price_usd) / COUNT(DISTINCT o.order_id) AS revenue_per_order,
    SUM(o.price_usd) / COUNT(DISTINCT ws.website_session_id) AS revenue_per_session
FROM
    website_sessions AS ws
        LEFT JOIN
    orders AS o ON ws.website_session_id = o.website_session_id
GROUP BY Year , Quarter; 

SELECT 
    YEAR(ws.created_at) AS Year,
    QUARTER(ws.created_at) AS Quarter,
    COUNT(DISTINCT CASE
            WHEN
                utm_source = 'gsearch'
                    AND utm_campaign = 'nonbrand'
            THEN
                o.order_id
            ELSE NULL
        END) AS gsearch_nonbrand,
    COUNT(DISTINCT CASE
            WHEN
                utm_source = 'bsearch'
                    AND utm_campaign = 'nonbrand'
            THEN
                o.order_id
            ELSE NULL
        END) AS bsearch_nonbrand,
    COUNT(DISTINCT CASE
            WHEN utm_campaign = 'brand' THEN o.order_id
            ELSE NULL
        END) AS brand_search,
    COUNT(DISTINCT CASE
            WHEN
                utm_source IS NULL
                    AND http_referer IS NOT NULL
            THEN
                o.order_id
            ELSE NULL
        END) AS organic_search,
    COUNT(DISTINCT CASE
            WHEN
                utm_source IS NULL
                    AND http_referer IS NULL
            THEN
                o.order_id
            ELSE NULL
        END) AS direct_type_in
FROM
    website_sessions AS ws
        LEFT JOIN
    orders AS o ON ws.website_session_id = o.website_session_id
GROUP BY Year , Quarter; 


SELECT 
    YEAR(ws.created_at) AS Year,
    QUARTER(ws.created_at) AS Quarter,
    COUNT(DISTINCT CASE
            WHEN
                utm_source = 'gsearch'
                    AND utm_campaign = 'nonbrand'
            THEN
                o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT CASE
            WHEN
                utm_source = 'gsearch'
                    AND utm_campaign = 'nonbrand'
            THEN
                ws.website_session_id
            ELSE NULL
        END) AS gsearch_nonbrand_cvr,
    COUNT(DISTINCT CASE
            WHEN
                utm_source = 'bsearch'
                    AND utm_campaign = 'nonbrand'
            THEN
                o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT CASE
            WHEN
                utm_source = 'bsearch'
                    AND utm_campaign = 'nonbrand'
            THEN
                ws.website_session_id
            ELSE NULL
        END) AS bsearch_nonbrand_cvr,
    COUNT(DISTINCT CASE
            WHEN utm_campaign = 'brand' THEN o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT CASE
            WHEN utm_campaign = 'brand' THEN ws.website_session_id
            ELSE NULL
        END) AS brand_search_cvr,
    COUNT(DISTINCT CASE
            WHEN
                utm_source IS NULL
                    AND http_referer IS NOT NULL
            THEN
                o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT CASE
            WHEN
                utm_source IS NULL
                    AND http_referer IS NOT NULL
            THEN
                ws.website_session_id
            ELSE NULL
        END) AS organic_search_cvr,
    COUNT(DISTINCT CASE
            WHEN
                utm_source IS NULL
                    AND http_referer IS NULL
            THEN
                o.order_id
            ELSE NULL
        END) / COUNT(DISTINCT CASE
            WHEN
                utm_source IS NULL
                    AND http_referer IS NULL
            THEN
                ws.website_session_id
            ELSE NULL
        END) AS direct_search_cvr
FROM
    website_sessions AS ws
        LEFT JOIN
    orders AS o ON ws.website_session_id = o.website_session_id
GROUP BY Year , Quarter; 
