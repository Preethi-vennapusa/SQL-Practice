select * from paintings; 
select * from artists;
select * from collectors;
select * from sales; 
--1) Find the most profitable orders. Most profitable orders are those

whose sale price exceeded the average sale price for each city and whose deal size was not small. Use CTE
select p.id as paiting_id, p.name as painting_name
, a.id as artist_id
, trim(case when no_of_paintings > 1 then concat(a.first_name,' ',a.last_name, '**')
	   else concat(a.first_name,' ',a.last_name) 
  end) as artist_name
, s.sales_price
, case when s.id is not null then 'SOLD' end as sold_or_not
from paintings p
full join artists a on p.artist_id = a.id
left join sales s on s.painting_id = p.id 
left join ( select artist_id,count(1) as no_of_paintings
			from sales 
			group by artist_id ) x on x.artist_id = a.id
			
-- WITH CTE
With cte_name as (select artist_id,count(1) as no_of_paintings
			from sales 
			group by artist_id)
select p.id as paiting_id, p.name as painting_name
, a.id as artist_id
, trim(case when no_of_paintings > 1 then concat(a.first_name,' ',a.last_name, '**')
	   else concat(a.first_name,' ',a.last_name) 
  end) as artist_name
, s.sales_price
, case when s.id is not null then 'SOLD' end as sold_or_not
from paintings p
full join artists a on p.artist_id = a.id
left join sales s on s.painting_id = p.id 
left join  cte_name on cte_name.artist_id = a.id



-- ASIGNMENT: Solve the above problem without using FULL JOIN
select p.id as paiting_id, p.name as painting_name
, a.id as artist_id
, trim(case when no_of_paintings > 1 then concat(a.first_name,' ',a.last_name, '**')
	   else concat(a.first_name,' ',a.last_name) 
  end) as artist_name
, s.sales_price
, case when s.id is not null then 'SOLD' end as sold_or_not
from paintings p
left join artists a on p.artist_id = a.id
left join sales s on s.painting_id = p.id 
left join ( select artist_id,count(1) as no_of_paintings
			from sales 
			group by artist_id ) x on x.artist_id = a.id
union all
select p.id as paiting_id, p.name as painting_name
, a.id as artist_id
, trim(case when no_of_paintings > 1 then concat(a.first_name,' ',a.last_name, '**')
	   else concat(a.first_name,' ',a.last_name) 
  end) as artist_name
, s.sales_price
, case when s.id is not null then 'SOLD' end as sold_or_not
from paintings p
right join artists a on p.artist_id = a.id
left join sales s on s.painting_id = p.id 
left join ( select artist_id,count(1) as no_of_paintings
			from sales 
			group by artist_id ) x on x.artist_id = a.id

select a.id, concat(a.first_name,' ',a.last_name) as artist_name
, coalesce(sum(sales_price),0) as total_price
, count(s.id) as no_of_painting_sold
from artists a
left join sales s on s.artist_id = a.id
group by a.id,a.first_name,a.last_name
order by a.id

3) Find how much each artist made from sales. And how many paintings did they sell.
select id ,coalesce(sales,0) , no_of_paintings
from(select artist_id , sum(sales_price) as sales
from sales
group by artist_id) x
right join (select a.id , count(s.painting_id) as no_of_paintings
from artists a
left join sales s on s.artist_id = a.id 
group by a.id) y on y.id = x.artist_id




select b.id , coalesce(total_price,0) as total_price, no_of_painting_sold
from (select artist_id, sum(sales_price) as total_price
	from sales s
	group by artist_id) a
right join 
	(select a.id, count(s.id) as no_of_painting_sold
	from artists a
	left join sales s on s.artist_id = a.id
	group by a.id) b
		on a.artist_id = b.id
order by 1;


1) Fetch names of all the artists along with their painting name.
    If an artist does not have a painting yet, display as "NA"
select   concat(a.first_name,' ',a.last_name),coalesce(p.name,'NA') as painting_name,
case when p.name = 'Miracle' then 'NA'
else p.name
end as painting_name
from artists a
join paintings p on p.artist_id = a.id

6) Suppose you insert the below 2 records to the artists table. 
Write a query to identify the duplicate artists.
delete from artists
where id not in (select min(id)
       from artists
        group by first_name , last_name
        )
		select * from artists_bkp
create table artists_bkp 
	as
	select min(id) as id, first_name, last_name
	from artists 
	group by first_name, last_name;		
insert into artists values (5,'Kate','Smith');
insert into artists values (6,'Natali','Wein');
insert into artists values (7,'Kate','Smith');
insert into artists values (8,'Natali','Wein');

    insert into artists values (5,'Kate','Smith');
    insert into artists values (6,'Natali','Wein');
								
	
5) Find the names of the artists who had zero sales.
select a.id, concat(a.first_name,' ',a.last_name)
from artists a
where not exists (select artist_id
				 from sales s
				 where s.artist_id = a.id)
select a.id, concat(a.first_name,' ',a.last_name)
from artists a
where a.id not in (select s.artist_id
				 from sales s
				 )

select (a.first_name||' '||a.last_name) as artist_name, a.id
from artists a
where not exists (select 1
				  from sales s
				  where s.artist_id = a.id);

3) Fetch the total amount of sales for each artist who has sold at least one painting.
Display artist name and total sales amount
select concat(a.first_name,' ',a.last_name),a.id, total_sales
from artists a 
join(
select artist_id , sum(sales_price) as total_sales
from sales
group by artist_id) s on s.artist_id =a.id

select concat(a.first_name,' ',a.last_name) as artist_name , sum(s.sales_price)
from sales s
join artists a on a.id = s.artist_id
group by artist_name

5) Find the names of the artists who had zero sales.
select concat(a.first_name,' ',a.last_name) as artist_names
from artists a
where 

3) Fetch the total amount of sales for each artist who has sold at least one painting.
Display artist name and total sales amount

select concat(a.first_name,' ',a.last_name) as artist_name
, s.total_sales_amt
from artists a
join (select artist_id, sum(sales_price) as total_sales_amt -- return a resultset
	  from sales
	  group by artist_id) s on a.id = s.artist_id;

select concat(a.first_name,' ',a.last_name) as artist_name
, sum(sales_price) as total_sales_amt
from sales s
join artists a on a.id = s.artist_id
group by artist_name;

select sum(s.sales_price) as total_sales
from sales s
group by s.artist_id
join (
select concat(first_name,' ',last_name)
from artists) a on a.id = s.artist_id;

select concat(a.first_name,' ',a.last_name)
from artists a
join( select sum(sales_price) as total_sales
from sales 
group by artist_id) s on a.id = s.artist_id;
2) Fetch all collectors who purchased paintings.
select *
from collectors
where id in (select collector_id from sales)

select * 
from collectors c
where c.id in (select distinct collector_id from sales);
1) Fetch paintings that are priced higher than the average painting price.
select *
from paintings 
where listed_price > (select avg(listed_price)
					  from paintings)




drop table paintings;
drop table artists;
drop table collectors;
drop table sales;


create table paintings
(
    id              int,
    name            varchar(40),
    artist_id       int,
    listed_price    float
);

create table artists
(
    id              int,
    first_name      varchar(40),
    last_name       varchar(40)
);

create table collectors
(
    id              int,
    first_name      varchar(40),
    last_name       varchar(40)
);

create table sales
(
    id                  int,
    sale_date           date,
    painting_id         int,
    artist_id           int,
    collector_id        int,
    sales_price         float
);


insert into paintings values (11,'Miracle',1,300);
insert into paintings values (12,'Sunshine',1,700);
insert into paintings values (13,'Pretty woman',2,2800);
insert into paintings values (14,'Handsome man',2,2300);
insert into paintings values (15,'Barbie',3,250);
insert into paintings values (16,'Cool painting',3,5000);
insert into paintings values (17,'Black square #1000',3,50);
insert into paintings values (18,'Mountains',4,1300);

insert into artists values (1,'Thomas','Black');
insert into artists values (2,'Kate','Smith');
insert into artists values (3,'Natali','Wein');
insert into artists values (4,'Francesco','Benelli');

insert into collectors values (101,'Brandon','Cooper');
insert into collectors values (102,'Laura','Fisher');
insert into collectors values (103,'Christina','Buffet');
insert into collectors values (104,'Steve','Stevenson');

insert into sales values (1001,'2021-11-01',13,2,104,2500);
insert into sales values (1002,'2021-11-10',14,2,102,2300);
insert into sales values (1003,'2021-11-10',11,1,102,300);
insert into sales values (1004,'2021-11-15',16,3,103,4000);
insert into sales values (1005,'2021-11-22',15,3,103,200);
insert into sales values (1006,'2021-11-22',17,3,103,50);
 Scenario 1
create table table_1
(id int);

create table table_2
(id int);

insert into table_1 values (1),(1),(1),(2),(3),(3),(3);
insert into table_2 values (1),(1),(2),(2),(4),(null);

select * from table_1;
select * from table_2;

Questions.
select *
from table_1 t1
join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
left join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
right join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
full join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
NATURAL join table_2 t2;

select *
from table_1 t1
cross join table_2 t2;


-- Scenario 2
create table table_1
(id int);

create table table_2
(id int);

insert into table_1 values (null),(0),(null),(0),(0),(1),(1);
insert into table_2 values (1),(0),(0),(0),(null),(null);

select * from table_1;
select * from table_2;

Questions.
select *
from table_1 t1
join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
left join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
right join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
full join table_2 t2 on t1.id = t2.id;

select *
from table_1 t1
NATURAL join table_2 t2;

select *
from table_1 t1
cross join table_2 t2;

create table employee_master
(
    id          int,
    name        varchar(40),
    salary      int,
    manager_id  int
);

insert into employee_master values (1   ,'John Smith',  10000,  3);
insert into employee_master values (2   ,'Jane Anderson',   12000,  3);
insert into employee_master values (3   ,'Tom Lanon',   15000,  4);
insert into employee_master values (4   ,'Anne Connor', 20000,  null);
insert into employee_master values (5   ,'Jeremy York', 9000,   1);

select * from employee_master;
-- employee who doesn't have a manager
-- Write a query to display the employee name and their corresponding manager name.
select distinct e.name as emp_name ,m.name
from employee_master e
left join employee_master m on e.manager_id =m.id

select name
from employee_master
where manager_id is null


