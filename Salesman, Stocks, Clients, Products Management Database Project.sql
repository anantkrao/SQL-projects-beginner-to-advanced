/**************************************************************************************
 *Name : Warehouse Stocks, clients, Product Management Database Project.              *
 *Topic : All Oracle SQL beginner and intermediate topics are included.               *
 *Author : Anant kagdelwar.                                                           *
 *Level : For Beginner to intermediate.                                               *
 **************************************************************************************/

/*create table client_master*/

create table client_master(
clientno varchar2(6),
name varchar2(255) not null,
address1 varchar2(255),
address2 varchar2(255),
city varchar2(255),
pincode number(10),
state varchar2(255),
baldue number(10,2),
primary key(clientno));

/*create table product_master*/

create table product_master(
productno varchar2(6),
description varchar2(255) not null,
profitpercent number(4,2) not null,
unitmeasure varchar2(15) not null,
qtyonhand number(8) not null,
reorderlvl number(8) not null,
sellprice number(8,2) not null,
costprice number(8,2) not null,
primary key(productno));

/*create table salesman_master*/

create table salesman_master(
salesmanno varchar2(6),
salesman_name varchar2(255) not null,
address1 varchar2(255) not null,
address2 varchar2(255),
city varchar2(100),
pincode number(10),
state varchar2(100),
salAmt number(8,2) not null,
tgtTOget number(6,2) not null,
YTDsales number(6,2) not null,
remark varchar2(100),
primary key(salesmanno));

/*create table  salesorder*/

create table salesorder(
orderno varchar2(6),
clientno varchar2(6),
orderdate date not null,
delyadd varchar2(255),
salesmanno varchar2(6),
delytype char(1) default 'f',
billYN char(1),
delydate date,
orderstatus varchar2(100) check(orderstatus='in process' or orderstatus='fullfilled' or orderstatus='backorder' or orderstatus='cancelled'),
primary key(orderno),
foreign key(clientno) references client_master,
foreign key(salesmanno) references salesman_master,
constraint date_check check(delydate>=orderdate),
constraint delivery check(delytype='p' or delytype='f'));

/*create table sales_order_details*/

create table sales_order_details(
orderno varchar2(6),
productno varchar2(6),
qtyorder number(8),
qtydisp number(8),
productrate number(10,2),
foreign key(orderno) references salesorder,
foreign key(productno) references product_master
);
/************************************************************/
/************************************************************/
/*insert into client_master table*/
desc client_master;
insert into client_master values('C0001','Ivan bayross','A/12','worli','Mumbai',400054,'Maharashtra',15000);

insert all 
into client_master values('C0002','mamta mazumdar','D/2','chinop','Madras',780001,'Tamilnadu',0)
into client_master values('C0003','chhaya bankar','C/20','nariman','Mumbai',400057,'Maharashtra',5000)
into client_master values('C0004','ashwini joshi','FC/12','mg city','banglore',560801,'Karnataka',0)
into client_master values('C0005','hansel colaco','DA/3','dharavi','Mumbai',400060,'Maharashtra',2000)
into client_master values('C0006','deepak sharma','QD/22','maruti city','Manglore',560050,'Karnataka',0)
select *from client_master;
/*******************************************************/
/*insert into product_master table*/
desc product_master;

insert into product_master values('P00001','t-shirt',5,'pieces',200,50,350,25);
insert all
into product_master values('P00002','shirt',6,'pieces',150,50,500,350)
into product_master values('P00003','cotton jeans',5,'pieces',150,20,600,450)
into product_master values('P00004','jeans',2,'pieces',100,20,750,400)
into product_master values('P00005','trouser',4,'pieces',150,50,850,550)
into product_master values('P00006','pullovers',6,'pieces',80,30,700,350)
into product_master values('P00007','denim shirt',5,'pieces',150,40,300,350)
into product_master values('P00008','lycra top',4,'pieces',100,50,500,175)
into product_master values('P00009','skirt',5,'pieces',70,30,500,300)
select *from product_master;
/******************************/
/*insert into salesman_master table*/
insert into salesman_master values('S00001','aman','a/14','worli','mumbai',400002,'MH',3000,100,50,'good');
insert all  
into salesman_master values('S00002','omkar','65','nariman','mumbai',400001,'MH',3000,200,150,'good')
into salesman_master values('S00003','raj','d-7','bandra','mumbai',400032,'MH',3000,200,100,'good')
into salesman_master values('S00004','ashish','a/5','juhu','mumbai',400044,'MH',3500,200,150,'good')
select *from salesman_master;
/****************************************/
/*insert into salesorder table*/
desc salesorder;
insert into salesorder values('O19001','C0001',to_date('2004-06-12','yyyy-mm-dd'),null,'S00001','f','n',to_date('2004-07-20','yyyy-mm-dd'),'in process');
insert all
into salesorder values('O19002','C0002',to_date('2004-06-25','yyyy-mm-dd'),null,'S00002','p','n',to_date('2004-06-27','yyyy-mm-dd'),'cancelled')
into salesorder values('O46865','C0003',to_date('2004-02-18','yyyy-mm-dd'),null,'S00003','f','n',to_date('2004-02-20','yyyy-mm-dd'),'fullfilled')
into salesorder values('O19003','C0001',to_date('2004-04-03','yyyy-mm-dd'),null,'S00001','p','y',to_date('2004-04-07','yyyy-mm-dd'),'fullfilled')
into salesorder values('O46866','C0002',to_date('2004-05-20','yyyy-mm-dd'),null,'S00002','f','y',to_date('2004-05-22','yyyy-mm-dd'),'cancelled')
into salesorder values('O19008','C0003',to_date('2004-05-04','yyyy-mm-dd'),null,'S00003','p','n',to_date('2004-07-26','yyyy-mm-dd'),'in process')
select *from salesorder;
/**********************************/
/*insert into sales_order_details table*/
desc sales_order_details;
insert into sales_order_details values('O19001','P00001',4,4,525);
insert all
into sales_order_details values('O19002','P00002',2,3,8400)
into sales_order_details values('O46865','P00002',9,1,5250)
into sales_order_details values('O19003','P00004',3,4,525)
into sales_order_details values('O19002','P00001',2,2,3150)
into sales_order_details values('O19001','P00003',10,1,5250)
into sales_order_details values('O19008','P00003',4,3,525)
into sales_order_details values('O46866','P00004',4,1,1050)
into sales_order_details values('O46865','P00009',3,5,1050)
into sales_order_details values('O19001','P00008',10,1,12000)
into sales_order_details values('O19002','P00007',1,0,8400)
into sales_order_details values('O19008','P00007',10,2,1050)
into sales_order_details values('O19003','P00003',5,6,525)
into sales_order_details values('O46866','P00008',4,1,1050)
select *from sales_order_details;
/******************************/
/*Query 3 a : all names of client*/

select name as client_name from client_master;

/********************************/
/*Query 3 b : entire content of client master table*/

select *from client_master;

/********************************/
/*query 3 c : list of names city and state of all clients*/

select name as client_name,city,state from client_master;

/********************************/
/*Query 3 d : list prodcut from product master*/

select description as available_product 
from product_master
where qtyonhand > 0;

/********************************/
/*Query 3 e : list all the client who are located in mumbai*/

select name as mumbai_clients
from client_master
where city='Mumbai';

/********************************/
/*Query 3 f : find the names of salesman who have a salary equal to rs3000*/

select salesman_name,salamt as salary
from salesman_master
where salamt=3000;

/***********************/
/*Query 4 a : change city of client no c00005 to banglore*/

update client_master
set city='banglore' 
where clientno = 'C0005';

/*********************************/
/*Query 4 b : change the BalDue of ClientNo ï¿½C00001ï¿½ to rs1000.*/

select *from client_master;
update client_master
set baldue=1000
where clientno='C0001';

/*********************************/
/*Query 4 c : . change the cost price of Trousers to rs950.00.*/

select *from product_master;
update product_master
set costprice = 950
where description = 'trouser';

/*******************************/
/*Query 4 d : change the city of the Salesman to pune.*/

select *from salesman_master;
update salesman_master
set city = 'pune';

/*********************************/
/*Query 5 a : list the names of all client having ï¿½aï¿½ as the second letter in their names.*/

select name as client_name 
from client_master
where name like '_a%';

/*Query 5 b :  list the client who stay in a city whose first letter is ï¿½Mï¿½.*/

select name as client_name, city as client_city
from client_master
where city like 'M%';

/*Query 5 c : list all client who stay in ï¿½bangloreï¿½ or ï¿½mangloreï¿½.*/

select name as client_name ,city
from client_master
where city='banglore' or city='Manglore';

/*Query 5 d :  list all client whose BalDue is greater than value 10000.*/

select 
name as client_name,
baldue,
case
when baldue>10000 then 'high balance'
else '  smaller than 10000'
end as balance_status
from client_master;

/*Query 5 e :  list all the information from the sales_order table for order placed in the month of june.*/

select *from
salesorder
where extract(month from orderdate)=6;

/*Query 5 f : list all the information for ClientNo ï¿½C00001ï¿½ and ï¿½C00002ï¿½.*/
/*set operation*/

select 
*from client_master
where clientno in('C0001','C0002');

/*Query 5 g : list product whose selling price is greater than 500 and less than equal to 750*/

select *from product_master;
select description as product,sellprice as selling_price
from product_master
where sellprice > 500 and sellprice < 750;

/*Query 5 h : list product whose selling price is more than 500. Calculate new selling price as, original 
selling *(.15).
Rename the new column in the output of the above Queryry as new price.*/

select description as product, sellprice * .15 as new_price
from product_master
where sellprice > 500;

/*Query 5 i : list the name, city, stste of clients who are not in the state of ï¿½Maharastraï¿½.*/

select name as client_name,city,state 
from client_master 
where state != 'Maharashtra';

/*Query 5 j : count the total number of orders.*/

select *from sales_order_details;
select count(*) as total_order_count
from salesorder;

/*Query 5 k : calaulate the average price of all product.*/

select cast(avg(sellprice) as decimal(10,2))as average_sellprice,cast(avg(costprice) as decimal(10,2) )as average_costprice 
from product_master;

/*Query 5 l : determine the maximum and minimum product price. Rename the output as max_price and 
min_price respectively.*/

select max(sellprice) as maximum_selling_price,
max(costprice) as maximum_cost_price,
min(sellprice) as minimum_selling_price,
min(costprice) as minimum_cost_price
from product_master;

/*Query 5 m : count the number of product having price less than or equal to 500.*/

select count(productno) as total_product_under_500
from product_master
where sellprice <= 500 and costprice <= 500;

/*Query 5 n :  list all the product whose QTYONHAND is less than reorder level.*/

select description as product,
case
when qtyonhand < reorderlvl then 'product available'
else 'product not available'
end as compariosn_status
from product_master;

/**********************************/
/*Query 6 a :list the order number and day on whichnclients placed their order*/

SELECT orderno, to_char(orderdate, 'day') AS OrderDay
from salesorder;

/*Query 6 b :  list the month (in alphabets) and date when the order must be delivered.*/

select 
orderno,
to_char(delydate,'month') as delivery_month,
to_date(delydate,'yyyy-mm-dd') as delivery_date
from salesorder;

/*Query 6 c : list the OrderDate in the formate ‘DD-MONTH-YY’. Eg 12-feb-02.*/

select orderno,to_date(orderdate,'dd-mm-yy') as order_date
from salesorder;

/*Query 6 d : list the date, 15 days after today’s date.*/

select sysdate as current_date, sysdate + 15 as date_15_days_later
from dual;

/*Query 7 a :print the description and total qty sold for each product. */

select pm.description as product ,
sum(distinct sod.qtydisp) as sold_quantity 
from product_master pm natural join sales_order_details sod
group by description;

/*Query 7 b : */

