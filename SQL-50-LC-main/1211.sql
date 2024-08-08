WITH CTE AS (
Select query_name , rating/position as ratio , CASE 
WHEN rating < 3 THEN 1 
ELSE 0 END AS PQ
from Queries 
where query_name is not null)

select query_name , Round(AVG(ratio),2) as quality , Round(sum(PQ)/count(*)*100,2) as poor_query_percentage 
from CTE 
group by query_name ;
