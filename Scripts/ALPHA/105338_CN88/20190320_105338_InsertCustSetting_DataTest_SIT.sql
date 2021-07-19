/*
	Created: Elodie@20190320
	Task: Create data test for CN88
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @UserName NVARCHAR(50) = 'SuperTestCNV', @HeadlineUserName NVARCHAR(50) = 'HLTest01', @UserNameDownline NVARCHAR(50) = ''

EXEC CS_CustomerInsertDataTest @Username = @UserName, @RoleId = 4, @DownlineNumber = 1, @HeadlineUserName = @HeadlineUserName

SELECT @UserNameDownline = @UserName + '0001'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 3, @DownlineNumber = 4

SELECT @UserNameDownline = @UserName + '00010001'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'a'

SELECT @UserNameDownline = @UserName + '00010002'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'b'

SELECT @UserNameDownline = @UserName + '00010003'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'c'

SELECT @UserNameDownline = @UserName + '00010004'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'd'

SELECT * FROM custinfo WHERE username LIKE 'SuperTestCNV%'