/*
	Created: Elodie
	Date: 2019-07-10
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
VALUES  ('AAA002'), ('AAA003'), ('AAA005'), ('AAA006'), ('AAA007'), ('AAA008'), ('AAA009'), ('AAA010'), ('AAA011')

IF EXISTS (SELECT 1
			FROM dbo.custInfo ci WITH (NOLOCK)
			WHERE ci.username IN (SELECT Name FROM @Headline))
BEGIN
    SELECT 'Username is not availabled.'
	RETURN
END

UPDATE hl 
SET hl.Currency = 81,
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
		@userpwd='19D7E0DB8276A8706F78F797E4A18A', --1q2wazsx
		@site=N'CN88',
		@currency=@Currency,
		@GroupName = @GroupName,
		@ErrCode = @ErrCode OUTPUT,
		@ErrMsg = @ErrMsg OUTPUT

	SET @i = @i + 1

END