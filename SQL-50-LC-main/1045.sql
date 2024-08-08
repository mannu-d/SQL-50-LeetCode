with cte as(
select customer_id , count(distinct product_key) as DC
from Customer 
group by customer_id )
select customer_id
from cte where DC = (select count(*) from Product)