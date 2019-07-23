GO
/*
	http://nexdev.net/issues/116466
	Get MaxCustID
	Run on DBCust
*/

SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

GO
