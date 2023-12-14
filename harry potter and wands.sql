/*
Enter your query here.
15:29
*/
select 
t1.id, t2.age, t1.coins_needed, t1.power
from (
select
t2.age,
t1.power,
min(t1.coins_needed) as coins_needed
from wands t1
join wands_property t2 on t2.code = t1.code
where t2.is_evil = 0
group by t2.age,t1.power) as min_coins
join wands t1 on t1.coins_needed = min_coins.coins_needed and t1.power = min_coins.power
join wands_property t2 on t2.code = t1.code and t2.age = min_coins.age
order by t1.power desc, t2.age desc