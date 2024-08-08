with cte as(select e1.employee_id as Emp ,  e1.name as Manager , e2.reports_to , e2.age as emp_age
from employees e1
join employees e2
on e1.employee_id = e2.reports_to
)
select emp as employee_id , manager as name , count(reports_to) as reports_count, round(AVG(emp_age),0) as average_age
from cte
group by employee_id , manager
order by employee_id