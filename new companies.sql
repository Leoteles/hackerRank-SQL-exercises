/*
Enter your query here.

with lead as (
select 
company_code,founder,count(*) t_lead
from  company t1
    join lead_manager t2 on t1.company_code = t2.company_code group by t1.company_code,t1.founder
) select * from lead

*/
select 
    t1.company_code,t1.founder,
    count(distinct t2.lead_manager_code),
    count(distinct t3.senior_manager_code),
    count(distinct t4.manager_code),
    count(distinct t5.employee_code)
    
from company t1
join lead_manager t2 on t1.company_code = t2.company_code 
join senior_manager t3 on t1.company_code = t3.company_code
join manager t4 on t1.company_code = t4.company_code
join employee t5 on t1.company_code = t5.company_code 
group by t1.company_code,t1.founder
order by t1.company_code asc