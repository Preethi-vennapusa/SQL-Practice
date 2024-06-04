/* Find the popularity percentage for each user on Meta/Facebook.
The popularity percentage is defined as the total number of friends the user has divided by the
total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
*/

drop table facebook_friends;
create table facebook_friends
    (
        user1       int,
        user2       int
    );

insert into facebook_friends values (2,1);
insert into facebook_friends values (1,3);
insert into facebook_friends values (4,1);
insert into facebook_friends values (1,5);
insert into facebook_friends values (1,6);
insert into facebook_friends values (2,6);
insert into facebook_friends values (7,2);
insert into facebook_friends values (8,3);
insert into facebook_friends values (3,9);
commit;


select * from facebook_friends;
a) Total no of users in FB -- found from cte 3
select count(distinct users) from (select user1 as users  from facebook_friends
                                  union all
                                  select user2  as users from facebook_friends) x;

b) No of friends each user has -- found from cte 2
with total_users as (select user1 as users  from facebook_friends
                                  union all
                                  select user2  as users from facebook_friends),
 total_friends as (select users,count(1) as total_frnds
                       from total_users
					   group by users)
select *
from total_friends
order by users

c) = (b / a) * 100 

with cte as (with total_users as (select user1 as users  from facebook_friends
                                  union all
                                  select user2  as users from facebook_friends),
 total_friends as (select users,count(1) as total_frnds
                       from total_users
					   group by users)
select *
from total_friends
order by users)
select users , ((total_frnds/users)* 100) as percentage
from cte
how many friends does user1 2 id have 
1+1+1 = 3
how many friends does user1 1 id have
2,3,4,5,6 = 5