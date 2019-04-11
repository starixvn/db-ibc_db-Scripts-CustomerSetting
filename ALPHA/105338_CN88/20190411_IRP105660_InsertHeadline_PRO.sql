/*Created: Johnson
	Date: 2019-04-11
	Task: create new headlines on PRO
	DB: DBCUST/CUSTDB
	*/
	
SELECT 'TestCN1' as username, 20 as currency, 'CN88' as firstname, 'Partner''s account' as lastname, 'CN88_00' groupName
INTO #tmp
UNION SELECT SELECT 'TestCN2' as username, 20 as currency, 'CN88' as firstname, 'Partner''s account' as lastname, 'CN88_11' groupName
UNION SELECT SELECT 'TestCN3' as username, 20 as currency, 'CN88' as firstname, 'Partner''s account' as lastname, 'CN88_22' groupName
UNION SELECT SELECT 'TestCN4' as username, 20 as currency, 'CN88' as firstname, 'Partner''s account' as lastname, 'CN88_33' groupName
UNION SELECT SELECT 'HLTestCY01' as username, 81 as currency, 'CN88' as firstname, 'OPS''s account' as lastname, 'CN88_33' groupName

DECLARE @username  VARCHAR(30),
		@currency INT,
		@firstname NVARCHAR(50),
		@lastname NVARCHAR(50),
		@groupName VARCHAR(50),
		@ErrCode INT = 0 , 
		@ErrMsg NVARCHAR(1000) = '' 
		
WHILE (1=1)
BEGIN
	SELECT TOP (1) @username = username,
			@currency = currency,
			@firstname = firstname,
			@lastname = lastname,
			@groupName = groupName
	FROM #tmp
	
	IF @@rowcount = 0 BREAK;
			
	EXEC CS_DBA_Customer_HeadlineIns
		@firstname=@firstname,
		@lastname=@lastname,
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
		@userpwd='19D7E0DB8276A8706F78F797E4A18A',
		@site=N'CN88',
		@currency=@currency,
		@groupName = @groupName,
		@ErrCode = @ErrCode OUTPUT,	
		@ErrMsg = @ErrMsg OUTPUT
	
	IF @@error > 0 
		SELECT @username,@ErrCode,@ErrMsg
	
	DELETE FROM #tmp
	WHERE  username = @username 
	
	SELECT @ErrCode = 0,@ErrMsg =''
END
