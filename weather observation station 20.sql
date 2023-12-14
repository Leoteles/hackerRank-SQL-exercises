set @maxlinha:=-1;
select round(avg(lat_n),4) from (
select lat_n,@maxlinha:=@maxlinha+1 as linha from station order by lat_n
) as t
where 
    (linha = floor(@maxlinha/2)) or (linha = ceil(@maxlinha/2))


