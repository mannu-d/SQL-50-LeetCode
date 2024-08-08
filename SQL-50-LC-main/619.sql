
with cte as (
select num , count(*) as NumOfOcc
from MyNumbers
group by num )
select max(num) as num
from cte 
where NumOfOcc = 1 ;