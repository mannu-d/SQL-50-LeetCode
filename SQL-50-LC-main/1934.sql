select s.user_id , CASE
WHEN c.time_stamp is NULL THEN 0.00
ELSE ROUND(SUM(action='confirmed')/Count(*),2) 
END as confirmation_rate
from Signups s
LEFT JOIN Confirmations c 
ON s.user_id = c.user_id
group by s.user_id
