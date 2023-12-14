/*
Enter your query here.
15:49
select t1.hacker_id,t1.name,t1.total,t2.qtd_ids from tab_qtd t1 join qtd_ids t2 on t1.total = t2.total
where qtd_ids = 1 or t1.total in (select max(total) from tab_qtd )
order by t1.total desc,t1.hacker_id

*/
with tab_qtd as (
select
t1.hacker_id,t1.name,count(distinct t2.challenge_id) as total
from hackers t1 join challenges t2 on t1.hacker_id = t2.hacker_id
group by 1,2),
qtd_ids as (
select total,count(distinct hacker_id) qtd_ids from tab_qtd group by total
)
select
t1.hacker_id,t1.name,t1.total
from tab_qtd t1 join qtd_ids t2 on t1.total = t2.total
where qtd_ids = 1 or t1.total in (select max(total) from tab_qtd )
order by t1.total desc,t1.hacker_id