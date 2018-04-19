/*
    Created: 20180305@Vicky
    Task: get max cust id
    DB: DB06
*/
USE bodb02
GO
SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

GO