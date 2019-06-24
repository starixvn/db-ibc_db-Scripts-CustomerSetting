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
		@Name VARCHAR(30), @GroupName VARCHAR(50), @Currency INT,
		@i INT = 1,
		@MaxId INT

DECLARE @Headline TABLE (ID INT IDENTITY (1,1), Name VARCHAR(30), GroupName VARCHAR(50), Currency INT)

INSERT INTO @Headline (Name)
VALUES  ('HLTest21'), ('HLTest22'), ('HLTest23'), ('HLTest24'), ('HLTest25')

UPDATE hl 
SET hl.Currency = 20,
	hl.GroupName = 'CN88_00'
FROM @Headline hl

SELECT @MaxId = MAX(ID) FROM @Headline

WHILE (@i<=@MaxId)
BEGIN
	SELECT @Name = name, @GroupName = GroupName, @Currency = Currency FROM @Headline WHERE ID = @i

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
		@userpwd='C268E7827BABD7657E85A85811D281', --1234aaAA
		@site=N'CN88',
		@currency=@Currency,
		@GroupName = @GroupName,
		@ErrCode = @ErrCode OUTPUT,
		@ErrMsg = @ErrMsg OUTPUT

	SET @i = @i + 1

END