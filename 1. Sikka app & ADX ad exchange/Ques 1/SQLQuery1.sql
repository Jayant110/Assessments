CREATE DATABASE Q1;
USE Q1;

SELECT * FROM User_signup;
SELECT * FROM User_offer_completion;
SELECT * FROM Rewards_details;

-- 1.
SELECT
	a.utm_source AS Marketing_channel,
	SUM(c.total_revenue_in_paise) AS Revenue_in_paise,
	COUNT(DISTINCT a.user_id) AS Total_users,
	SUM(c.total_revenue_in_paise) / COUNT(DISTINCT a.user_id) AS LTV
FROM user_signup a
	JOIN User_offer_completion b ON a.user_id = b.user_id
	JOIN Rewards_details c ON b.offer_id = c.offer_id AND b.reward_id = c.reward_id 
GROUP BY a.utm_source