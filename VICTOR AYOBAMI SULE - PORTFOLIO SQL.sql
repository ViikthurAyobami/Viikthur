--Question 1; What is the total sales revenue in 2014?

Select sum(TotalDue) TotalSalesRevenue
from Sales.SalesOrderHeader
where YEAR(OrderDate) = 2014;

--Question 2; find the top 5 purchasing customers in 2014;

select top 5 C.CustomerID, sum(SOH.TotalDue) TotalPurchase
from Sales.SalesOrderHeader SOH
inner join Sales.Customer C on SOH.CustomerID = C.CustomerID
where year(SOH.OrderDate) = 2014
group by C.CustomerID
order by TotalPurchase desc;

-- Question 3; Show the top 10 product with the highest sales revenue?

Select top 10 P.ProductID, P.Name, sum(SOD.LineTotal)  TotalSalesRevenue
from Sales.SalesOrderDetail SOD
inner join Production.Product P on SOD.ProductID = P.ProductID
group by P.ProductID, P.Name
order by TotalSalesRevenue desc;

-- Question 4; Find the distinct employee with their job title;

select E.BusinessEntityID, P.FirstName, P.LastName, E.JobTitle
from HumanResources.Employee E
inner join Person.Person P on E.BusinessEntityID = P.BusinessEntityID
group by E.BusinessEntityID, P.FirstName, P.LastName, E.JobTitle
order by P.FirstName asc

-- Question 5; Calculate the average sales per order;

select AVG(TotalDue) AverageSalesPerOrder
from Sales.SalesOrderHeader;

-- Question 6; Find the count of Products availabel;

select COUNT(distinct Name) TotalProductsAvailable
from Production.Product
where SellEndDate is Null

-- Question 7; Find the count of product out of stock;

select COUNT(distinct Name) TotalProductsAvailable
from Production.Product
where SellEndDate IS NOT NULL

--Question 8; Find the top 10 products with positive profit margin;

select top 10 P.ProductID, P.Name ProductName, P.ListPrice SalesPrice, P.StandardCost CostPrice, (P.ListPrice - P.StandardCost) ProfitMargin
from Production.Product P
order by ProfitMargin desc

--Question 9; The total number of employees per department;

select D.Name DepartmentName, count(EDH.BusinessEntityID) TotalEmployees
from HumanResources.EmployeeDepartmentHistory EDH
inner join HumanResources.Department D on EDH.DepartmentID = D.DepartmentID
group by D.Name
order by count(EDH.BusinessEntityID) asc

--Question 10; average tenure of employees in the sales department;

select avg(datediff(year, StartDate, getdate())) AverageTenureInYears
from HumanResources.EmployeeDepartmentHistory EDH
where DepartmentID = (select DepartmentID from HumanResources.Department where Name = 'Sales')

--Question 11; total sales revenue generated by each sales representative;

select SalesPersonID, SUM(TotalDue) AS TotalSalesRevenue
from Sales.SalesOrderHeader S
group by SalesPersonID
having salespersonID is not Null
order by SUM(TotalDue) desc

--Question 12; number of male employee

select count(Gender) Male_Employee
from HumanResources.Employee
where Gender = 'M'

--Question 13; number of female employee

select count(Gender) Female_Employee
from HumanResources.Employee
where Gender = 'F'

--Question 14; Which customer has the highest average order value
select top 5 CustomerID, avg(TotalDue) AvgOrderValue
from Sales.SalesOrderHeader
group by CustomerID
order by AvgOrderValue desc

--Question 15; How many customers have placed more than five orders?

select count(CustomerID) NumCustomers
from(select CustomerID from Sales.SalesOrderHeader group by CustomerID
having count(SalesOrderID) > 5
) Subquery;

--Question 16; How many products were sold in each category

select PC.Name CategoryName, count(SOD.ProductID) ProductsSold
from Sales.SalesOrderDetail SOD
join Production.Product P on SOD.ProductID = P.ProductID
join Production.ProductSubcategory PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
join production.ProductCategory PC on PS.ProductCategoryID = PC.ProductCategoryID
group by PC.Name
order by ProductsSold desc;

--Question 17; What is the total sales revenue for each product category

select PC.Name CategoryName, sum(SOD.LineTotal) TotalSalesRevenue
from Sales.SalesOrderDetail SOD
join Production.Product P on SOD.ProductID = P.ProductID
join Production.ProductSubcategory PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
join Production.ProductCategory PC on PS.ProductCategoryID = PC.ProductCategoryID
group by PC.Name
order by TotalSalesRevenue desc;









	









