## 584
```SQL
select name from customer where referee_id <> 2 or referee_id is NULL ;
```
## 1757
```SQL
select product_id from Products where low_fats='Y' and recyclable='Y';
```
## 595
```SQL
select name, population , area from World where ( population >=25000000) or (area>=3000000);
```
## 1148
```SQL
SELECT DISTINCT author_id AS id 
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;
```
## 1378
```SQL
select EmployeeUNI.unique_id , Em.name from Employees as Em
left join EmployeeUNI on  EmployeeUNI.id= Em.id ;
```
## 1683
```SQL
select tweet_id from Tweets as T where LENGTH(content)>15;
```
## 1068
```SQL
select Product.product_name , Sales.year , Sales.price from Sales , Product 
where Product.product_id = Sales.product_id ; 
```
## 1581
```SQL
select Product.product_name , Sales.year , Sales.price from Sales , Product 
where Product.product_id = Sales.product_id ; 
```
## 197
```SQL
SELECT Wtr.id
FROM Weather AS Wtr
INNER JOIN Weather AS Wthr
  ON (DATE_SUB(Wtr.recordDate, INTERVAL 1 DAY) = Wthr.recordDate)
WHERE Wtr.temperature > Wthr.temperature;
```
## 1661
```sql
with CTE1 AS (select machine_id, sum(timestamp) as START
from Activity
where activity_type='start'
group by machine_id),
CTE2 AS (select machine_id, sum(timestamp) as END
from Activity
where activity_type='END'
group by machine_id),
CTE4 AS (
select machine_id,count( distinct process_id) as DPid
from Activity
group by machine_id),

CTE3 AS (
select C1.machine_id , c2.END - C1.START as Diff
FROM CTE1 C1
INNER JOIN CTE2 C2
ON C1.machine_id = C2.machine_id )
select c3.machine_id , ROUND(c3.diff/c4.DPid,3) as processing_time
FROM CTE3 C3
INNER JOIN CTE4 C4
ON C3.machine_id = C4.machine_id
```
## 577
```sql
select e.name , b.bonus
from Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
where bonus < 1000 or bonus is NULL;
```
## 1280
```sql
Select s.student_id , s.student_name , su.subject_name , COUNT(e.subject_name) as attended_exams
From Students s
CROSS JOIN SUBJECTS su
LEFT JOIN Examinations e
ON s.student_id= e.student_id AND su.subject_name=e.subject_name
group by s.student_id , s.student_name , su.subject_name
order by s.student_id , s.student_name , su.subject_name;
```
## 570
```sql
select name
from Employee 
where id in (select managerId
from Employee
group by managerId 
having count(managerId)>=5)
```
## 1934
```sql
select s.user_id , CASE
WHEN c.time_stamp is NULL THEN 0.00
ELSE ROUND(SUM(action='confirmed')/Count(*),2) 
END as confirmation_rate
from Signups s
LEFT JOIN Confirmations c 
ON s.user_id = c.user_id
group by s.user_id
```
## 620
```sql
select id,movie,description,rating 
from Cinema 
where (id%2<>0) and description not in ("boring")
order by rating desc;
```
## 1251
```sql
select p.product_id ,  COALESCE(ROUND(sum(p.price*us.units)/sum(units),2),0) as average_price
from Prices p
LEFT JOIN UnitsSold us
ON p.product_id=us.product_id AND us.purchase_date between p.start_date and p.end_date
group by 1;
```
## 1075
```sql
select p.project_id , ROUND(AVG(e.experience_years),2) AS average_years
from Project p
INNER JOIN Employee e
ON p.employee_id = e.employee_id 
group by p.project_id 
```
## 1633
```sql
select r.contest_id , ROUND(count(r.user_id)/(select count(*) from Users)*100,2) as percentage
from Users u
JOIN Register r
ON u.user_id = r.user_id 
group by r.contest_id
order by 2  desc , r.contest_id  
```
## 1211
```sql
WITH CTE AS (
Select query_name , rating/position as ratio , CASE 
WHEN rating < 3 THEN 1 
ELSE 0 END AS PQ
from Queries 
where query_name is not null)

select query_name , Round(AVG(ratio),2) as quality , Round(sum(PQ)/count(*)*100,2) as poor_query_percentage 
from CTE 
group by query_name ;
```
## 1193
```sql
with cte as(
select *, DATE_FORMAT(trans_date, '%Y-%m') as month,  CASE 
WHEN state='approved' THEN 1 
ELSE 0 END AS AppDec 
from Transactions )

select month , country , count(*) as trans_count , sum(AppDec) as approved_count , sum(amount) as trans_total_amount  , SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount


from cte
group by month , country
```
## 1174
```sql

WITH
  CustomerToIsImmediate AS(
    SELECT
      DISTINCT customer_id,
      FIRST_VALUE(order_date = customer_pref_delivery_date) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
      ) is_immediate
    FROM Delivery
  )
SELECT ROUND(AVG(is_immediate) * 100, 2) immediate_percentage
FROM CustomerToIsImmediate;
```
## 550
```sql
WITH
  Players AS (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY 1
  )
SELECT ROUND(
    COUNT(Players.player_id) / (
      SELECT COUNT(DISTINCT Activity.player_id)
      FROM Activity
    ),
    2
  ) AS fraction
FROM Players
INNER JOIN Activity
  ON (
    Players.player_id = Activity.player_id
    AND DATEDIFF(Players.first_login, Activity.event_date) = -1)
```
## 2356
```sql
select teacher_id , count(distinct subject_id) as cnt
from Teacher 
group by teacher_id
```
## 1141
```sql
select activity_date as day , count(distinct user_id) as active_users
from Activity 
where activity_date> '2019-06-27' AND activity_date <= '2019-07-27'
group by activity_date ;
```
## 1170
```sql
with cte as (select  * , rank() over( partition by product_id order by year) as rnk
from Sales 
)
select product_id  , year as first_year , quantity , price
from cte
where rnk=1
```
## 596
```sql
select class
from Courses 
group by class
having count(distinct student)>=5;
```
## 1729
```sql
select user_id , count(distinct follower_id) as followers_count
from Followers
group by user_id
```
## 619
```sql

with cte as (
select num , count(*) as NumOfOcc
from MyNumbers
group by num )
select max(num) as num
from cte 
where NumOfOcc = 1 ;
```
## 1045
```sql
with cte as(
select customer_id , count(distinct product_key) as DC
from Customer 
group by customer_id )
select customer_id
from cte where DC = (select count(*) from Product)
```
## 1731
```sql
with cte as(select e1.employee_id as Emp ,  e1.name as Manager , e2.reports_to , e2.age as emp_age
from employees e1
join employees e2
on e1.employee_id = e2.reports_to
)
select emp as employee_id , manager as name , count(reports_to) as reports_count, round(AVG(emp_age),0) as average_age
from cte
group by employee_id , manager
order by employee_id
```
## 1789
```sql
select employee_id , department_id
from Employee
group by  employee_id 
having count(employee_id)=1

UNION 

select employee_id , department_id
from Employee
where primary_flag = 'Y'
group by employee_id
```
## 610
```sql
select *, case when x+y>z and x+z>y and y+z>x then "Yes"
else "No" end as triangle 
from Triangle;
```
## 180
```sql

with cte as (select * , lead(num) over(order by id) as next, lead(num,2) over(order by id) as next2next, LEAD(id) OVER (ORDER BY id) AS next_id,
        LEAD(id, 2) OVER (ORDER BY id) AS next2next_id
from Logs )

select  distinct num  as ConsecutiveNums
from cte
where num = next and next=next2next AND next_id = id + 1
    AND next2next_id = id + 2
```
## 1164
```sql
WITH
  RankedProducts AS (
    SELECT
      product_id,
      new_price,
      RANK() OVER(
        PARTITION BY product_id
        ORDER BY change_date DESC
      ) AS `rank`
    FROM Products
    WHERE change_date <= '2019-08-16'
  ),
  ProductToLatestPrice AS (
    SELECT product_id, new_price
    FROM RankedProducts
    WHERE `rank` = 1
  )
SELECT
  Products.product_id,
  IFNULL(ProductToLatestPrice.new_price, 10) AS price
FROM Products
LEFT JOIN ProductToLatestPrice
  USING (product_id)
GROUP BY 1;
```
## 1204
```sql
WITH CTE AS (
select *, SUM(Weight) OVER( Order by turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TOTAL 
from Queue)

SELECT person_name
FROM CTE
WHERE TOTAL<=1000
order by TOTAL DESC
LIMIT 1
```
## 1907
```sql
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
```
## 1978
```sql
select employee_id
from Employees
where salary<30000 AND manager_id not in (select employee_id from Employees)
order by employee_id
```
## 626
```sql 
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
```
## 1341
```sql
(
  SELECT Users.name AS results
  FROM MovieRating
  INNER JOIN Users
    USING (user_id)
  GROUP BY user_id
  ORDER BY COUNT(MovieRating.movie_id) DESC, Users.name
  LIMIT 1
)
UNION ALL
(
  SELECT Movies.title AS results
  FROM MovieRating
  INNER JOIN Movies
    USING (movie_id)
  WHERE DATE_FORMAT(created_at, '%Y-%m') = '2020-02'
  GROUP BY movie_id
  ORDER BY AVG(MovieRating.rating) DESC, Movies.title
  LIMIT 1
);
```
## 1321
```sql
with cte as (select *, sum(amount) as TAmount
from Customer
group by visited_on ),
CTE2 as (
select visited_on , sum(Tamount) over(order by visited_on rows between 6 preceding and current row) as amount , ROUND(AVG(Tamount) over(order by visited_on rows between 6 preceding and current row),2) as average_amount  
from cte)
select *
from CTE2 
where visited_on >= ( select visited_on from cte2 order by visited_on limit 1)+6
```
## 602
```sql
WITH
  AllIds AS (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
  )
SELECT
  id,
  COUNT(*) AS num
FROM AllIds
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
```
## 585
```sql
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
```
## 185
```sql
with cte as (
select e.id as EmpId , e.name as Employee , Salary , d.id as DepId , d.name as Department , dense_Rank() over( partition by d.name order by salary desc ) as rnk
from Employee e
INNER JOIN Department d
ON e.departmentId = d.id )
select Department , Employee , salary as Salary
from cte
where rnk<=3
```
## 1667
```sql
SELECT user_id , CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
order by user_id
```
## 1527
```sql
select *
from Patients
where conditions like 'DIAB1%' or conditions like '% DIAB1%'
```
## 196
```sql 
delete  P1
FROM Person P1 JOIN Person P2
where (P1.email = P2.email) AND P1.id > P2.id;
```
## 176
```sql
select max(salary) as SecondHighestSalary
from Employee
where salary not in (select max(salary)
from Employee
)
```
## 1484
```sql

select sell_date , count(distinct product) as num_sold, GROUP_CONCAT(DISTINCT product order by product) as products
from Activities
group by sell_date;
```
## 1327
```sql
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
```
## 1517
```sql
SELECT *
FROM Users 
WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode[.]com$');
```


