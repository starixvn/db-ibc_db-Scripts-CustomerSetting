USE bodb02
GO
/*
	https://redmine.nexcel.vn/issues/97675
	Get MaxCustID AND Release Date.
	Run on DB06
*/

SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

SELECT GETDATE()

GO