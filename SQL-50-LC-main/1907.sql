with cte as(
Select account_id , CASE
WHEN income<20000 THEN 'Low Salary'
WHEN income>=20000 AND income<=50000 THEN 'Average Salary'
ELSE 'High Salary' END category
from Accounts 
),
cte2 as(
    sELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary' AS category
    UNION ALL
    SELECT 'High Salary' AS category
)
select c2.category ,  count(account_id) as accounts_count
from cte2 c2 
LEFT JOIN cte c
on c2.category = c.category 
group by c2.category
