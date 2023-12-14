/*
Enter your query here.
with
roots as(
select distinct n,'Root' from bst where p is null),
inners as (
select distinct n,'Inner' from bst where n in (select p from bst))
select * from bst where n not in (select p from bst)
*/
with tree as(
select 
t1.n as node,
case 
when t1.p is null then 'Root'
when t2.p is null then 'Leaf'
else 'Inner' end as type
from bst t1 left join bst t2 on t1.n = t2.p
    )
select distinct node,type from tree order by node
