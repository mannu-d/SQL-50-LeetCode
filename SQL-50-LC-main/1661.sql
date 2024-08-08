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
