with cte as(
select *, DATE_FORMAT(trans_date, '%Y-%m') as month,  CASE 
WHEN state='approved' THEN 1 
ELSE 0 END AS AppDec 
from Transactions )

select month , country , count(*) as trans_count , sum(AppDec) as approved_count , sum(amount) as trans_total_amount  , SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount


from cte
group by month , country
