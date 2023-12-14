/*
Enter your query here.
16:17
*/
select hacker_id,name,sum(tot_score) from (
select t1.hacker_id,t1.name,t2.challenge_id,max(t2.score) as tot_score
from hackers t1 join submissions t2 on t1.hacker_id = t2.hacker_id
group by 1,2,3
) as t1
group by 1,2
having sum(tot_score)>0
order by sum(tot_score) desc,hacker_id asc
