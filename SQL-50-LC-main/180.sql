
with cte as (select * , lead(num) over(order by id) as next, lead(num,2) over(order by id) as next2next, LEAD(id) OVER (ORDER BY id) AS next_id,
        LEAD(id, 2) OVER (ORDER BY id) AS next2next_id
from Logs )

select  distinct num  as ConsecutiveNums
from cte
where num = next and next=next2next AND next_id = id + 1
    AND next2next_id = id + 2
