with cte1 as(
    select concat(lat,',',lon) as Location
    from Insurance
    group by lat, lon
    having count(distinct pid)>1
),
cte2 as ( 
select distinct i1.*
from Insurance i1
LEFT JOIN Insurance i2
ON i1.tiv_2015 = i2.tiv_2015
where i1.pid<>i2.pid
AND concat(i1.lat,',',i1.lon) not in ( select location from cte1)
)

select round(sum(tiv_2016),2) as tiv_2016
from cte2
