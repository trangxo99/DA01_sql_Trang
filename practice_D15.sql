-- EX 1 --
WITH yearly_spend AS (
  SELECT 
  EXTRACT(YEAR FROM transaction_date) AS yr,
  product_id,
  spend AS curr_year_spend,
  LAG(spend) OVER (PARTITION BY product_id 
                   ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)) 
  AS prev_year_spend 
  FROM user_transactions )
  
SELECT yr, product_id, curr_year_spend, prev_year_spend, 
  ROUND((curr_year_spend - prev_year_spend) * 100 / prev_year_spend, 2) AS yoy_rate 
FROM yearly_spend


-- EX 2 --
WITH card_launch AS (
  SELECT 
  card_name, issued_amount,
  MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
  MIN(MAKE_DATE(issue_year, issue_month, 1)) 
  OVER (PARTITION BY card_name) AS launch_date
  FROM monthly_cards_issued )

SELECT card_name, issued_amount
FROM card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC


-- EX 3 --
WITH trans_num AS (
  SELECT user_id, spend, transaction_date, 
  ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) 
  AS row_num 
  FROM transactions )
 
SELECT user_id, spend, transaction_date 
FROM trans_num 
WHERE row_num = 3


-- EX 4 --
WITH latest_transactions_cte AS (
  SELECT transaction_date, user_id, product_id, 
  RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) 
  AS transaction_rank 
  FROM user_transactions ) 
  
SELECT transaction_date, user_id,
COUNT(product_id) AS purchase_count
FROM latest_transactions_cte
WHERE transaction_rank = 1 
GROUP BY transaction_date, user_id
ORDER BY transaction_date


-- EX 5 --
SELECT user_id, tweet_date,   
ROUND(AVG(tweet_count) 
OVER (PARTITION BY user_id ORDER BY tweet_date     
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) 
AS rolling_avg_3d
FROM tweets
/* Calculating the rolling averages using ROWS BETWEEN 2 PRECEDING AND CURRENT ROW :
06/01/2022: tweet_count is 2 = 2.0
06/02/2022: 2 + 1 = 3 / 2 days = 1.5
06/03/2022: 2 + 1 + 3 = 6 / 3 days = 2.0
06/04/2022: 1 + 3 + 4 = 8 / 3 days = 2.666...
06/05/2022: 3 + 4 + 5 = 12 / 3 days = 4.0 */


-- EX 6 --
WITH payments AS (
  SELECT 
    merchant_id, 
    EXTRACT(EPOCH FROM transaction_timestamp - 
            LAG(transaction_timestamp) 
            OVER(PARTITION BY merchant_id, credit_card_id, amount 
            ORDER BY transaction_timestamp)) / 60 
    AS minute_difference 
  FROM transactions) 

SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_difference <= 10
/* EPOCH calculates the total number of seconds in a given interval. */


-- EX 7 --
WITH top_10 AS (
  SELECT 
    a.artist_name,
    DENSE_RANK() OVER (ORDER BY COUNT(b.song_id) DESC) 
    AS artist_rank
  FROM artists as a
  INNER JOIN songs as b ON a.artist_id = b.artist_id
  INNER JOIN global_song_rank AS c ON b.song_id = c.song_id
  WHERE c.rank <= 10
  GROUP BY a.artist_name )

SELECT artist_name, artist_rank
FROM top_10
WHERE artist_rank <= 5




















