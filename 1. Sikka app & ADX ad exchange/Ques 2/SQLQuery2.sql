CREATE DATABASE Q2;
USE Q2;

SELECT * FROM Users_signup;
SELECT * FROM User_offer;
SELECT * FROM User_offer_completion;
SELECT * FROM Rewards_details;

-- No. of users who've initiated an offer ("Sikka" and "Sikka Pro")
SELECT
	a.app_id AS App,
	COUNT(DISTINCT b.User_id) AS Total_users
FROM Users_signup a
INNER JOIN User_offer b ON a.user_id = b.user_id
	GROUP BY a.app_id

-- No. of users who've completed an offer ("Sikka" and "Sikka Pro")
SELECT
	app_id AS App,
	COUNT(DISTINCT user_id) AS Total_users
FROM User_offer_completion
	GROUP BY app_id

-- completion rate
SELECT
    CTE.*,
    FORMAT((CTE.Total_users_completed * 1.0) / CTE.Total_users_initiated, 'P2') AS Completion_rate
FROM (
	  SELECT 
	      a.app_id AS App, 
          COUNT(DISTINCT b.User_id) AS Total_users_initiated, 
          COUNT(DISTINCT c.user_id) AS Total_users_completed
      FROM Users_signup a
          INNER JOIN User_offer b ON a.user_id = b.user_id
          LEFT JOIN User_offer_completion c ON a.app_id = c.app_id AND b.user_id = c.user_id
      GROUP BY a.app_id ) CTE

-- Users payout and revenue generated ("Sikka" and "Sikka Pro") 
SELECT
	a.app_id AS App,
	COUNT(DISTINCT a.user_id) AS Total_users,
	SUM(b.total_payout_in_paise)/100 AS Total_payout_INR,
	SUM(b.total_revenue_in_paise)/100 AS Total_Revenue_INR,
	(SUM(b.total_revenue_in_paise)/100) / COUNT(DISTINCT a.user_id) AS Revenue_per_customer
FROM User_offer_completion a
	INNER JOIN Rewards_details b ON a.reward_id = b.reward_id
GROUP BY a.app_id