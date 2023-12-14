/*
Enter your query here.
*/
with points as (
select *, row_number() over() as idx from functions
order by x
)
select p1.x,p1.y
from points p1
join points p2 on p1.idx < p2.idx
where p1.x = p2.y and p2.x = p1.y and p1.x<=p1.y
order by p1.idx,p2.idx