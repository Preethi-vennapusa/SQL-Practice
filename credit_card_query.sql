drop table if exists Card_base;
create table if not exists Card_base
(
	Card_Number		varchar(50),
	Card_Family		varchar(30),
	Credit_Limit	int,
	Cust_ID			varchar(20)
);


drop table if exists Customer_base;
create table if not exists Customer_base
(
	Cust_ID						varchar(20),
	Age 						int,
	Customer_Segment			varchar(30),
	Customer_Vintage_Group		varchar(20)
);


drop table if exists Fraud_base;
create table if not exists Fraud_base
(
	Transaction_ID		varchar(20),
	Fraud_Flag			int
);


drop table if exists Transaction_base;
create table if not exists Transaction_base
(
	Transaction_ID			varchar(20),
	Transaction_Date		date,
	Credit_Card_ID			varchar(50),
	Transaction_Value		decimal,
	Transaction_Segment		varchar(20)
);
select * from Card_base; -- 500 
select * from Customer_base; -- 5674
select * from Fraud_base; -- 109
select * from Transaction_base; -- 10000
6) Identify the customer who has done the most transaction value without involving in any fraudulent transactions.
select crd.cust_id, sum(transaction_value) as total_trns_value
from Transaction_base trn
join Card_base crd on crd.card_number = trn.credit_card_id
where crd.cust_id not in (select distinct crd.cust_id
						from Fraud_base frd 
						join Transaction_base trn on frd.transaction_id = trn.transaction_id
						join Card_base crd on crd.card_number = trn.credit_card_id)
group by crd.cust_id
order by total_trns_value desc
limit 1;

select c.cust_id , sum(t.transaction_value)
from customer_base c
join card_base ca on ca.cust_id = c.cust_id
join transaction_base t  on t.credit_card_id = ca.card_number
join fraud_base f on f.transaction_id = t.transaction_id
group by c.cust_id
order by sum(t.transaction_value) desc
limit 1





6) Identify the customer who has done the most transaction value without involving in any fraudulent transactions.
select sum(transaction_value) as transaction_value , s.cust_id
from card_base c
join transaction_base t on t.credit_card_id = c.card_number
join Fraud_base f on f.transaction_id=t.transaction_id
join customer_base s on s.cust_id = c.cust_id
where t.transaction_id not in f.transaction_id
group by s.cust_id

5) Identify the month when highest no of fraudulent transactions occured.
select to_char(transaction_date,'MON') as mon, count(1) as no_of_fraud_trns
	from Transaction_base trn
	join Fraud_base frd on frd.transaction_id=trn.transaction_id
	group by to_char(transaction_date,'MON')
	order by no_of_fraud_trns desc
	limit 1;
	
select (to_char(transaction_date,'MON')) as mon, count(1) as no_of_fraud_trns
	from Transaction_base trn
	join Fraud_base frd on frd.transaction_id=trn.transaction_id
	group by to_char(transaction_date,'MON')
	order by no_of_fraud_trns desc
	Limit 1
select to_char(transaction_date,'Mon') as mon
from transaction_base 

4) What is the average age of customers who are involved in fraud transactions based on different card type?
select c.card_family , avg(s.age)
from card_base c
join transaction_base t on t.credit_card_id = c.card_number
join fraud_base f on f.transaction_id = t.transaction_id
join customer_base s on s.cust_id = c.cust_id
where f.fraud_flag = 1 
group by c.card_family

select card_family, avg(age)
	from Transaction_base trn
	join Fraud_base frd on frd.transaction_id=trn.transaction_id
	join Card_base crd on trn.credit_card_id = crd.card_number
	join customer_base cst on cst.cust_id=crd.cust_id
	group by card_family


3) Identify the range of credit limit of customer who have done fraudulent transactions.
select min(c.credit_limit) , max(c.credit_limit)
from card_base c
join transaction_base t on t.credit_card_id = c.card_number
join fraud_base f on f.transaction_id = t.transaction_id
where f.fraud_flag =1

select min(credit_limit), max(credit_limit)
	from Transaction_base trn
	join Fraud_base frd on frd.transaction_id=trn.transaction_id
	join Card_base crd on trn.credit_card_id = crd.card_number;


2) What kind of customers can get a Premium credit card?
select s.customer_segment
from card_base c
join customer_base s on s.cust_id = c.cust_id
where c.card_family = 'Premium'
group by s.customer_segment

select  distinct customer_segment
	from Card_base crd
	join Customer_base cst on cst.cust_id = crd.cust_id
	where card_family = 'Premium';
1) How many customers have done transactions over 49000?
select count( distinct c.cust_id)
from card_base c
join transaction_base t on t.credit_card_id = c.card_number
where t.transaction_value>49000;


select count(distinct cust_id) as no_of_customers
	from Transaction_base trn
	join Card_base crd on trn.credit_card_id = crd.card_number
	where trn.transaction_value > 49000;
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7106-4239-7093-1515", "Gold", 18000, "CC12076");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6492-5655-8241-3530", "Premium", 596000, "CC97173");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2868-5606-5152-5706", "Gold", 27000, "CC55858");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1438-6906-2509-8219", "Platinum", 142000, "CC90518");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2764-7023-8396-5255", "Gold", 50000, "CC49168");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4864-7119-5608-7611", "Premium", 781000, "CC66746");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5160-8427-6529-3274", "Premium", 490000, "CC28930");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6691-5105-1556-4131", "Premium", 640000, "CC76766");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1481-2536-2178-7547", "Premium", 653000, "CC18007");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1355-1728-8274-9593", "Premium", 660000, "CC23267");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9621-6787-7890-7470", "Platinum", 53000, "CC52613");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6385-4594-8055-9081", "Premium", 737000, "CC96267");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2595-8621-2855-9119", "Premium", 564000, "CC22050");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7214-4915-6387-5429", "Platinum", 172000, "CC72302");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7908-3850-6633-2606", "Gold", 43000, "CC71044");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6574-5513-6101-1905", "Gold", 13000, "CC95639");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4203-2936-4855-8802", "Gold", 35000, "CC19302");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6239-8641-8524-9441", "Gold", 26000, "CC18438");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1259-5241-3561-1773", "Gold", 31000, "CC96267");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1113-9175-3253-8426", "Gold", 4000, "CC51598");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6244-6800-1680-7174", "Premium", 751000, "CC43306");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6228-9033-3508-8121", "Gold", 33000, "CC36771");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1466-1600-9312-7604", "Premium", 249000, "CC60926");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6557-2662-6932-6028", "Platinum", 96000, "CC21717");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9310-6095-5617-9905", "Gold", 6000, "CC31781");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7586-6475-9618-3909", "Gold", 37000, "CC51908");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1410-9622-6092-3445", "Premium", 508000, "CC30635");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5088-4839-2639-6414", "Premium", 405000, "CC72942");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9074-3311-4009-9836", "Gold", 13000, "CC27334");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7179-9253-8424-9313", "Premium", 899000, "CC32209");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1846-7945-5251-4091", "Premium", 752000, "CC99214");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6722-7299-6082-7974", "Gold", 34000, "CC87034");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1235-8656-9164-2644", "Premium", 307000, "CC16796");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8794-7936-2566-9238", "Gold", 4000, "CC36590");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2640-5294-8252-8817", "Platinum", 197000, "CC70762");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1652-7516-1273-1992", "Platinum", 180000, "CC62994");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4803-9564-9708-3189", "Platinum", 109000, "CC73157");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3513-5475-4629-7570", "Gold", 40000, "CC20216");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7843-4724-2851-6218", "Gold", 4000, "CC11887");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2570-5181-2062-7588", "Platinum", 180000, "CC45544");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1749-4777-2532-7766", "Platinum", 135000, "CC64380");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3544-7836-9589-7635", "Premium", 332000, "CC97882");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8272-7202-4112-6502", "Premium", 395000, "CC77470");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5618-9718-9367-2102", "Gold", 14000, "CC59340");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8725-3610-8060-2617", "Premium", 123000, "CC34943");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9446-5484-2517-1811", "Gold", 42000, "CC53465");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7908-2695-7391-7499", "Gold", 34000, "CC53797");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1782-5331-5899-1813", "Premium", 749000, "CC48867");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8138-6235-7062-6142", "Premium", 792000, "CC25727");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3991-7326-9292-2844", "Premium", 128000, "CC58936");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4375-1627-3683-5900", "Gold", 34000, "CC70438");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4314-6417-5269-5130", "Platinum", 171000, "CC59570");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5814-6146-3149-1775", "Gold", 46000, "CC53348");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8757-6814-8721-3839", "Gold", 46000, "CC51953");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2535-9251-5633-3656", "Premium", 225000, "CC46148");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5296-2987-4365-6870", "Gold", 20000, "CC63178");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8509-8871-7296-2015", "Gold", 48000, "CC17004");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1750-2387-4085-7042", "Gold", 22000, "CC73804");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6547-1222-2350-2503", "Gold", 28000, "CC57048");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5564-7149-9280-5472", "Platinum", 155000, "CC19496");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7199-4140-9327-8875", "Platinum", 119000, "CC35304");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9933-8699-5268-4345", "Premium", 206000, "CC70398");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6075-5795-3555-1281", "Premium", 469000, "CC70548");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5092-6820-3830-6560", "Premium", 633000, "CC33848");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3594-2190-6052-1265", "Platinum", 162000, "CC81396");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7815-7711-6866-1320", "Premium", 301000, "CC25731");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1464-1118-5953-6424", "Premium", 303000, "CC14152");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9991-4727-7710-2269", "Premium", 341000, "CC97660");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9356-9491-6534-8313", "Premium", 355000, "CC14701");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7900-3001-7632-4005", "Gold", 30000, "CC94038");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4663-3168-7059-6778", "Premium", 204000, "CC44646");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5984-2442-3351-3695", "Gold", 10000, "CC69750");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7665-2468-6158-3511", "Premium", 185000, "CC81252");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3001-2844-6540-3608", "Gold", 28000, "CC95631");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5094-8484-5014-6152", "Premium", 650000, "CC66803");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6697-9358-9213-4896", "Gold", 13000, "CC89895");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5005-7427-6443-4284", "Platinum", 112000, "CC64111");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5747-7372-2770-2325", "Premium", 339000, "CC38028");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5978-8449-1139-4565", "Gold", 30000, "CC93137");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9030-1667-6058-6173", "Premium", 426000, "CC61186");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9961-2869-2603-3317", "Platinum", 131000, "CC43568");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4265-2692-1676-5635", "Premium", 683000, "CC14547");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9627-1907-4419-6606", "Platinum", 103000, "CC16925");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3380-5311-6073-9478", "Platinum", 190000, "CC71781");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1175-3754-1370-5515", "Gold", 30000, "CC95072");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4784-5120-3581-6184", "Gold", 35000, "CC27225");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3414-4178-9784-9954", "Premium", 331000, "CC23320");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6399-9536-6027-1857", "Premium", 401000, "CC88518");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4040-7464-4000-3447", "Gold", 24000, "CC22650");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8950-6403-2080-8100", "Gold", 20000, "CC46165");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9027-9319-4091-7718", "Gold", 20000, "CC21935");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5619-4425-5473-6565", "Premium", 730000, "CC23352");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4563-2673-5152-4847", "Gold", 29000, "CC32126");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1559-8764-1659-4317", "Gold", 12000, "CC95241");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3168-6552-9936-1500", "Gold", 37000, "CC23267");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4012-7774-6690-7055", "Platinum", 159000, "CC29686");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7677-5937-2671-3687", "Gold", 38000, "CC55171");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9458-1130-5333-6475", "Platinum", 166000, "CC57989");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5583-9751-6086-5673", "Premium", 160000, "CC66044");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4046-1968-8375-3680", "Platinum", 81000, "CC24888");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5734-5619-8469-4044", "Gold", 36000, "CC87306");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1693-2036-4352-9386", "Premium", 635000, "CC26324");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8287-3054-9804-9342", "Gold", 23000, "CC96154");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8797-7761-7623-1806", "Gold", 15000, "CC55201");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5447-4124-3337-6163", "Platinum", 58000, "CC91817");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5957-5032-1448-8189", "Premium", 881000, "CC46521");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7164-1323-2737-4112", "Gold", 43000, "CC13757");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4310-3710-6743-6385", "Gold", 46000, "CC61838");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5689-2440-9593-1931", "Premium", 672000, "CC96697");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2271-9253-1553-2843", "Premium", 313000, "CC76150");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3226-1711-7076-2949", "Platinum", 122000, "CC17722");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8691-3939-1859-5937", "Premium", 151000, "CC33574");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5750-8229-8026-8893", "Gold", 21000, "CC36555");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5993-5660-3442-6277", "Gold", 30000, "CC74753");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6994-7925-9044-3458", "Premium", 605000, "CC47609");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6514-4444-5642-2615", "Premium", 356000, "CC60423");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2088-6665-3327-6898", "Gold", 8000, "CC36641");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7908-8365-2086-2481", "Gold", 35000, "CC35750");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8477-4051-5606-6540", "Gold", 49000, "CC33589");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4783-2852-8264-4966", "Platinum", 174000, "CC52481");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8590-6850-6104-5846", "Gold", 29000, "CC34574");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6575-1457-7757-9141", "Gold", 45000, "CC16994");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7017-9570-4103-5076", "Gold", 28000, "CC41412");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8783-7271-8493-7931", "Premium", 677000, "CC39128");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6015-9255-9994-6771", "Premium", 787000, "CC64725");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2388-1652-4326-6035", "Premium", 854000, "CC69012");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8069-5321-4131-7493", "Platinum", 74000, "CC65981");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2347-2804-9899-1830", "Gold", 31000, "CC62204");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8376-2481-1705-6329", "Gold", 6000, "CC44192");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5129-6974-6371-2964", "Gold", 31000, "CC62968");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4341-6411-1439-6094", "Gold", 41000, "CC30988");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5591-5619-8809-5454", "Platinum", 140000, "CC79161");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3458-8126-3660-8686", "Gold", 9000, "CC15883");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7583-5046-7750-5578", "Premium", 552000, "CC30342");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2568-8047-9427-1704", "Gold", 17000, "CC50301");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7168-9862-2659-8550", "Platinum", 74000, "CC13238");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1893-8853-9900-8478", "Premium", 417000, "CC11165");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2517-1247-3682-9050", "Platinum", 142000, "CC65030");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8361-7488-5303-1801", "Gold", 28000, "CC75139");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4139-7870-9436-2923", "Gold", 16000, "CC51400");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9138-8487-6675-4521", "Platinum", 188000, "CC40226");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8408-7680-2338-9105", "Platinum", 200000, "CC63145");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1123-9777-7335-9167", "Premium", 147000, "CC43524");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5695-2379-4433-2485", "Platinum", 66000, "CC36120");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4819-6940-5506-8061", "Platinum", 82000, "CC90127");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2944-6929-3608-9991", "Premium", 892000, "CC37044");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8883-9569-6241-3952", "Gold", 41000, "CC31583");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6315-7338-3105-9947", "Premium", 406000, "CC38543");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9161-8723-1217-5269", "Premium", 866000, "CC89243");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3810-4783-2207-7703", "Gold", 49000, "CC75362");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5786-9833-8038-2159", "Premium", 618000, "CC65775");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5894-8042-7318-9450", "Premium", 677000, "CC38368");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7377-5503-9688-7953", "Platinum", 105000, "CC19835");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5731-9804-7859-1641", "Gold", 11000, "CC82924");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8217-2336-2393-6960", "Platinum", 128000, "CC23156");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2447-6299-5016-4953", "Premium", 497000, "CC25881");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4525-4818-6014-8945", "Premium", 883000, "CC41775");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9083-6711-4313-1181", "Platinum", 138000, "CC23204");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7199-6959-4688-2302", "Gold", 49000, "CC68010");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4027-9234-2261-8201", "Platinum", 114000, "CC63227");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8066-8437-2479-2481", "Platinum", 135000, "CC97360");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8904-2491-3727-6958", "Gold", 27000, "CC38471");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7362-1637-8977-1963", "Premium", 881000, "CC72351");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9157-2802-8374-1145", "Premium", 656000, "CC59562");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1350-6303-6190-5958", "Premium", 608000, "CC85396");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7224-9964-4793-3939", "Premium", 619000, "CC22992");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6071-3874-2856-8755", "Gold", 22000, "CC91701");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8558-3872-8287-1977", "Premium", 330000, "CC93405");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6429-7684-3108-1910", "Premium", 581000, "CC86100");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5563-4162-6828-9835", "Premium", 330000, "CC25855");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8793-4049-9771-8176", "Premium", 844000, "CC92551");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4834-4297-3113-9327", "Gold", 50000, "CC47195");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3467-4873-4196-4795", "Premium", 432000, "CC50434");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4843-3880-6792-2259", "Premium", 373000, "CC38739");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8088-9431-7201-2877", "Premium", 548000, "CC94516");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5540-8588-7666-7798", "Gold", 24000, "CC29712");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8052-5734-6162-9591", "Premium", 702000, "CC72916");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3762-3694-9841-5446", "Gold", 22000, "CC95014");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1616-5911-1676-5466", "Platinum", 61000, "CC15024");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5206-5979-9383-4538", "Platinum", 192000, "CC90683");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5991-4421-8476-3804", "Gold", 19000, "CC14871");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1608-1970-3705-7137", "Premium", 667000, "CC98498");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7211-2168-9731-5466", "Gold", 9000, "CC89758");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9546-5205-4705-9447", "Premium", 463000, "CC94742");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8976-7958-2694-8171", "Premium", 817000, "CC88367");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7416-4529-6690-5703", "Gold", 12000, "CC60164");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7447-6644-5678-8061", "Platinum", 149000, "CC89690");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3652-5528-4808-8216", "Gold", 29000, "CC53373");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8850-8297-4094-3048", "Premium", 483000, "CC13359");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5145-7864-6575-8768", "Platinum", 100000, "CC56879");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9497-8994-1281-9719", "Platinum", 72000, "CC91963");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4354-1258-5178-5618", "Platinum", 85000, "CC64725");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8507-1459-7315-8148", "Gold", 9000, "CC31344");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8341-5263-4582-7396", "Platinum", 129000, "CC81000");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9304-4488-7872-2868", "Platinum", 165000, "CC40526");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3620-5235-2101-3391", "Platinum", 121000, "CC52744");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4806-6889-9908-7496", "Premium", 395000, "CC86051");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8467-5358-5569-3718", "Gold", 37000, "CC94597");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8685-1513-4751-8018", "Platinum", 183000, "CC14057");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7296-3224-2880-5747", "Gold", 36000, "CC28847");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6286-3397-5051-8445", "Premium", 507000, "CC27713");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9376-8684-9599-2988", "Premium", 235000, "CC56295");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8839-9467-3960-3997", "Gold", 50000, "CC85309");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8481-9097-2828-9363", "Gold", 32000, "CC29396");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4220-2591-3295-3300", "Premium", 411000, "CC70263");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5530-2431-5627-8837", "Gold", 30000, "CC86399");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6272-7021-2748-1471", "Gold", 39000, "CC61384");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4262-7103-6508-4214", "Gold", 47000, "CC50151");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5254-4916-6547-4795", "Platinum", 134000, "CC20509");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2240-2748-8514-4335", "Gold", 29000, "CC11671");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7212-8665-7734-5918", "Platinum", 55000, "CC43841");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3970-3872-2591-7629", "Platinum", 179000, "CC37463");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5805-3882-2982-9418", "Gold", 43000, "CC19293");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3671-4079-8067-8622", "Platinum", 161000, "CC41914");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5864-4475-3659-1440", "Gold", 2000, "CC99402");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9604-6821-2861-8084", "Gold", 26000, "CC16029");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5262-2954-4306-9001", "Platinum", 121000, "CC82406");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2077-2389-7798-4862", "Premium", 642000, "CC19277");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7326-9558-4788-5128", "Premium", 852000, "CC86189");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2158-2612-7934-6228", "Gold", 12000, "CC59641");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1655-7617-4318-5963", "Gold", 50000, "CC93075");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7729-4037-1361-9467", "Premium", 671000, "CC34817");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1336-9200-1264-2551", "Premium", 280000, "CC16420");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8951-3220-4809-9797", "Premium", 833000, "CC74145");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8711-5325-4752-4743", "Platinum", 196000, "CC78221");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2342-6589-6557-6739", "Premium", 740000, "CC53541");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4933-8895-6001-8577", "Gold", 20000, "CC80950");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6531-1690-4324-2760", "Premium", 575000, "CC85730");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8214-9590-3044-1216", "Premium", 835000, "CC60926");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8159-1257-4706-7544", "Premium", 410000, "CC34083");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9558-5469-2562-5608", "Premium", 596000, "CC30954");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8106-9789-1679-2552", "Premium", 325000, "CC84463");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2349-2290-6329-3624", "Premium", 835000, "CC18795");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6415-7043-2998-3377", "Premium", 296000, "CC99130");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9843-6858-7863-1891", "Platinum", 176000, "CC15310");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1519-5130-5810-8539", "Premium", 742000, "CC88046");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4138-5166-7490-1188", "Gold", 50000, "CC95099");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7767-7920-7733-4210", "Premium", 774000, "CC91963");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8231-5519-1948-3400", "Premium", 661000, "CC71365");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8673-7935-5776-9119", "Premium", 281000, "CC56752");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5982-5047-2653-9052", "Premium", 684000, "CC68522");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9162-3465-6654-4891", "Gold", 34000, "CC13173");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7815-2405-2962-6053", "Gold", 37000, "CC85400");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7047-9622-9693-9968", "Gold", 37000, "CC29028");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1159-7886-1385-5540", "Platinum", 163000, "CC13567");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4092-8604-7363-3393", "Premium", 782000, "CC25257");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2046-1892-2379-9050", "Premium", 313000, "CC15336");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7752-7762-8832-3142", "Platinum", 56000, "CC37643");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4203-1225-4528-2939", "Platinum", 150000, "CC14238");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4530-1687-6778-1250", "Gold", 20000, "CC67129");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4973-1293-1664-2086", "Gold", 23000, "CC36447");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6321-2048-7733-8765", "Premium", 129000, "CC81662");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6770-3803-2120-3012", "Premium", 613000, "CC27770");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4338-7681-3950-6850", "Premium", 589000, "CC53538");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4037-7862-8119-1361", "Premium", 867000, "CC84380");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1992-1719-3506-9652", "Platinum", 63000, "CC63063");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8769-1185-5731-6569", "Platinum", 80000, "CC14997");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4610-9984-7768-4610", "Premium", 712000, "CC84470");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6570-8163-4369-9734", "Gold", 26000, "CC50124");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7708-8807-7837-8812", "Platinum", 197000, "CC56647");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4661-5769-5059-2114", "Premium", 879000, "CC45677");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9302-6470-7735-6371", "Premium", 869000, "CC58963");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1683-2865-3396-4925", "Platinum", 63000, "CC84372");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4818-7275-3513-3939", "Premium", 108000, "CC11231");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4349-5976-1214-5524", "Premium", 695000, "CC38302");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6479-5593-2105-9060", "Premium", 445000, "CC18744");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5962-5634-2696-2739", "Platinum", 53000, "CC91171");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5960-5753-3689-8262", "Gold", 30000, "CC21935");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8115-7743-6213-9284", "Premium", 796000, "CC42687");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3708-8801-1521-8042", "Platinum", 170000, "CC51316");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6876-7378-4945-3251", "Gold", 44000, "CC46077");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1290-5480-3763-3387", "Gold", 8000, "CC68752");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8499-3007-6025-2772", "Premium", 501000, "CC32108");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9207-1270-6690-4905", "Gold", 2000, "CC65624");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6012-7799-2842-7221", "Premium", 721000, "CC61926");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3405-7202-8402-5988", "Premium", 181000, "CC34868");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3313-4024-5109-8235", "Gold", 39000, "CC78536");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9248-9032-8076-1225", "Gold", 25000, "CC83282");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2422-2354-4628-4556", "Gold", 49000, "CC35621");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8228-6661-8736-2838", "Premium", 802000, "CC24049");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3623-4506-7311-5151", "Gold", 48000, "CC21283");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1127-9633-2269-3119", "Gold", 46000, "CC97420");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8522-7783-9262-6673", "Gold", 17000, "CC29886");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6197-7150-9163-8287", "Gold", 24000, "CC69968");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2830-1922-3225-5423", "Premium", 554000, "CC41498");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9425-1481-6545-6190", "Premium", 145000, "CC84333");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7795-9930-1867-6279", "Platinum", 181000, "CC96446");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9304-8255-4381-2028", "Gold", 21000, "CC39362");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3158-1638-7701-9309", "Premium", 221000, "CC25645");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3525-9763-6876-7431", "Platinum", 164000, "CC65775");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6770-4547-6958-5035", "Platinum", 161000, "CC35596");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1629-9566-3285-2123", "Platinum", 194000, "CC24544");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6893-1438-6516-3207", "Premium", 315000, "CC13421");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3440-3330-5015-4988", "Premium", 549000, "CC28038");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6262-7793-5307-8561", "Premium", 542000, "CC90510");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8135-1903-7706-2260", "Premium", 307000, "CC52705");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6171-3568-7740-8072", "Premium", 325000, "CC35449");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8321-8463-7644-8934", "Premium", 790000, "CC78536");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5144-5591-4640-2208", "Premium", 657000, "CC17602");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8582-2422-3251-5767", "Premium", 567000, "CC59721");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9322-7578-8781-2684", "Platinum", 183000, "CC70711");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9314-8332-5195-8287", "Gold", 15000, "CC93412");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5574-7647-1844-5316", "Premium", 647000, "CC92850");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4971-8219-1133-6753", "Gold", 4000, "CC23687");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5811-4353-3490-5513", "Gold", 12000, "CC66648");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2357-9896-6403-5970", "Gold", 41000, "CC26081");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8578-3662-1951-5720", "Premium", 136000, "CC17651");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5592-8244-5701-5100", "Gold", 44000, "CC78221");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9391-7086-9113-4893", "Platinum", 181000, "CC99704");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9132-7052-6630-5540", "Gold", 30000, "CC70110");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4856-2191-9879-6388", "Gold", 11000, "CC38711");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7382-8932-9683-9480", "Premium", 635000, "CC57759");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8870-2780-7399-5151", "Platinum", 51000, "CC46922");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3007-2083-4197-9770", "Platinum", 130000, "CC87002");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4703-4800-3443-6825", "Premium", 121000, "CC11486");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2161-8530-5218-6803", "Gold", 28000, "CC29479");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9946-6939-3033-9593", "Platinum", 85000, "CC45937");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5018-8635-8433-6614", "Premium", 191000, "CC20490");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6765-2732-8888-1318", "Gold", 17000, "CC48782");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8462-5562-6993-2745", "Gold", 27000, "CC30640");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4954-2506-4917-1734", "Platinum", 176000, "CC20141");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1765-4019-5141-9230", "Platinum", 169000, "CC95833");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6045-2636-8278-8875", "Platinum", 88000, "CC42497");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7658-7645-4568-1461", "Gold", 16000, "CC17463");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5380-2273-3524-9795", "Premium", 484000, "CC62968");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2017-7197-7814-9950", "Platinum", 163000, "CC93684");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6085-9783-3284-2783", "Premium", 332000, "CC33694");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1556-5778-6667-4345", "Gold", 45000, "CC92905");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4491-2026-2441-2049", "Premium", 604000, "CC50476");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7633-7985-2079-2990", "Platinum", 196000, "CC42937");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5283-6135-5709-4452", "Premium", 773000, "CC75172");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3359-9828-1991-2013", "Premium", 435000, "CC95660");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6292-8171-2649-5336", "Platinum", 191000, "CC52309");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5556-4557-4566-1540", "Gold", 45000, "CC46484");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8614-1547-9524-8444", "Platinum", 119000, "CC95958");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4679-5406-6408-1233", "Gold", 50000, "CC65031");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6271-9924-3653-8913", "Gold", 3000, "CC62567");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2495-1344-4998-6045", "Platinum", 113000, "CC78778");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7299-3529-7767-1695", "Gold", 46000, "CC24173");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3439-5404-2739-7517", "Gold", 21000, "CC17528");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1782-8675-4061-3666", "Gold", 45000, "CC71198");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5349-1963-8417-8327", "Premium", 336000, "CC85592");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4679-8417-8700-1213", "Premium", 298000, "CC80464");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7697-2274-6431-6408", "Premium", 267000, "CC34035");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9999-3058-2698-4238", "Premium", 129000, "CC48724");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4959-5036-1379-1303", "Platinum", 135000, "CC19785");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1449-4529-1480-3546", "Premium", 621000, "CC95143");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1661-3809-5334-2155", "Gold", 39000, "CC61332");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7141-7294-3956-4408", "Gold", 12000, "CC85900");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6540-2862-2962-5109", "Premium", 126000, "CC78862");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3146-4961-6964-4229", "Premium", 719000, "CC43059");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4448-9587-7180-9589", "Premium", 379000, "CC31210");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2724-3903-7331-7820", "Platinum", 128000, "CC94754");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2649-6876-7496-4123", "Premium", 197000, "CC13320");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6815-5139-5546-1802", "Premium", 742000, "CC37292");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5590-1294-8800-2874", "Premium", 516000, "CC28205");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7430-6895-6227-4665", "Gold", 18000, "CC11154");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8177-5533-1183-4063", "Gold", 31000, "CC36475");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8918-6235-3308-7862", "Premium", 269000, "CC93261");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5341-5445-8369-7039", "Premium", 768000, "CC43699");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4246-1369-3659-8804", "Platinum", 105000, "CC21111");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5616-5526-4836-1962", "Gold", 42000, "CC38556");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6617-5782-1394-1632", "Gold", 5000, "CC74385");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2893-7786-7528-2338", "Gold", 46000, "CC95121");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8528-6154-7390-5081", "Premium", 686000, "CC90833");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7811-4511-7664-6960", "Gold", 26000, "CC73883");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8305-2272-4553-4911", "Premium", 777000, "CC82682");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2854-6117-5924-2770", "Platinum", 108000, "CC70113");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9369-6196-2597-1730", "Gold", 15000, "CC61652");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5274-7205-2377-3357", "Premium", 287000, "CC51714");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2911-7555-3093-9231", "Gold", 27000, "CC74712");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8869-7604-9618-3740", "Gold", 10000, "CC60553");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5533-2042-7236-9790", "Platinum", 148000, "CC71781");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4420-9925-9792-9113", "Platinum", 80000, "CC99132");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5936-1967-4966-6077", "Gold", 9000, "CC52681");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6750-4821-2334-9977", "Gold", 30000, "CC18336");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3925-8607-7303-7699", "Gold", 4000, "CC85979");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1909-6288-2284-5317", "Gold", 16000, "CC96619");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6148-9835-7115-4405", "Platinum", 180000, "CC66202");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2964-4590-9510-4405", "Premium", 218000, "CC57249");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5530-1215-6434-9691", "Gold", 34000, "CC92155");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1585-2708-4693-1454", "Premium", 131000, "CC26492");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3430-7717-8611-4878", "Premium", 260000, "CC37404");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7863-1291-5335-8126", "Gold", 49000, "CC52496");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6699-2639-4522-6219", "Gold", 34000, "CC85028");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4587-3535-8224-4301", "Premium", 858000, "CC17727");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6343-7134-9888-2361", "Premium", 405000, "CC31257");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4963-4850-8565-5494", "Premium", 209000, "CC30013");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5316-4617-7300-3260", "Gold", 49000, "CC17040");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8486-4186-7122-3452", "Gold", 20000, "CC36205");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6016-6956-6981-3103", "Platinum", 148000, "CC99306");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8518-4517-6409-6976", "Platinum", 138000, "CC19730");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3545-8540-7402-9523", "Gold", 45000, "CC24722");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6515-8771-7352-9788", "Gold", 41000, "CC15079");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3140-6494-9869-5893", "Premium", 567000, "CC17003");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2711-5438-4449-9824", "Premium", 625000, "CC39863");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9930-4634-8565-6716", "Premium", 492000, "CC41731");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3440-1978-8156-5313", "Premium", 749000, "CC78973");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7837-4036-5999-1672", "Gold", 24000, "CC21312");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1825-7669-6621-9045", "Premium", 126000, "CC26307");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3969-9181-6385-4422", "Gold", 2000, "CC71597");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3698-9867-4865-5497", "Platinum", 104000, "CC26192");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2116-6906-9722-9824", "Premium", 143000, "CC33423");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4562-2665-7578-1931", "Premium", 781000, "CC19186");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5481-9525-6488-7566", "Premium", 406000, "CC56172");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8262-8743-6406-7105", "Premium", 331000, "CC30400");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6785-6309-6247-3002", "Platinum", 160000, "CC50312");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8249-2687-5339-2078", "Platinum", 56000, "CC27190");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3295-6390-4452-7199", "Gold", 6000, "CC76008");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9386-8854-6115-4075", "Gold", 20000, "CC35402");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2264-2870-6785-2725", "Premium", 899000, "CC34812");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2834-5946-1542-4074", "Gold", 50000, "CC85673");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7334-1842-5941-2149", "Premium", 886000, "CC92316");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4093-1634-8086-4601", "Platinum", 188000, "CC72196");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3461-8685-2115-2963", "Platinum", 144000, "CC29656");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2992-8127-2278-9771", "Gold", 36000, "CC34207");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7276-7349-6334-3809", "Premium", 430000, "CC46637");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6001-5945-4665-4926", "Gold", 30000, "CC36387");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5778-9566-9086-7555", "Gold", 23000, "CC34752");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2219-4852-5937-6242", "Premium", 337000, "CC56840");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4144-3271-6301-9342", "Premium", 509000, "CC19740");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3170-4662-9297-6384", "Premium", 669000, "CC67668");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9721-7299-5635-3504", "Gold", 37000, "CC68259");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5251-7364-6702-5590", "Premium", 266000, "CC87270");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3573-2839-9869-7747", "Platinum", 167000, "CC42497");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7725-3576-5626-3317", "Gold", 19000, "CC40274");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8259-5688-7450-9931", "Premium", 682000, "CC87694");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3167-9604-1650-2605", "Platinum", 126000, "CC53812");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5674-3252-5805-3288", "Premium", 898000, "CC78942");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9517-7826-1862-6726", "Gold", 31000, "CC78843");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3323-8332-7133-7008", "Gold", 43000, "CC90178");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8836-7078-5752-6312", "Premium", 118000, "CC40274");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2463-9055-1240-3878", "Premium", 183000, "CC27404");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4427-5380-8182-9668", "Gold", 29000, "CC70138");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1546-9786-8388-4937", "Premium", 745000, "CC49168");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1817-8543-9660-4802", "Premium", 390000, "CC31597");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4334-6855-2003-9239", "Gold", 34000, "CC87102");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1947-8602-1695-7503", "Gold", 10000, "CC26034");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6319-3749-2944-6015", "Premium", 305000, "CC60322");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2370-4593-4826-2349", "Gold", 25000, "CC45414");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3467-3224-2464-5799", "Premium", 708000, "CC68517");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3697-6001-4909-5350", "Gold", 15000, "CC62261");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4937-6752-6970-3163", "Platinum", 79000, "CC76150");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3134-9713-5764-8285", "Premium", 405000, "CC49547");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7504-5906-9389-8905", "Premium", 617000, "CC31083");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3748-8048-5227-8162", "Gold", 32000, "CC67039");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3648-6856-2869-1255", "Gold", 33000, "CC74126");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6835-6133-8935-6988", "Gold", 35000, "CC91183");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2524-4184-5908-6750", "Platinum", 150000, "CC69171");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6258-3903-6637-5620", "Gold", 17000, "CC75243");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1536-9786-1960-7400", "Premium", 207000, "CC70382");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7966-2894-6066-2530", "Premium", 889000, "CC51058");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7306-7457-8875-3211", "Platinum", 150000, "CC26131");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9635-4234-8168-7095", "Premium", 257000, "CC68779");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6025-2610-4001-6680", "Platinum", 110000, "CC18139");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4646-8260-8197-7078", "Gold", 47000, "CC68821");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9873-6894-5872-1884", "Premium", 383000, "CC32108");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4770-7274-9917-1594", "Premium", 475000, "CC15895");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4294-8894-4829-7801", "Platinum", 102000, "CC65968");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1947-8327-3848-6581", "Platinum", 113000, "CC11690");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9018-5320-5729-5393", "Premium", 444000, "CC54582");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5580-3409-5276-9882", "Premium", 828000, "CC86871");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2949-1972-1300-6680", "Gold", 45000, "CC68567");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4991-3814-8016-9048", "Gold", 22000, "CC60931");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1716-8420-2111-4735", "Platinum", 75000, "CC42942");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2201-1387-2319-6874", "Platinum", 76000, "CC88026");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7726-3678-8092-6414", "Premium", 605000, "CC64007");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("1187-8674-2708-3972", "Platinum", 53000, "CC82145");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7815-5255-1963-9464", "Gold", 5000, "CC91171");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3196-5064-6247-7113", "Premium", 463000, "CC51619");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7234-6377-8525-5139", "Platinum", 141000, "CC63449");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5384-8278-5616-5502", "Premium", 361000, "CC83124");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5010-4875-7956-3628", "Premium", 241000, "CC65080");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9360-2827-9359-7064", "Platinum", 69000, "CC66974");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2056-7091-8023-1914", "Premium", 773000, "CC59183");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7662-3108-4951-8587", "Platinum", 177000, "CC26032");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3362-7342-4639-8164", "Premium", 170000, "CC65840");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8002-6041-9878-5658", "Platinum", 150000, "CC51984");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3114-9778-2542-3154", "Gold", 18000, "CC50434");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9779-2601-5260-2896", "Gold", 28000, "CC99952");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5002-6349-2806-2942", "Premium", 400000, "CC26267");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9542-6082-9630-9970", "Platinum", 159000, "CC66351");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7558-5459-8235-5737", "Premium", 740000, "CC93123");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("2595-7800-1142-5225", "Premium", 829000, "CC97721");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8078-7413-3861-2246", "Premium", 329000, "CC81464");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9753-7718-2196-1448", "Platinum", 142000, "CC97559");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5175-8965-9249-9021", "Premium", 669000, "CC86374");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9842-5558-3255-3410", "Premium", 462000, "CC40052");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3922-3698-6304-1975", "Premium", 786000, "CC43352");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6620-4005-4574-6263", "Gold", 27000, "CC95042");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5786-2204-6101-1373", "Platinum", 112000, "CC17112");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8031-9022-9952-9605", "Gold", 15000, "CC66002");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("3914-1379-8974-9157", "Platinum", 160000, "CC59638");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("7290-4771-9163-1291", "Gold", 28000, "CC77721");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("4708-4407-9601-6022", "Premium", 691000, "CC64993");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("6042-2856-7280-2925", "Gold", 33000, "CC26787");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("8706-3809-5167-3899", "Premium", 144000, "CC32532");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("9540-8558-5897-5046", "Premium", 830000, "CC90246");
insert into Card_base (card_number,card_family,credit_limit,cust_id) values ("5587-7265-8118-7718", "Gold", 24000, "CC37803");