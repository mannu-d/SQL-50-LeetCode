select e.name , b.bonus
from Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
where bonus < 1000 or bonus is NULL;