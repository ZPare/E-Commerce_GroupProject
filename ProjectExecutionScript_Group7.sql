--Project Execution Script

	--Trigger display_itemprice_changes

update ORDERITEM 
set itemprice = 20.00
where orderitemid = 3;

select itemprice, orderitemid from orderitem;


	--Sequence Customer_seq

INSERT INTO Customer (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONE)
VALUES (customer_seq.nextval, 'MOLLY', 'WILSON', '411 EASTHAVEN RD PEI CANADA', 'wilsonm@gmail.com', '416-234-8364');

	--Procedure paymentpaid

	set serveroutput on;
--not paid
		begin 
		paymentpaid(1);
		end;
-- has been paid
		begin 
		paymentpaid(5);
		end;
		
	--Procedure producttype
--Display Tops
		begin 
		producttype(1);
		end;
--Display Pants
		begin 
		producttype(3);
		end;
		
	--Function totalprice

--Display 75
	select totalprice(2) from orderitem;

	--Function countproduct

SELECT DISTINCT departmentid,
  countproduct(departmentid) NumberOfProducts
FROM product
GROUP BY departmentid
ORDER BY departmentid;