/*Created: Johnson
	Date: 2019-03-26
	Task: create new tier0 account
	DB: DBCUST/CUSTDB
	*/
	
SELECT 'HLTestCYCY01' as username
INTO #tmp
UNION SELECT 'HLTestCY02'
UNION SELECT 'HLTestCY03'
UNION SELECT 'HLTestCY04'
UNION SELECT 'HLTestCY05'
UNION SELECT 'HLTestCY06'
UNION SELECT 'HLTestCY07'
UNION SELECT 'HLTestCY08'
UNION SELECT 'HLTestCY09'
UNION SELECT 'HLTestCY10'

DECLARE @username  VARCHAR(30),
		@ErrCode INT = 0 , 
		@ErrMsg NVARCHAR(1000) = '' 
		
WHILE (1=1)
BEGIN
	SELECT TOP (1) @username = username 
	FROM #tmp
	
	IF @@rowcount = 0 BREAK;
			
	EXEC CS_DBA_Customer_HeadlineIns
		@firstname=N'CN88',
		@lastname=N'CY Test Headline',
		@address='',
		@postal='',
		@city='',
		@state='',
		@country='',
		@phone=N'',
		@mobilephone=N'',
		@email='',
		@fax=N'',
		@refcode1=N'',
		@creator=8,
		@username=@username,
		@userpwd='56E8A2D78170E87C928E480797CC73',
		@site=N'CN88',
		@currency=81,
		@ErrCode = @ErrCode OUTPUT,	
		@ErrMsg = @ErrMsg OUTPUT
	
	IF @@error > 0 
		SELECT @ErrCode,@ErrMsg
	
	DELETE FROM #tmp
	WHERE  username = @username 
	
	SELECT @ErrCode = 0,@ErrMsg =''
END
