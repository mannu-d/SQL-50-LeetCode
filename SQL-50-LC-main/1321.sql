with cte as (select *, sum(amount) as TAmount
from Customer
group by visited_on ),
CTE2 as (
select visited_on , sum(Tamount) over(order by visited_on rows between 6 preceding and current row) as amount , ROUND(AVG(Tamount) over(order by visited_on rows between 6 preceding and current row),2) as average_amount  
from cte)
select *
from CTE2 
where visited_on >= ( select visited_on from cte2 order by visited_on limit 1)+6