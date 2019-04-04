--Table Creation

CREATE TABLE Customer
(CustomerID NUMBER(4,0),
FirstName VARCHAR2(30) NOT NULL,
LastName VARCHAR2(30) NOT NULL,
Phone VARCHAR2(12),
Email VARCHAR2(30),
Address VARCHAR2(40),
CONSTRAINT Customer_CustomerID_PK PRIMARY KEY (CustomerID));

CREATE TABLE UserAccount
(UserID NUMBER(4,0),
CustomerID NUMBER(4,0),
Password VARCHAR2(20) NOT NULL,
UserStatus VARCHAR2(8),
CONSTRAINT UserAccount_UserID_PK PRIMARY KEY (UserID),
CONSTRAINT UserAccount_CustomerID_FK FOREIGN KEY (CustomerID)
REFERENCES Customer (CustomerID));

CREATE TABLE ShoppingCart
(CartID NUMBER(4,0),
UserID NUMBER(4,0),
OrderItemID NUMBER(4,0),
Expired CHAR(1) DEFAULT 'N' NOT NULL,
Created DATE,
Quantity NUMBER(2,0),
ITEMPrice NUMBER(5,2),
CONSTRAINT ShoppingCart_CartID_PK PRIMARY KEY (CartID),
CONSTRAINT ShoppingCart_UserID_FK FOREIGN KEY (UserID)
REFERENCES UserAccount (UserID),
CONSTRAINT ShoppingCart_OrderItemID_FK FOREIGN KEY (OrderItemID)
REFERENCES OrderItem (OrderItemID),
CONSTRAINT ShoppingCart_Expired_CK CHECK (Expired IN ('Y','N')));

CREATE TABLE BillingAccount(
AccountID NUMBER(4,0),
CustomerID NUMBER(4,0),
CreditCardID NUMBER(4,0),
BillingAddress VARCHAR2(40),
CONSTRAINT BillingAccount_AccountID_PK PRIMARY KEY (AccountID),
CONSTRAINT BillingAccount_CustomerID_FK FOREIGN KEY (CustomerID)
REFERENCES Customer (CustomerID),
CONSTRAINT BillingAccount_CreditCardID_FK FOREIGN KEY (CreditCardID)
REFERENCES CreditCard (CreditCardID));

CREATE TABLE ShoppingOrder
(OrderID NUMBER(4,0),
AccountID NUMBER(4,0),
OrderDate DATE,
OrderShipped CHAR(1) DEFAULT 'N' NOT NULL,
CONSTRAINT ShoppingOrder_OrderID_PK PRIMARY KEY (OrderID),
CONSTRAINT ShoppingOrder_AccountID_FK FOREIGN KEY (AccountID)
REFERENCES BillingAccount (AccountID),
CONSTRAINT ShoppingOrder_OrderShipped_CK CHECK (OrderShipped IN ('Y','N')));

CREATE TABLE OrderItem
(OrderItemID NUMBER(4,0),
ProductID NUMBER(4,0),
OrderID NUMBER(4,0),
Quantity NUMBER(2,0),
ITEMPRICE NUMBER(5,2),
CONSTRAINT OrderItem_OrderItemID_PK PRIMARY KEY (OrderItemID),
CONSTRAINT OrderItem_ProductID_FK FOREIGN KEY (ProductID)
REFERENCES Product (ProductID),
CONSTRAINT OrderItem_OrderID_FK FOREIGN KEY (OrderID)
REFERENCES ShoppingOrder (OrderID));

CREATE TABLE Payment
(PaymentID NUMBER(4,0),
AccoundID NUMBER(4,0),
CreditCardID NUMBER(4,0),
Paid CHAR(1) DEFAULT 'N' NOT NULL,
Total NUMBER(5,2),
CONSTRAINT Payment_PaymentID_PK PRIMARY KEY (PaymentID),
CONSTRAINT Payment_AccountID_FK FOREIGN KEY (AccountID)
REFERENCES Account (AccountID),
CONSTRAINT Payment_CreditCardID_FK FOREIGN KEY (CreditCardID)
REFERENCES CreditCard (CreditCardID),
CONSTRAINT Payment_Paid_CK CHECK (Paid IN ('Y', 'N'));

CREATE TABLE CreditCard
(CreditCardID NUMBER(4,0),
CCNumber NUMBER(16,0),
HolderName VARCHAR2(60),
ExpiryDate DATE,
CONSTRAINT CreditCard_CreditCardID_PK PRIMARY KEY (CreditCardID));

CREATE TABLE Department
(DepartmentID NUMBER(4,0),
DepartmentName VARCHAR2(20),
CONSTRAINT Department_DepartmentID_PK PRIMARY KEY (DepartmentID));

CREATE TABLE Product
(ProductID NUMBER(4,0),
DepartmentID NUMBER(4,0),
ProductName VARCHAR2(25),
ProductDescription VARCHAR2(50),
ProductSize CHAR(1),
CONSTRAINT Product_ProductID_PK PRIMARY KEY (ProductID),
CONSTRAINT Product_DepartmentID FOREIGN KEY (DepartmentID)
REFERENCES Department (DepartmentID),
CONSTRAINT Product_ProductName_Unique UNIQUE (ProductName));


--Inserting Data
	-- Customer Table
INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (001, 'SUSAN', 'SMITH', '123 INTERNET ST SASKATCHEWAN CANADA', 'ssmith@gmail.com', '239-416-9055');

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (002, 'JEFF', 'BARBER', '100 YOUNG ST MANITOBA CANADA', 'barberjeff@gmail.com', '289-556-0021');

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (003, 'GARY', 'POTTS', '2 HIGHGATE RD ALBERTA CANADA', 'catsarecool@gmail.com', '905-123-5643');

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (004, 'MARY', 'MULBERRY', '773 RITSON AVE ONTARIO CANADA', 'marymulberry@gmail.com', '905-577-4167');

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (005, 'KAITLYN', 'OLD', '99 HAVEN ST ONTARIO CANADA', 'ssmith@gmail.com', '239-416-9055');

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (006, 'BOB', 'JOHNSON', '34 SIDE ST ONTARIO CANADA', 'johnsonbob@gmail.com', '416-854-0098');

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (007, 'LARRY', 'LAWSON', '40 WESTERN RD PEI CANADA', 'westernmovies@gmail.com', '416-721-9454');

	--UserAccount Table
INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (001, 001, 'bananas', 'VALID');

INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (002, 002, 'password', 'VALID');

INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (003, 003, '1234', 'VALID');

INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (004, 004, '110593', 'VALID');

INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (005, 005, 'centennial', 'VALID');

INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (006, 006, '01234', 'VALID');

INSERT INTO UserAccount (USERID, CUSTOMERID, PASSWORD, USERSTATUS)
VALUES (007, 007, 'mypassword', 'VALID');

	--ShoppingCart Table
INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(001, 007, 001, 'N', '31-MAY-13', 25.50, 12);

INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(002, 006, 002, 'N', '11-AUG-18', 15.00, 5);

INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(003, 005, 003, 'Y', '01-MAY-18', 20.75, 10);

INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(004, 004, 004, 'N', '20-JAN-17', 21.50, 10);

INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(005, 003, 005, 'N', '30-MAR-18', 15.25, 15);

INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(006, 002, 006, 'N', '05-FEB-18', 12.50, 10);

INSERT INTO ShoppingCart (CARTID, USERID, ORDERITEMID, EXPIRED, CREATED, ITEMPRICE, QUANTITY)
VALUES(007, 001, 007, 'N', '11-MAY-14', 10.75, 2);

	--ShoppingOrder Table 
INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(001, '15-JAN-18', 'N', 001);

INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(002, '25-MAR-18', 'Y', 002);

INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(003, '15-JAN-18', 'N', 003);

INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(004, '11-NOV-18', 'Y', 004);

INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(005, '08-SEP-18', 'N', 005);

INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(006, '31-OCT-18', 'N', 006);

INSERT INTO ShoppingOrder (ORDERID, ORDERDATE, ORDERSHIPPED, ACCOUNTID)
VALUES(007, '15-JAN-18', 'N', 007);

	--ORDERITEM Table 
INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(001, 001, 001, 12, 25.50);

INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(002, 002, 002, 5, 15.00);

INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(003, 003, 003, 10, 20.75);

INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(004, 004, 004, 10, 21.50);

INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(005, 005, 005, 15, 15.25);

INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(006, 006, 006, 10, 12.50);

INSERT INTO ORDERITEM (ORDERITEMID, PRODUCTID, ORDERID, QUANTITY, ITEMPRICE)
VALUES(007, 007, 007, 2, 10.75);

	--BillingAccount 
INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (001, 004, '773 RITSON AVE ONTARIO CANADA', 004);

INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (002, 002, '100 YOUNG ST MANITOBA CANADA', 002);

INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (003, 001, '123 INTERNET ST SASKATCHEWAN CANADA', 001);

INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (004, 003, '2 HIGHGATE RD ALBERTA CANADA', 003);

INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (005, 005, '99 HAVEN ST ONTARIO CANADA', 005);

INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (006, 007, '40 WESTERN RD PEI CANADA', 007);

INSERT INTO BillingAccount (ACCOUNTID, CUSTOMERID, BILLINGADDRESS, CREDITCARDID)
VALUES (007, 006, '34 SIDE ST ONTARIO CANADA', 006);

	--CreditCard 
INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (001, 547325238, 'SUSAN SMITH', '08-MAR-20');

INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (002, 92749683, 'JEFF BARBER', '11-MAY-22');

INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (003, 49379234, 'GARY POTTS', '01-JAN-21');

INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (004, 19387463, 'MARY MULBERRY', '12-OCT-22');

INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (005, 92749683, 'KAITLYN OLD', '11-MAY-22');

INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (006, 12894732, 'BOB JOHNSON', '20-DEC-20');

INSERT INTO CreditCard (CREDITCARDID, CCNUMBER, HOLDERNAME, EXPIRYDATE)
VALUES (007, 5937629304, 'LARRY LAWSON', '20-MAR-20');

	--PAYMENT 
INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (001, 007, 007, 'N', 100);

INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (002, 006, 006, 'Y', 15.00);

INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (003, 001, 004, 'N', 20.50);

INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (004, 002, 002, 'N', 12.50);

INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (005, 003, 001, 'Y', 60.75);

INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (006, 004, 003, 'N', 100);

INSERT INTO Payment (PAYMENTID, ACCOUNTID, CREDITCARDID, PAID, TOTAL)
VALUES (007, 005, 005, 'N', 32.25);

	--Product 
INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (001, 'Graphic T-Shirt', 'T-Shirt with picture on front', 'S', 001);

INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (002, 'Michelin Man Jacket', 'Puffy jack with two pockets', 'L', 002);

INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (003, 'Blue Jeans', 'Straight cut jeans', 'M', 003);

INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (004, 'Sports Jacket', 'Fitted blue sports jacket', 'L', 004);

INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (005, 'Turtleneck Sweater', 'Maroon coloured sweater', 'M', 001);

INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (006, 'Dress Pants', 'Light grey dress pants, no pockets', 'S', 004);

INSERT INTO Product (PRODUCTID, PRODUCTNAME, PRODUCTDESCRIPTION, PRODUCTSIZE, DEPARTMENTID)
VALUES (007, 'Tank Top', 'Loose pink coloured top', 'S', 001);

	--Department 
INSERT INTO Department (DEPARTMENTID, DEPARTMENTNAME)
VALUES (001, 'Tops');

INSERT INTO Department (DEPARTMENTID, DEPARTMENTNAME)
VALUES (002, 'Outerwear');

INSERT INTO Department (DEPARTMENTID, DEPARTMENTNAME)
VALUES (003, 'Pants');

INSERT INTO Department (DEPARTMENTID, DEPARTMENTNAME)
VALUES (004, 'Formal Wear');

--Sequences
CREATE SEQUENCE Customer_seq
INCREMENT BY 1
START WITH 008
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE BillingAccount_seq
INCREMENT BY 1
START WITH 008
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE UserAccount_seq
INCREMENT BY 1
START WITH 008
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE Department_seq
INCREMENT BY 1
START WITH 008
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

--Indexes
CREATE INDEX Email
ON Customer(Email);

CREATE INDEX CustName
ON Customer(FirstName,LastName);

CREATE INDEX custpassword
ON UserAccount(password);

--Triggers

create or replace trigger display_itemprice_changes
before delete or insert or update on ORDERITEM
for each row
when (new.orderitemid > 0)
  declare
  itemprice_diff number;
  begin
  itemprice_diff := :new.itemprice  - :old.itemprice;
  dbms_output.put_line('Old Price: ' || :old.itemprice);
 dbms_output.put_line('New Price: ' || :new.itemprice);
 dbms_output.put_line('Price Difference Savings: ' || itemprice_diff);
 end;


create or replace TRIGGER update_quantity_trg 
AFTER INSERT ON SHOPPINGCART 
for each row
  when(new.cartid > 0)
  
  declare 
  qty_count NUMBER;
  
  begin
  select count(quantity) 
  into qty_count
  from SHOPPINGCART
  where cartid = :new.cartid;
  
  if(qty_count < 5)
  then
  dbms_output.put_line('Quantity Low, Restock');
  end if;
  END;

--Procedures
create or replace PROCEDURE paymentpaid(
    p_paymentid IN NUMBER)
AS
  p_paid CHAR;
BEGIN
  SELECT paid INTO p_paid FROM payment WHERE p_paymentid = paymentid;
  IF p_paid = 'N' THEN
    DBMS_OUTPUT.PUT_LINE('Payment ID '||p_paymentid||' has not been paid ');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Payment ID '||p_paymentid||' has been paid ');
  END IF;
END;

create or replace PROCEDURE totalPrice(
    p_orderitemid IN NUMBER)
AS
  p_quantity   NUMBER(2,0);
  p_itemprice  NUMBER(5,2);
  p_totalprice NUMBER(5,2);
BEGIN
  SELECT quantity,
    itemprice
  INTO p_quantity,
    p_itemprice
  FROM orderitem
  WHERE orderitemid = p_orderitemid;
  p_totalprice     := p_quantity * p_itemprice;
  DBMS_OUTPUT.PUT_LINE('Total price for OderItemId '||p_orderitemid||' is '||p_totalprice);
END totalPrice;

--Functions
create or replace FUNCTION COUNTPRODUCT(
p_departmentid in number)
return number
is p_countproduct number(4,0);
begin
select  count(productid)
into p_countproduct
from product
where DEPARTMENTID = p_departmentid;
return p_countproduct;
end;

create or replace function totalPrice(
    p_orderitemid IN NUMBER)
return number
is
  p_totalprice NUMBER;
BEGIN
  SELECT quantity*itemprice
  into p_totalprice
  FROM orderitem
  WHERE orderitemid = p_orderitemid;
  return p_totalprice;
END totalPrice;
