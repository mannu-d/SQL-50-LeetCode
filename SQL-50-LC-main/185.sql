with cte as (
select e.id as EmpId , e.name as Employee , Salary , d.id as DepId , d.name as Department , dense_Rank() over( partition by d.name order by salary desc ) as rnk
from Employee e
INNER JOIN Department d
ON e.departmentId = d.id )
select Department , Employee , salary as Salary
from cte
where rnk<=3
