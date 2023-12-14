with 
only_start as (
select start_date,row_number() over() linha 
from projects 
where start_date not in
   (select end_date from projects)),
only_end as(
select end_date,row_number() over() linha 
from projects 
where end_date not in
   (select start_date from projects))
select t1.start_date,t2.end_date 
from only_start t1 inner join only_end t2
on t1.linha=t2.linha
order by t2.end_date-t1.start_date,t1.start_date