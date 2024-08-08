with cte1 as (
select product_id , order_date , SUM(unit) as FebUnits
from Orders 
where month(order_date)='02' AND year(order_date)='2020'
group by product_id 
having sum(unit)>=100
),

cte2 as (
select p.product_id , p.product_name as pname , sum(o.unit) as TotalUnits
from Products p
INNER JOIN Orders o
ON p.product_id = o.product_id
group by p.product_id
)

select c2.pname as product_name , c1.FebUnits as unit
from cte1 as c1
INNER JOIN cte2 as c2
ON c1.product_id = c2.product_id ;
