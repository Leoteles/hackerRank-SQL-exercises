/*
Enter your query here.

*/
with seq as (select row_number() over() n from information_schema.tables t1 join information_schema.tables t2 limit 1000),
qtd as (
select t1.n from seq t1 join seq t2
where t1.n>t2.n and t1.n % t2.n = 0
group by t1.n
having count(*)=1
order by t1.n)
select group_concat(cast(n as char) separator '&') from qtd