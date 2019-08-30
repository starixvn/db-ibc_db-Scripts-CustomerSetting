/*
	Created by: Eden
	Date: 20190830
	Task: Remove data have been insert (if have problem) [Redmine:#117727]	
	DB: DBCUST/CustDB
*/

DECLARE @ListAccount TABLE (SMAAccount NVARCHAR(50))
INSERT INTO @ListAccount (SMAAccount)
	  SELECT 'FNU' 
UNION SELECT 'S69R'
UNION SELECT 'S69E'

DELETE bc
FROM BetRestriction_Customer bc WITH(ROWLOCK)
	 JOIN custinfo c WITH(NOLOCK)
		ON bc.CustID = c.custid 
	 JOIN @ListAccount lc 
		ON lc.SMAAccount = c.username
GO
