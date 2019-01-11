USE bodb02
GO
/*
	Created: Winnie 
	Task: Poker games
	Date: 20190110
	https://redmine.nexcel.vn/issues/107643
	Get MaxCustID AND Release Date.
	Run on DB06
*/

SELECT MAX(custid) as MaxCustID FROM custInfo WITH(NOLOCK)

SELECT GETDATE()

GO