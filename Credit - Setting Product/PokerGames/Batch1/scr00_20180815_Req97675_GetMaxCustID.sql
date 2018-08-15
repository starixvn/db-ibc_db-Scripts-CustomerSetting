USE bodb02
GO
/*
	https://redmine.nexcel.vn/issues/97675
	Get MaxCustID
	Run on DB06
*/

SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

GO