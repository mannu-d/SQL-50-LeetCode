Select s.student_id , s.student_name , su.subject_name , COUNT(e.subject_name) as attended_exams
From Students s
CROSS JOIN SUBJECTS su
LEFT JOIN Examinations e
ON s.student_id= e.student_id AND su.subject_name=e.subject_name
group by s.student_id , s.student_name , su.subject_name
order by s.student_id , s.student_name , su.subject_name;