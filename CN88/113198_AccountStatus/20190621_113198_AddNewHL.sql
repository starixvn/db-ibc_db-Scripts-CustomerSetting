/*
	Created: Elodie
	Date: 2019-06-21
	Task: create new tier0 account
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @ErrCode INT = 0 , 
		@ErrMsg NVARCHAR(1000) = '',
		@Name VARCHAR(30), 
		@i INT = 1,
		@MaxId INT

DECLARE @Headline TABLE (ID INT IDENTITY (1,1), Name VARCHAR(30))

INSERT INTO @Headline (Name)
VALUES  ('HLTest21'), ('HLTest22'), ('HLTest23'), ('HLTest24'), ('HLTest25')

SELECT @MaxId = MAX(ID) FROM @Headline

WHILE (@i<=@MaxId)
BEGIN
	SELECT @Name = name FROM @Headline WHERE ID = @i

	EXEC CS_DBA_Customer_HeadlineIns
		@firstname=N'',
		@lastname=N'',
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
		@username=@Name,
		@userpwd='C268E7827BABD7657E85A85811D281',
		@site=N'CN88',
		@currency=20,
		@GroupName = 'CN88_00',
		@ErrCode = @ErrCode OUTPUT,
		@ErrMsg = @ErrMsg OUTPUT

	SET @i = @i + 1

END