USE bodb02
GO
/*
    Created: 20180305@Vicky
    Task: get max cust id
    DB: DB06
*/

SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

GO