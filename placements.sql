select s.name
from students s
join friends f on s.id = f.id
join packages p on s.id = p.id
join packages pf on f.friend_id = pf.id
where p.salary<pf.salary
order by pf.salary



