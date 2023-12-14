select 
case when grade>=8 then t1.name
else null end,
t2.grade,t1.marks
from students t1 join grades t2 on t1.marks >= t2.min_mark and t1.marks <= t2.max_mark
order by grade desc,t1.name asc,t1.marks asc