/*
	Created by: Eden
	Date: 20190830
	Task: Remove data have been insert (if have problem) [Redmine:#117727]	
	DB: DBCUST/CustDB
*/

DECLARE	 @SMAAccount1	INT
		,@SMAAccount2	INT
		,@SMAAccount3	INT

SELECT	@SMAAccount1 = CASE WHEN c.username  = 'FNU'  THEN c.custid ELSE @SMAAccount1 END,
		@SMAAccount2 = CASE WHEN c.username  = 'S69R' THEN c.custid ELSE @SMAAccount2 END,
		@SMAAccount3 = CASE WHEN c.username  = 'S69E' THEN c.custid ELSE @SMAAccount3 END
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN ('FNU', 'S69R', 'S69E')

DELETE 
FROM BetRestriction_Customer WITH(ROWLOCK)
WHERE custid IN (@SMAAccount1, @SMAAccount2, @SMAAccount3)

GO


