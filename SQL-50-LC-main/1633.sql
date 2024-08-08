select r.contest_id , ROUND(count(r.user_id)/(select count(*) from Users)*100,2) as percentage
from Users u
JOIN Register r
ON u.user_id = r.user_id 
group by r.contest_id
order by 2  desc , r.contest_id  