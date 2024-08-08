with CTE AS (select id, student , LEAD(id) OVER (order by id) as NEXT,
LAG(id) OVER(Order by id) as PREV
from Seat )
select CASE
WHEN (id%2<>0) AND NEXT is not NULL THEN NEXT 
WHEN (id%2=0) THEN PREV
ELSE id 
END AS id , student
from cte
order by id
