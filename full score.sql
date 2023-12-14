/*
14:05
Enter your query here.
*/
select hacker_id,name from (
select
t1.hacker_id,
t1.name,
count(*) total
from hackers t1
join submissions t2 on t1.hacker_id = t2.hacker_id
join challenges t3 on t2.challenge_id = t3.challenge_id
join difficulty t4 on t4.difficulty_level = t3.difficulty_level
where t2.score = t4.score
group by 1,2
having count(*)>1
) as tab_total
order by total desc,hacker_id