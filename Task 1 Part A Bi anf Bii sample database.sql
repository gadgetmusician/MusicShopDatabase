--Create a database with sample data for MME 

Drop table if exists Transaction CASCADE;

Drop table if exists Stock CASCADE;

Drop table if exists Product CASCADE;

Drop table if exists Product_Type CASCADE;

Drop table if exists Site CASCADE;

Drop table if exists site_Group CASCADE;

Drop table if exists Customer CASCADE;

--Set lc_monetary to "en_gb.UTF8";

Create table Customer
(c_id SERIAL PRIMARY KEY,
c_fname VARCHAR(255) NOT NULL,
c_mname VARCHAR(255) ,
c_sname VARCHAR(255) NOT NULL,
C_address1 VARCHAR(50) NOT NULL,
C_address2 VARCHAR(50) ,
C_address3 VARCHAR(50) NOT NULL,
c_pcode VARCHAR (8) NOT NULL,
c_telnumber VARCHAR(20),
c_dob DATE ,
C_anumber VARCHAR(8) NOT NULL,
c_bscode VARCHAR(6) NOT NULL,
c_bname VARCHAR(255) NOT NULL,
c_baddress1 VARCHAR(255) NOT NULL,
c_baddress2 VARCHAR(255) ,
c_baddress3 VARCHAR(255) NOT NULL,
c_bpcode VARCHAR(8) NOT NULL);



Create table Site_Group
(site_GROUP_ID NUMERIC NOT NULL PRIMARY KEY,
site_group_name CHAR(3) NOT NULL);


Create table Site
(Site_id NUMERIC NOT NULL PRIMARY KEY,
Site_name VARCHAR(255) NOT NULL,
Site_address1 VARCHAR(50) NOT NULL,
Site_address2 VARCHAR (50) ,
Site_address3 VARCHAR(50) NOT NULL,
site_pcode VARCHAR(8) NOT NULL,
site_telnumber VARCHAR(11) NOT NULL,
site_group_id NUMERIC REFERENCES site_group(site_group_id));


Create table Product_Type
(Product_Type_id NUMERIC NOT NULL PRIMARY KEY,
product_type_name VARCHAR (255) NOT NULL);


Create table Product
(Product_id NUMERIC NOT NULL PRIMARY KEY,
product_name VARCHAR (1000) NOT NULL,
Product_Type_id NUMERIC NOT NULL REFERENCES product_type(product_type_id),
product_description VARCHAR (5000) NOT NULL,
product_cost Money);


Create table Stock
(site_id Numeric NOT NULL REFERENCES site(site_id),
product_id NUMERIC NOT NULL REFERENCES product(product_id),
Primary key (site_id, product_id),
stock_quantity INTEGER NOT NULL);

Create table Transaction
(transaction_id SERIAL	NOT NULL PRIMARY KEY,
c_id INTEGER REFERENCES customer(c_id),
supply_site_id NUMERIC NOT NULL REFERENCES site(site_id),
product_id NUMERIC NOT NULL	REFERENCES product(product_id),
transaction_quantity INTEGER NOT NULL,
transaction_cost money,
transaction_paymentmethod CHAR (1), 
sale_site_id NUMERIC REFERENCES site(site_id) not null,
transaction_type CHAR (1) NOT NULL,
delivery_date date, 
deliveryslot_request VARCHAR (2),
transaction_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP);


ALTER TABLE TRANSACTION
 ADD CONSTRAINT check_method CHECK (transaction_paymentmethod = 'S' OR transaction_paymentmethod = 'D' OR transaction_paymentmethod = 'C' OR transaction_paymentmethod is NULL);
 

ALTER TABLE TRANSACTION
 ADD CONSTRAINT check_type CHECK (transaction_type = 'S' OR transaction_type = 'T' OR transaction_type = 'D');


ALTER TABLE TRANSACTION
ADD CONSTRAINT check_request CHECK (deliveryslot_request = 'AM' or deliveryslot_request = 'PM' OR deliveryslot_request is NULL);
 


INSERT into Customer
Values (DEFAULT, 'Able', 'Malcom', 'Smith', '1 Main Street', 'Pennycomequick', 'Rutland', 'LE212NG', '01216753887', TO_DATE('1987-06-23', 'YYYY-MM-DD'), '22324252', '524232', 'Natwest', '1 Front Street', NULL, 'Greater London', 'E1A 1AA');

INSERT into Customer
Values (DEFAULT, 'Cain', 'Mal', 'Smyth', '1 Fore Street', 'Crownhill', 'Bristol', 'BR33SG', '+1312903339382', TO_DATE('1947-02-28', 'YYYY-MM-DD'), '31415161', '203040', 'Barclays', '32 Collingwood Street', 'Durham', 'County Durham', 'DR1 1WE');

INSERT into Customer
Values (DEFAULT, 'Esther', NULL ,'Davies', '34 Dean Street', NULL ,'Winchester', 'HA33SG', NULL, NULL , '87654321', '203040', 'Barclays', '32 Collingwood Street', 'Durham', 'County Durham', 'DR1 1WE');

INSERT into Customer
Values (DEFAULT, 'Beagle', 'Mel', 'Radical', 'Flat 1 The Castle', 'Bishop Auckland', 'County Durham', 'DR3 4RD', '01915468546', TO_DATE('2000-04-12', 'YYYY-MM-DD'), '55664487', '343536', 'Natwest', '1 Pilgrim Street', 'Newcastle', 'Tyne and Wear', 'NE1 2DR');


Insert into Site_Group
Values (3000, 'WAR');

Insert into Site_Group
Values (3001, 'LDN');

Insert into Site_Group
Values (3002, 'YOR');

Insert into Site_Group
Values (3003, 'SWE');

Insert into Site
Values (2000, 'MME Warehouse', 'Leeds Bradford Airport Business Park', 'Leeds', 'West Yorkshire', 'LS10 3AR', '01134567894', '3000');

Insert into Site
Values (2001, 'Bank', '2 Old Street', 'London', 'City of London', 'W2A 2AX', '02087929383', '3001');

Insert into Site
Values (2002, 'Leeds Main', '3 River Road', 'Leeds', 'West Yorkshire', 'LS1 1WE', '01132451324', '3002');

Insert into Site
Values (2003, 'Leeds Second', '45 Church Street', 'Leeds', 'West Yorkshire', 'LS3 3RT', '01133455685', '3002');

Insert into Site
Values (2004, 'Bristol', '34 Cathedral Green', NULL, 'Bristol', 'BR1 2RT', '01173454775', '3003');


Insert into Product_Type
VALUES (4001, 'Instrument');

Insert into Product_Type
VALUES (4002, 'Sheet Music');

Insert into Product_Type
VALUES (4003, 'CD');

Insert into Product_Type
VALUES (4004, 'Book');

Insert into Product
VALUES (5001, 'Student clarinet', '4001', 'A plastic student instrument with basic tone and functional keys', '250.00');

Insert into Product
VALUES (5002, 'Violin', '4001', 'An exceptional instrument of the highest quality and craftsmanship. Made of the finest old Italian tone woods and based through generations of the finest players, this rare to market violin is only worthy of the most elite players', '15000000.00');

Insert into Product
VALUES (5003, 'ABRSM Grade 2 Piano', '4002', 'ABRSM Grade 2 Piano - with CD. A wide selection of exam pieces, it also contains the scale requiremnts for the grade', '10.00');

Insert into Product
VALUES (5004, 'A Tune a Day - Oboe', '4002', 'This ever popular series of book provides a rich variety of tunes for the initial learner to play and enjoy. It also includes an instrutional DVD and CD of backing tracks', '6.50');

Insert into Product
VALUES (5005, 'Handel''s Messiah', '4003', 'This essential recording by London Symphony Chorus conducted by Colin Davis is a must have for any connoisseur', '20.00');

Insert into Product
VALUES (5006, 'Kind of Blue', '4003', 'This essential recording by Miles Davis at his most inventive - a giant recording in the Jazz canon', '20.00');

Insert into Product
VALUES (5007, 'How we did it - the rise and fall of NME', '4004', 'This biograhy of a magazine interviews with the pioneering music jounalists that brought this iconic magazine to print time after time', '15.00');

INSERT into Stock
Values (2000, 5001, '0');

INSERT into Stock
Values (2000, 5002, '0');

INSERT into Stock
Values (2000, 5003, '0');

INSERT into Stock
Values (2000, 5004, '0');

INSERT into Stock
Values (2000, 5005, '0');

INSERT into Stock
Values (2000, 5006, '0');

INSERT into Stock
Values (2000, 5007, '0');

INSERT into Stock
Values (2001, 5001, '100');

INSERT into Stock
Values (2001, 5002, '1');

INSERT into Stock
Values (2001, 5003, '100');

INSERT into Stock
Values (2001, 5004, '100');

INSERT into Stock
Values (2001, 5005, '100');

INSERT into Stock
Values (2001, 5006, '100');

INSERT into Stock
Values (2001, 5007, '100');

INSERT into Stock
Values (2002, 5001, '10');

INSERT into Stock
Values (2002, 5002, '0');

INSERT into Stock
Values (2002, 5003, '50');

INSERT into Stock
Values (2002, 5004, '0');

INSERT into Stock
Values (2002, 5005, '0');

INSERT into Stock
Values (2002, 5006, '0');

INSERT into Stock
Values (2002, 5007, '0');

INSERT into Stock
Values (2003, 5001, '100');

INSERT into Stock
Values (2003, 5002, '0');

INSERT into Stock
Values (2003, 5003, '10');

INSERT into Stock
Values (2003, 5004, '0');

INSERT into Stock
Values (2003, 5005, '5');

INSERT into Stock
Values (2003, 5006, '0');

INSERT into Stock
Values (2003, 5007, '0');

INSERT into Stock
Values (2004, 5001, '100');

INSERT into Stock
Values (2004, 5002, '0');

INSERT into Stock
Values (2004, 5003, '10');

INSERT into Stock
Values (2004, 5004, '0');

INSERT into Stock
Values (2004, 5005, '0');

INSERT into Stock
Values (2004, 5006, '100');

INSERT into Stock
Values (2004, 5007, '100');



INSERT into Transaction
Values (DEFAULT, 1, 2001, 5001, '2', '250.00', 'S', 2002, 'S', NULL);

INSERT into Transaction
Values (DEFAULT, 1, 2003, 5001, '2', '250.00', 'S', 2001, 'S', NULL);

INSERT into Transaction
Values (DEFAULT, 1, 2002, 5002, '1', '14900000', 'S', 2002, 'S', NULL);

INSERT into Transaction
Values (DEFAULT, 2, 2003, 5003, '1', '10.00', 'D', 2001, 'D', to_date('2021-10-31', 'YYYY-MM-DD'),'AM');

CREATE or REPLACE PROCEDURE print_product_listing_via_name (p_name Product.product_name%Type)
		Language 'plpgsql'
AS $$


DECLARE
	p_name product.product_name%type;
	p_type product.product_type_id%type;
	p_description product.product_description%type;
	p_cost product.product_cost%type;
BEGIN
	Select product_name, product_type_id, product_description, product_cost
	into STRICT p_name, p_type, p_description, p_cost
	From Product
	Where UPPER(product_name) = UPPER(p_name);
	Raise notice '%', p_name ||'-'|| p_type ||'-'|| p_description ||'-'|| p_cost;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE WARNING 'No product found';
END
$$
;

--TEST for exception
CALL print_product_listing_via_name (cast('A Tune a Day - Violin' as VARCHAR));


-- end of Task 1 section A


-- Task 1 section b)i Create stored procedure for adding a new customer
DROP PROCEDURE IF exists create_customer;

 CREATE or REPLACE PROCEDURE create_customer
( customer_fname customer.c_fname%TYPE,
customer_sname customer.c_sname%TYPE, 
customer_add1 customer.c_address1%TYPE,
customer_add3 customer.c_address3%type,
customer_pcode customer.c_pcode%TYPE,
customer_anumber customer.c_anumber%TYPE,
customer_bankscode customer.c_bscode%TYPE,
customer_bankname customer.c_bname%TYPE,
customer_bankadd1 customer.c_baddress1%TYPE,
customer_bankadd3 customer.c_baddress3%TYPE,
customer_bankpcode customer.c_bpcode%TYPE,
customer_mname customer.c_mname%TYPE DEFAULT NULL,
customer_add2 customer.c_address2%TYPE DEFAULT NULL,
customer_telephonenumber customer.c_telnumber%TYPE DEFAULT NULL,
customer_dateofbirth customer.c_dob%type DEFAULT NULL,
customer_bankadd2 customer.c_baddress2%TYPE DEFAULT NULL
)
LANGUAGE 'plpgsql'
AS
$$
BEGIN
--Validate that the customer's forename is not in excess of 255 characters
	IF length(customer_fname) > 255 then
		RAISE warning 'The given name entered contains too many characters';
-- Validate that the customer's forename is present on each record'
	ELSIF customer_fname is NULL THEN
		RAISE WARNING 'A given name must be present';
-- Validate that the customer's family name is not in excess of 255 characters
	ELSIF length(customer_sname) > 255 THEN
		RAISE warning 'The family name entered contains too many characters';
-- Validate that the customer's family name is present on each record
	ELSIF customer_sname is NULL THEN
		RAISE WARNING 'A family name must be present';
--Validate that the customer's first line of address is not in excess of 50 characters
	ELSIF length(customer_add1) > 50 then
		RAISE warning 'The first line of the address contains too many characters';
--Validate that the customer's first line of address in present on the record
	ELSIF customer_add1 is NULL THEN
		RAISE warning 'The first line of the address must be present';
--Validate that the customer's third line of address is not is excess on 50 characters
	ELSIF Length(customer_add3) > 50 then
		RAISE warning 'The third line of the address contains too many characters';
-- Validate that the customer's third line of address is present on the record
	ELSIF customer_add3 is NULL THEN
		RAISE warning 'The third line of the address must be present';
--Validate that the customer's postcode is not in excess on 8 characters
	ELSIF Length(customer_pcode) > 8 then
		RAISE warning 'The postcode contains too many characters';
--Validate that the customer's postcode is presnet on the record 
	ELSIF customer_pcode is NULL THEN
		RAISE warning 'The postcode for the address must be present';
--Validate the length on the customers account number is not in excess on 8 charaters
	ELSIF Length(customer_anumber) > 8 then
		RAISE warning 'The correct amount of characters has not been used';
--Validate that the customer's account number is present
	ELSIF customer_anumber is NULL THEN
		RAISE warning 'Please provide your account number';
--Validate that the customer's bank sort code is not in excess of 6 characters
	ELSIF Length(customer_bankscode) > 6 then
		RAISE warning 'The correct amount of characters has not been used';
--Validate that the customer's bank sort code is present on the record
	ELSIF customer_bankscode is NULL THEN
		RAISE warning 'Please provide your bank''s sort code';
--Validate that the customer's bank name is not in excess of 255 characters
	ELSIF Length(customer_bankname) > 255 then
		RAISE warning 'The name entered contains too many characters';
--Validate that the customer's bank is provided 
	ELSIF customer_bankname is NULL THEN
		RAISE WARNING 'A bank name must be present';
--Validate that the customer's bank first line of address is not in excess on 50 characters
	ELSIF Length(customer_bankadd1)  > 50 then
		RAISE Warning 'The first line of the address contains too many characters';
--Validate that the customer's bank first line of address is present
	ELSIF customer_bankadd1 is NULL THEN
		RAISE Warning 'The first line of the address must be present';
--Validate that the customer's bank third line of adddress is not in excess of 50 characters
	ELSIF Length(customer_bankadd3)  > 50 then
		RAISE warning 'The third line of the address contains too many characters';
--Validate that the customer's bank third line of address is provided
	ELSIF customer_bankadd3 is NULL THEN
		RAISE warning 'The third line of the address must be present';
--Validate that the customer's bank postcode in not in excess of 8 characters
	ELSIF Length(customer_bankpcode) > 8 then
		RAISE warning 'The bank postcode contains too many characters';
--Validate that the customer's bank is provided
	ELSIF customer_bankpcode is NULL THEN
		RAISE warning 'The postcode for the address must be present';
--Validate that the customer's middle name(s) are not in excess of 255 characters, if provided
	ELSIF length(customer_mname) > 255 THEN
		RAISE warning 'The name used contains too many characters';
--Validate that the customer's second line of address is not in excess of 50 characters, if provided
	ELSIF length(customer_add2) > 50 THEN
		RAISE warning 'The second line of the address contains too many characters';
--Validate that the customer's bank second line of address does not exceed 50 characters, if provided
	ELSIF length(customer_bankadd2) > 50 THEN
		RAISE warning 'The second line of the address contains too many characters';
-- Validate that the customers telephone does not exceed 20 characters, if provided
	ELSIF length(customer_telephonenumber) > 20 THEN
		RAISE warning 'The number contains too many characters';
	ELSE
	
	INSERT into Customer 
	VALUES (DEFAULT, 
			customer_fname, 
			customer_mname, 
			customer_sname, 
			customer_add1, 
			customer_add2, 
			customer_add3,
			customer_pcode,
			customer_telephonenumber,
			customer_dateofbirth,
			customer_anumber, 
			customer_bankscode, 
			customer_bankname, 
			customer_bankadd1, 
			customer_bankadd2, 
			customer_bankadd3, 
			customer_bankpcode);
	END IF;
END
$$
;


							
--All Attributes with values
 Call create_customer
(cast ('ABE' as VARCHAR),
cast ('Smith' as VARCHAR),
cast ('1 Main Street' as VARCHAR),
cast ('Rutland' as VARCHAR),
cast ('LE212NG' as VARCHAR),
cast( 22324252 as VARCHAR), 
cast( 524232 as VARCHAR),
cast ('NATWEST' as VARCHAR),
cast('1 Front Street' as VARCHAR),
cast('Greater London' as VARCHAR),
cast('E1A 1AA' as VARCHAR),
customer_mname => cast('BESS' as VARCHAR),
customer_add2=> cast ('Rutland' as VARCHAR),
customer_telephonenumber => cast ('01211234567' as VARCHAR),
customer_dateofbirth => (TO_DATE('1988-06-23', 'YYYY-MM-DD')),
customer_bankadd2 => cast ('Putney' as VARCHAR)
);

-- all null accounted for

 Call create_customer
 (cast ('ABE' as VARCHAR),
 cast ('Smith' as VARCHAR),
 cast ('1 Main Street' as VARCHAR),
 cast ('Rutland' as VARCHAR),
 cast ('LE212NG' as VARCHAR),
 cast( 22324252 as VARCHAR), 
 cast( 524232 as VARCHAR),
 cast ('NATWEST' as VARCHAR),
 cast('1 Front Street' as VARCHAR),
 cast('Greater London' as VARCHAR),
 cast('E1A 1AA' as VARCHAR)
 );
 
 -- dob added all other nulls allowed
 Call create_customer
 ( cast ('Bee' as VARCHAR),
 cast ('Smith' as VARCHAR),
 cast ('1 Main Street' as VARCHAR),
 cast ('Rutland' as VARCHAR),
 cast ('LE212NG' as VARCHAR),
 cast(22324252 as VARCHAR), 
 cast( 524232 as VARCHAR),
 cast ('NATWEST' as VARCHAR),
 cast('1 Front Street' as VARCHAR),
 cast('Greater London' as VARCHAR),
 cast('E1A 1AA' as VARCHAR),
 customer_dateofbirth => (TO_DATE('1988-06-23', 'YYYY-MM-DD'))
 );


-- mname no other nulls
Call create_customer
(Cast('dee' as VARCHAR),
Cast('smith' as VARCHAR),
Cast('2 Main Street' as VARCHAR),
Cast ('Soundland' as VARCHAR),
Cast('le21 2ng' as VARCHAR),
Cast('22324255' as VARCHAR),
Cast('524235' as VARCHAR),
Cast('natwest' as VARCHAR),
Cast('1 Front Street' as VARCHAR),
Cast('Greater London' as VARCHAR),
Cast('e1a 1aa' as VARCHAR),
Customer_mname => cast('Cee' as VARCHAR)
);

--add2 no other nulls
Call create_customer
(Cast('fee' as VARCHAR),
Cast('smith' as VARCHAR),
Cast('1 Main Street' as VARCHAR),
Cast ('Rutland' as VARCHAR),
Cast('le21 2ng' as VARCHAR),
Cast('22324252' as VARCHAR),
Cast('524232' as VARCHAR),
Cast('natwest' as VARCHAR),
Cast('1 Front Street' as VARCHAR),
Cast('Greater London' as VARCHAR),
Cast('e1a 1aa' as VARCHAR),
Customer_add2 => cast('The Crescent' as VARCHAR)
);

--telephone number no other nulls
Call create_customer
(Cast('hee' as VARCHAR),
Cast('smith' as VARCHAR),
Cast('1 Main Street' as VARCHAR),
Cast ('Rutland' as VARCHAR),
Cast('le21 2ng' as VARCHAR),
Cast('22324252' as VARCHAR),
Cast(524232 as VARCHAR),
Cast('natwest' as VARCHAR),
Cast('1 Front Street' as VARCHAR),
Cast ('Greater London' as VARCHAR),
Cast('e1a 1aa' as VARCHAR),
Customer_telephonenumber => cast('01213456789' as VARCHAR)
);

-- bankadd2 no other nulls

Call create_customer
(Cast('jee' as VARCHAR),
Cast('smith' as VARCHAR),
Cast('1 Main Street' as VARCHAR),
Cast ('Rutland' as VARCHAR),
Cast('le21 2ng' as VARCHAR),
Cast('22324252' as VARCHAR),
Cast('524232' as VARCHAR),
Cast('natwest' as VARCHAR),
Cast('1 Front Street' as VARCHAR),
Cast('Greater London' as VARCHAR),
Cast('e1a 1aa' as VARCHAR),
Customer_bankadd2 => cast('The Crescent' as VARCHAR)
);
 

--select * from customer


/* select * from customer */

-- Sample error call
--too many characters in customer postcode
Call create_customer
(
Cast('jee' as VARCHAR),
Cast('smith' as VARCHAR),
Cast('1 Main Street' as VARCHAR),
Cast ('Rutland' as VARCHAR),
Cast('le21322ng' as VARCHAR),
Cast('22324252' as VARCHAR),
Cast('524232' as VARCHAR),
Cast('natwest' as VARCHAR),
Cast('1 Front Street' as VARCHAR),
Cast('Greater London' as VARCHAR),
Cast('e1a 1aa' as VARCHAR),
Customer_bankadd2 => cast('The Crescent' as VARCHAR)
);


-- end of Task 1 section B)i

--b)ii Stored procedure for adding a transaction
DROP PROCEDURE IF EXISTS add_transaction;

CREATE OR REPLACE PROCEDURE add_transaction 
(
add_customerid transaction.c_id%type,
add_supplysiteid transaction.supply_site_id%type,
add_productid transaction.product_id%type,
add_transactionquantity transaction.transaction_quantity%type,
add_transactioncost transaction.transaction_cost%type,
add_transactionpaymentmethod transaction.transaction_paymentmethod%type,
add_salesiteid transaction.sale_site_id%type,
add_transactiontype transaction.transaction_type%type,
add_deliverydate transaction.delivery_date%type,
add_deliveryslotrequest transaction.deliveryslot_request%type
)
LANGUAGE 'plpgsql'
AS $$

BEGIN
/* first validate the parameters according to the transaction types */
--transfers do not require a customer sales and deliveries do.
	IF add_transactiontype <> 'T' and not exists (select 1 from customer c where c.c_id = add_customerid)
	THEN
		RAISE WARNING 'No Customer found for id %', add_customerid;
	ELSIF add_transactiontype = 'T' and add_customerid is not NULL
	THEN 
		RAISE WARNING 'Customer not required on stock transfer'; 
-- product id must always be specified
ELSIF not exists (select 1 from product p where p.product_id = add_productid)
	THEN
		RAISE WARNING 'No product found for the product id %', add_productid;
--sale_site_id must always be specified 
	ELSIF add_salesiteid is NULL
	THEN
		RAISE WARNING 'Sale site must be specified';
--supply site-id must always be specified 
	ELSIF add_supplysiteid is NULL
	THEN
		RAISE WARNING 'Supply site must be specified';
--validation that product exists on supply site for stock table 

ELSIF not exists (select 1 from stock s where s.product_id = add_productid AND s.site_id = add_supplysiteid)
	THEN
RAISE WARNING 'No stock record found for the product % and site %'  , product_id , supplysiteid;

--validation for transfer that product exists on sale site
--So I can receive the transferred stock
ELSIF add_transactiontype = 'T' and not exists (select 1 from stock s where s.product_id = add_productid AND s.site_id = add_salesiteid)
	THEN
RAISE WARNING 'No stock record found for the product % and site %'  , product_id , salesiteid;



--transaction quantity must always be specified and be a positive number
	ELSIF add_transactionquantity is NULL 
or 
add_transactionquantity < 0
	THEN
		RAISE WARNING 'Transaction quantity cannot be missing or negative';


--Transaction cost (value of sale) is not required for transfers but is required for sales and deliveries.
	ELSIF add_transactiontype = 'T' and add_transactioncost is not NULL
	THEN
		RAISE WARNING 'Product cost is not required for stock transfer';

	ELSIF add_transactiontype <> 'T' and (add_transactioncost is NULL or add_transactioncost < 0 :: money)
	THEN
		RAISE WARNING 'Transaction cost is required for transaction type and may not be negative';


--validation that there is enough stock to sell or move the quantity on the transaction at the supply site stock record.
ELSIF not exists(select 1 from stock s where s.product_id = add_productid 
AND s.site_id = add_supplysiteid
AND
s.Stock_quantity >= add_transactionquantity)
THEN
	RAISE WARNING 'Insufficient stock available at Supply Site % of Product %', add_supplysiteid, add_productid;

--transfers do not require a payment method, sales and deliveries require a valid method
	ELSIF add_transactiontype = 'T' and add_transactionpaymentmethod is not NULL
	THEN
		RAISE WARNING 'Payment method is not required for the stock transfer';

	ELSIF add_transactiontype <> 'T' and (add_transactionpaymentmethod = 'S' 
		OR add_transactionpaymentmethod = 'D' 
		OR add_transactionpaymentmethod = 'C'
		OR add_transactionpaymentmethod IS NULL)
	THEN
		RAISE WARNING 'Transaction payment method is one of S - standing order, D - Direct debit, C - Cash sale.';
-- only delivery transactions require a delivery date and a delivery Slot.
	ELSIF add_transactiontype <> 'D' and add_deliverydate is not NULL
	THEN
		RAISE WARNING 'Delivery date is only required for a delivery transaction';
	ELSIF add_transactiontype <> 'D' and add_deliveryslotrequest is not NULL
	THEN
		RAISE WARNING 'Delivery slot is only required for a delivery transaction';
--Transfers must have different site ids, sales must have the same site id  
	ELSIF add_transactiontype = 'T' and 
		add_supplysiteid = add_salesiteid
	THEN
		RAISE WARNING 'Supply site and sale site should not be the same';
	ELSIF add_transactiontype = 'S' and
		add_supplysiteid <> add_salesiteid
	THEN
	RAISE WARNING 'Supply site and sale site must be the same';
--Validate the delivery date is not before tomorrow
	ELSIF add_transactiontype = 'D' and add_deliverydate > current_date
	THEN
	RAISE WARNING 'Delivery must be after today';

--Validate the delivery slot is not taken
	ELSIF add_transactiontype = 'D' and 
	exists (select 1 from transaction t where t.delivery_date = add_deliverydate AND 
	t.deliveryslot_request = add_deliveryslotrequest)
	THEN
	RAISE WARNING 'Delivery Slot taken';
	
ELSE


/* data is valid create the transaction */

INSERT into Transaction
VALUES( DEFAULT,
		add_customerid,
		add_supplysiteid,
		add_productid,
		add_transactionquantity,
		add_transactioncost,
		add_transactionpaymentmethod,
		add_salesiteid,
		add_transactiontype,
		add_deliverydate,
		add_deliveryslotrequest
		);
	

	IF NOT FOUND
	THEN
			ROLLBACK;
			RAISE WARNING 'Transaction has failed to write';
	ELSE --insert transaction worked
		UPDATE Stock set stock_quantity = stock_quantity - add_transactionquantity
		WHERE stock.product_id = add_productid 
		And stock.site_id = add_supplysiteid;
			IF NOT FOUND 
			THEN
				ROLLBACK;
				RAISE WARNING 'Transaction failed on supplying site stock';
			ELSE-- update supply stock happened
				IF add_transactiontype = 'T'
				THEN
					UPDATE Stock set stock_quantity = stock_quantity + add_transactionquantity
					WHERE stock.product_id = add_productid 
					AND stock.site_id = add_salesiteid;
						IF NOT FOUND
						THEN
							ROLLBACK;
							RAISE WARNING 'transaction failed on transfer receiving site stock';
						ELSE --updated transfer stock
						COMMIT;
						END IF; -- transfer update found
				ELSE -- not a transfer
				COMMIT;
				END IF; -- transfer type
			END IF; -- supply stock update found
		END IF; -- transaction insert found

	END IF;

	END $$
;

--select * from Stock 
-- call to test stock transfer
CALL add_transaction
(
add_supplysiteid => 2000 :: NUMERIC,
add_productid => 5003 :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => 2001 :: NUMERIC,
add_transactiontype => 'T' :: CHAR,
add_customerid => NULL :: INTEGER,
add_transactioncost => NULL :: money,
add_transactionpaymentmethod => 'D' :: CHAR,
add_deliverydate => NULL :: DATE,
add_deliveryslotrequest => NULL :: VARCHAR
);

-- select * from transaction
-- select * from Stock 

-- add a sale transaction with a missing customer_id
CALL add_transaction

(
add_supplysiteid => 2001 :: NUMERIC,
add_productid => 5001 :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => 2001 :: NUMERIC,
add_transactiontype => 'S' :: CHAR,
add_customerid => NULL :: INTEGER,
add_transactioncost => NULL :: money,
add_transactionpaymentmethod => NULL :: CHAR,
add_deliverydate => NULL :: date,
add_deliveryslotrequest => NULL :: VARCHAR
);

-- add a stock transfer transaction with a customer_id
CALL add_transaction

(
add_supplysiteid => 2001 :: NUMERIC,
add_productid => 5001 :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => 2001 :: NUMERIC,
add_transactiontype => 'T' :: CHAR,
add_customerid => 3 :: INTEGER,
add_transactioncost => NULL :: money,
add_transactionpaymentmethod => NULL :: CHAR,
add_deliverydate => NULL :: date,
add_deliveryslotrequest => NULL :: VARCHAR
);

-- add a transaction with a missing product_id
CALL add_transaction

(
add_supplysiteid => 2001 :: NUMERIC,
add_productid => NULL :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => 2001 :: NUMERIC,
add_transactiontype => 'T' :: CHAR,
add_customerid => NULL :: INTEGER,
add_transactioncost => NULL :: money,
add_transactionpaymentmethod => NULL :: CHAR,
add_deliverydate => NULL :: date,
add_deliveryslotrequest => NULL :: VARCHAR
);


-- add a transaction with a missing sale_site_id
CALL add_transaction
(
add_supplysiteid => 2001 :: NUMERIC,
add_productid => 5001 :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => NULL :: NUMERIC,
add_transactiontype => 'T' :: CHAR,
add_customerid => NULL :: INTEGER,
add_transactioncost => NULL :: money,
add_transactionpaymentmethod => NULL :: CHAR,
add_deliverydate => NULL :: date,
add_deliveryslotrequest => NULL :: VARCHAR
);

--add a transaction with a missing supply_site_id
CALL add_transaction
(
add_supplysiteid => NULL :: NUMERIC,
add_productid => 5001 :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => 2002 :: NUMERIC,
add_transactiontype => 'D' :: CHAR,
add_customerid => 2 :: INTEGER,
add_transactioncost => '250.00' :: money,
add_transactionpaymentmethod => 'S' :: CHAR,
add_deliverydate => NULL :: date,
add_deliveryslotrequest => NULL :: VARCHAR
);

-- add a transaction where the stock is not available at supply_site_id
CALL add_transaction
(
add_supplysiteid => 2000 :: NUMERIC,
add_productid => 5004 :: NUMERIC,
add_transactionquantity => 3 :: INTEGER,
add_salesiteid => 2002 :: NUMERIC,
add_transactiontype => 'D' :: CHAR,
add_customerid => 2 :: INTEGER,
add_transactioncost => '12.00' :: money,
add_transactionpaymentmethod => 'S' :: CHAR,
add_deliverydate => to_date('2021-08-31', 'YYYY-MM-DD'),
add_deliveryslotrequest => 'AM' :: VARCHAR
);


-- cost present on a stock transfer
CALL add_transaction

(
add_customerid => NULL::INTEGER,
add_supplysiteid => 2001::NUMERIC,
add_productid => 5001::NUMERIC,
add_transactionquantity => 3::INTEGER,
add_transactioncost => 0.00::money,
add_transactionpaymentmethod => NULL::CHAR,
add_salesiteid => 2002::NUMERIC,
add_transactiontype => 'T'::CHAR,
add_deliverydate => NULL::date,
add_deliveryslotrequest => NULL::CHAR
);

