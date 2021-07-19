/*Created: Johnson
	Date: 2019-03-20
	Task: create new tier0 account
	DB: DBCUST/CUSTDB
	*/
	
SELECT 'HLTest01' as username
INTO #tmp
UNION SELECT 'HLTest02'
UNION SELECT 'HLTest03'
UNION SELECT 'HLTest04'
UNION SELECT 'HLTest05'
UNION SELECT 'HLTest06'
UNION SELECT 'HLTest07'
UNION SELECT 'HLTest08'
UNION SELECT 'HLTest09'
UNION SELECT 'HLTest10'

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
		@lastname=N'Test Headline',
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
		@currency=20,
		@ErrCode = @ErrCode OUTPUT,	
		@ErrMsg = @ErrMsg OUTPUT
	
	IF @@error > 0 
		SELECT @ErrCode,@ErrMsg
	
	DELETE FROM #tmp
	WHERE  username = @username 
	
	SELECT @ErrCode = 0,@ErrMsg =''
END
