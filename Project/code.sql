SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_source, utm_campaign
FROM page_visits
ORDER BY utm_source ASC;

SELECT DISTINCT page_name
FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
    MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT(utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY COUNT(utm_campaign) DESC;

WITH last_touch AS (
    SELECT user_id,
    MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    	lt.last_touch_at,
    	Pv.utm_source,
pv.utm_campaign,
    	COUNT(utm_campaign) AS last_touches
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY COUNT(utm_campaign) DESC;

SELECT COUNT (DISTINCT user_id) AS purchases
FROM page_visits
WHERE page_name = '4 - purchase';

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
  	WHERE page_name = '4 - purchase'
    GROUP BY user_id
		)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    Count(utm_campaign) AS last_touches
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY COUNT(utm_campaign) DESC;


