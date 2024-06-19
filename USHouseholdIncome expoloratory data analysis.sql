# US HouseHold Income Data Cleaning

SELECT *
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_householdincome_statistics;

alter table us_project.us_householdincome_statistics rename column `ï»¿id` to `id`;

SELECT count(id)
FROM us_project.us_household_income;

SELECT count(id)
FROM us_project.us_householdincome_statistics;

SELECT id, count(id)
FROM us_project.us_household_income
group by id
having count(id) > 1
;

select *
from (
select row_id,
id,
Row_Number() over(partition by id order by id) row_num
FROM us_project.us_household_income
) duplicates
where row_num > 1
;

delete from us_household_income
WHERE row_id IN (
	select row_id
	from (
		select row_id,
		id,
		Row_Number() over(partition by id order by id) row_num
		FROM us_project.us_household_income
		) duplicates
where row_num > 1)
;


select distinct state_name
FROM us_project.us_household_income
order by 1
;


UPDATE us_project.us_household_income
set state_name = 'Georgia'
where state_name = 'georia';


UPDATE us_project.us_household_income
set state_name = 'Alabama'
where state_name = 'alabama';


select *
FROM us_project.us_household_income
where Place = 'Autauga County'
order by 1
;


UPDATE us_household_income
set place ='Autaugaville'
where country = 'Autauga County'
and city = 'Vinemont';



select type, count(type)
FROM us_project.us_household_income
group by type
#order by 1
;

UPDATE us_household_income
set type = 'Borough'
where type = 'Boroughs';


select Aland, Awater
FROM us_project.us_household_income
where (ALand = 0 or ALand = '' or ALand is null)
;


# US HouseHold Income Exploratory Data Analysis

SELECT *
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_householdincome_statistics;


select state_name, SUM(ALand), SUM(Awater)
FROM us_project.us_household_income
Group by state_name
order by 3 desc
limit 10;

SELECT *
FROM us_project.us_household_income u
join us_project.us_householdincome_statistics us
on u.id = us.id;


SELECT *
FROM us_project.us_household_income u
inner join us_project.us_householdincome_statistics us
	on u.id = us.id
where Mean <> 0;


SELECT u.state_name, county, type, `primary`, mean, median
FROM us_project.us_household_income u
inner join us_project.us_householdincome_statistics us
	on u.id = us.id
where Mean <> 0;


SELECT u.state_name, round(avg(mean),1), round(avg(median),1)
FROM us_project.us_household_income u
inner join us_project.us_householdincome_statistics us
	on u.id = us.id
group by u.state_name
order by 2 desc
limit 10
;




SELECT type,round(avg(mean),1), round(avg(median),1)
FROM us_project.us_household_income u
inner join us_project.us_householdincome_statistics us
	on u.id = us.id
where mean <> 0
group by 1
order by 2 desc
limit 20
;


SELECT type,count(type),round(avg(mean),1), round(avg(median),1)
FROM us_project.us_household_income u
inner join us_project.us_householdincome_statistics us
	on u.id = us.id
where mean <> 0
group by 1
having count(type) > 100
order by 3 desc
limit 20
;


select *
from us_household_income
where type = 'Community';


SELECT u.state_name, city, round(avg(mean),1),round(avg(median),1)
FROM us_project.us_household_income u
join us_project.us_householdincome_statistics us
	on u.id = us.id
group by  u.state_name, city
order by round(avg(mean),1) desc;
    