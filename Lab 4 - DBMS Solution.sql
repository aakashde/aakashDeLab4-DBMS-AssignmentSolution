/*creating database*/
Create Database if not exists `order-directory` ;
use `order-directory`;

/*Problem 1*/
/*creating supplier table*/
create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)
);

/*creating customer table*/
CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));
 
/*creating category table*/
CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (`CAT_ID`)
  );


/*creating product table*/
  CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)
  
  );

/*creating product_details table*/
 CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
  
  );


/*creating orders table*/
CREATE TABLE IF NOT EXISTS `orders` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );





/*creating rating table*/ 
CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  );

/*Problem 2*/
/*insertion on supplier table*/
insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');


/*insertion on customer table*/  
INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');


/*insertion on category table*/ 
INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");
 
 
/*insertion on product tabel*/
INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);
 
  
 /*insertion on product_details table*/ 
INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);
  

/*insertion on orders table*/  
INSERT INTO `ORDERS` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDERS` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDERS` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDERS` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDERS` VALUES(30,3500,"2021-08-16",4,3);

/*insertion on ratings table*/  
INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);

/*Problem 3*/
/*Display the number of the customer group by their genders who have placed any order
of amount greater than or equal to Rs.3000*/
select customer.cus_gender, count(customer.cus_id) as customer_count from customer right join orders on customer.cus_id = orders.cus_id where orders.ord_amount >= 3000 group by customer.cus_gender ;

/*Problem 4*/
/*Display all the orders along with the product name ordered by a customer having
Customer_Id=2*/
select product.pro_name, orders.* from orders
	right join PRODUCT_DETAILS on orders.prod_id = PRODUCT_DETAILS.prod_id 
    right join product on PRODUCT_DETAILS.pro_id = product.pro_id
    right join customer on orders.cus_id = customer.cus_id where orders.cus_id = 2;

/*Problem 5*/
/*Display the Supplier details who can supply more than one product*/    
select * from supplier 
	right join product_details on supplier.supp_id = product_details.supp_id having count(product_details.supp_id) >1 ; 

/*Problem 6*/
/*Find the category of the product whose order amount is minimum*/    
select c.cat_name from category c 
    join product p on c.cat_id = p.cat_id
    join product_details pd on pd.pro_id = p.pro_id
    join orders o on o.prod_id = pd.prod_id
    order by o.ord_amount asc limit 1; 

/*Problem 7*/
/*Display the Id and Name of the Product ordered after “2021-10-05”*/
 select p.pro_id, p.pro_name from orders o
	join product_details pd on o.prod_id = pd.prod_id
    join product p on pd.pro_id = p.pro_id
    where o.ord_date > '2021-10-05' ;
 
/*Problem 8*/
/*Print the top 3 supplier name and id and their rating on the basis of their rating along
with the customer name who has given the rating*/  
select  s.supp_id, s.supp_name, r.rat_ratstars, c.cus_name from rating r
	join customer c on r.cus_id = c.cus_id
    join supplier s on r.supp_id = s.supp_id 
    order by r.rat_ratstars desc limit 3;

/*Problem 9*/
/*Display customer name and gender whose names start or end with character 'A'*/
select cus_name, cus_gender from customer where cus_name like '%A' or cus_name like 'A%' ;

/*Problem 10*/
/*Display the total order amount of the male customers*/
select sum(o.ord_amount) Total_ord_amount, c.cus_gender from customer c
	join orders o on o.cus_id = c.cus_id 
    where c.cus_gender = 'm' ;

/*Problem 11*/
/*Display all the Customers left outer join with the orders.*/
select * from customer c 
	left outer join orders o on o.cus_id = c.cus_id ;

/*Problem 12*/
/*Create a stored procedure to display the Rating for a Supplier if any along with the
Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average
Supplier” else “Supplier should not be considered*/ 
DELIMITER //
create procedure supp_rating()
begin
	select s.supp_id, s.supp_name, r.rat_ratstars, verdict(r.rat_ratstars) from supplier s
		join rating  r on s.supp_id = r.supp_id ;
end //
DELIMITER ;
DELIMITER //
	create function verdict(rating int)
returns varchar(40)
DETERMINISTIC
begin
	declare comment varchar(40);
	if rating >4 then 
		set comment = 'Genuine Supplier';
	elseif rating >2 then
		set comment = 'Average';
	else
		set comment = 'Supplier should not be considered' ; 
	end if;
	return comment ;
end ; //
DELIMITER ;
call supp_rating () 
