/*
    Created: 20180305@Vicky
    Task: get max cust id
    DB: DBCUST/CustDB
*/
USE CustDB
GO
SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

GO