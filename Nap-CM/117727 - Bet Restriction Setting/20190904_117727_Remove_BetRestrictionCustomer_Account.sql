/*
	Created by: Eden
	Date: 20190904
	Task: Remove data test on UAT  : Account : Jacky-Ting, CustID=1813891 [Redmine:#117727]	
	DB: DBCUST/CustDB
*/

DECLARE @ListAccount TABLE (SMAAccount NVARCHAR(50))
INSERT INTO @ListAccount (SMAAccount)
	  SELECT 'Jacky-Ting' 

DELETE bc
FROM BetRestriction_Customer bc WITH(ROWLOCK)
	 JOIN custinfo c WITH(NOLOCK)
		ON bc.CustID = c.custid 
	 JOIN @ListAccount lc 
		ON lc.SMAAccount = c.username
GO
