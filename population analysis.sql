SELECT * FROM zomato.dataset1;

select * from zomato.dataset2;

SELECT count(*)
FROM zomato.dataset1;

select count(*)
from zomato.dataset2;

-- data set from jharkhand and bihar 
select * 
from zomato.dataset1 
where State in ('Jharkhand' , 'Bihar');

-- count of data set from Jharkhand and Bihar
select count(*) 
from zomato.dataset1 
where State in ('Jharkhand' , 'Bihar');

-- Population of India 
select * from zomato.dataset2;

SELECT sum(Population)
FROM zomato.dataset2;

-- avg growth 

select * from zomato.dataset1;

select avg(Growth)
from zomato.dataset1;
-- growth by state 
select state, avg(Growth) avg_growth 
from zomato.dataset1 
group by state;

-- sex ration by state 
select state, round(avg(Sex_Ratio),0) avg_sex_ratio 
from zomato.dataset1 
group by state
order by avg_sex_ratio desc ; 

-- avg literacy rate 
select state, avg(Literacy) avg_Literacy 
from zomato.dataset1 
group by state
order by avg_Literacy desc ; 

select state, avg(Literacy) avg_Literacy 
from zomato.dataset1 
group by state
having avg(Literacy) > 90
order by avg_Literacy desc ; 

-- top 10 state showing highest gwoth rate 
select  state, round(avg(Sex_Ratio),0) avg_sex_ratio 
from zomato.dataset1 
group by state
order by avg_sex_ratio desc  limit 10; 

-- last 10 state showing lowest sex ratio rate 

select state, round(avg(Sex_Ratio),0) avg_sex_ratio 
from zomato.dataset1 
group by state
order by avg_sex_ratio asc limit 10 ; 

-- top 3 and bootom 3 literacy rate state
drop table if exists Atopstates;
create table Atopstates 
 (state nvarchar(255) , topstates float);
 
 insert into Atopstates
 select state, round(avg(Literacy),0) avg_literacy_ratio  
from zomato.dataset1 
group by state
order by avg_literacy_ratio desc  ;

select * from Atopstates order by Atopstates.topstates desc;

use zomato;

drop table if exists Abottomstates;
create table Abottomstates 
 (state nvarchar(255) , bottomstates float);
 
 insert into Abottomstates
 select state, round(avg(Literacy),0) avg_literacy_ratio  
from zomato.dataset1 
group by state
order by avg_literacy_ratio asc  ;

select * from Abottomstates order by Abottomstates.bottomstates asc;


-- union operator 
select * from (
select * from Atopstates order by Atopstates.topstates desc limit 3) a
union 
select * from (
select * from Abottomstates order by Abottomstates.bottomstates asc limit 3) b;

-- joining both table 
select a.District, a.State , a.Sex_Ratio , b.Population
 from zomato.dataset1 a  inner join zomato.dataset2 b on a.District = b.District;  
 
 -- calculating total numbers of males and females
 -- females/males = sex ratio 
 -- male + female = population 
 -- females = population -males 
 -- population - male = sex ration* male 
 -- population = sex ratio* male + male 
 -- population = male ( sex ratio +1)
 -- male = population / (sex ratio +1)
 select d.state, ROUND(sum(d.males),0) total_males, sum(d.females) total_females from 
 (select c.District, c.State , (c.population/c.Sex_Ratio+1) males ,(c.population*c.Sex_Ratio/c.Sex_Ratio+1) females  from
( select a.District, a.State , a.Sex_Ratio/1000 Sex_Ratio , b.Population
 from zomato.dataset1 a  inner join zomato.dataset2 b on a.District = b.District) c) d
 group by d.State;
 
 
 -- total no. of literate people 
 select c.District, c.State, c.Population, c.literacy_ratio,(c.literacy_ratio*c.Population) Literate_People , ((1-c.literacy_ratio)*c.Population) illiterate_People from
 (select a.District, a.State ,  a.Literacy/100 literacy_ratio , b.Population
 from zomato.dataset1 a  inner join zomato.dataset2 b on a.District = b.District) c;
 
 select district , State, Sex_Ratio, 
 case when Sex_Ratio > 1000 then 'best sex ratio'
 when Sex_Ratio > 900 then 'good sex ratio'
 else  ' Need to impliment good policy'
 end as Sex_Ratio_Txt
 from zomato.dataset1
 order by Sex_Ratio desc;
 
 Alter table zomato.dataset1
 add column date1 int;
 
 select * from zomato.dataset1;
 
 Alter table zomato.dataset1
 drop column date1;

 
 
