/*
  1) Clone data from the Shippers table to the NewShippers table.
CREATE TABLE `NewShippers` (
  `ShipperID` int(11) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `Phone` varchar(24) DEFAULT NULL
);
insert into `NewShippers` select* from `shippers`;

select *from `NewShippers`;

  2) Get the list of suppliers which are related to each product name which has price greater than or equal 15$.
  ( Which information about supplier will be present in result set is optional)
SELECT suppliers.SupplierID, suppliers.ContactName, products.ProductName, products.UnitPrice
FROM suppliers
join products on suppliers.SupplierID=products.SupplierID
where products.UnitPrice>=15 
group by suppliers.SupplierID
order by suppliers.SupplierID;
  
3) Get the list of total quantities of ordered products which consists of: 
  total quantity ordered in Germany and the total quantity of products ordered in Sweden. (Result should contain 2 rows)
select  customers.country, sum(`order details`.quantity)
from customers
join orders on customers.CustomerID= orders.CustomerID
join `order details` on orders.OrderID=`order details`.OrderID
where customers.Country in ('Germany', 'Sweden')
group by customers.Country;

  4) Find the list of different countries in Employees and Customers tables.
 
 SELECT Country
FROM customers
WHERE Country IS NOT NULL
UNION
SELECT  Country
FROM employees
WHERE Country IS NOT NULL
ORDER BY Country;
  
5) Find the list of the same Postal Codes between Suppliers and Customers tables.
select suppliers.PostalCode, customers.PostalCode
from suppliers, customers
where suppliers.PostalCode=customers.PostalCode;

  6) Find the top Region, City and Country from which sales specialists were hired (means who sold the biggest quantity of products).
select employees.Region, employees.City, employees.country, sum(`order details`.quantity) as `quantity of products`
from employees 
join orders on  employees.EmployeeID=orders.EmployeeID
join `order details` on  orders.orderID=`order details`.OrderID
group by employees.EmployeeID
order by `quantity of products` desc
limit 1;
  7) Get two lists of products: with a price < 50.00 with a discountinued flag and < 50  without a discountinued flag.
SELECT productname, unitprice, Discontinued
FROM products
WHERE UnitPrice <50 and Discontinued=1
UNION all
SELECT  productname, unitprice, Discontinued
FROM products
WHERE UnitPrice <50 and Discontinued=0;
  
8) Create new table NewProducts based on the Products table with only discountinued products. Compare data sets between Products and NewProducts tables. 
  (Check that only discountinued products are inserted).
create table newproducts like products;
 
  insert into newproducts (ProductName, discontinued)
 select ProductName, discontinued from products;
 
select * from newproducts;
select * from products;

The 9th query is optional 
 * Get the list of orders, where a required date is bigger than the Shipped date ( compare in days) and Ship Region is not specified.
select datediff (requireddate, shippeddate), orders.OrderID, orders.ShipRegion, products.ProductName
  from orders
  join `order details` on orders.orderID=`order details`.orderID
  join products on `order details`.productID=products.productID 
where orders.ShipRegion is null;
  */
