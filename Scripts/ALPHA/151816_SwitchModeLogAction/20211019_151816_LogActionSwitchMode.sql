/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20211019@Winfred
	Task: log action Alpha Support Dark Mode  [#RM:151816]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DELETE FROM LogAction where ActionID = 1342
--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50))
		
DECLARE @ActionTypeID INT = 3, @IsInternal BIT = 0

INSERT INTO @Log (Level, ProductID, ActionID, ActionNameEN, SPName,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 4, 1, 1342,'Switch Light - Dark Mode','Age_SwitchDarkMode',N'Switch Light - Dark Mode',N'Switch Light - Dark Mode',N'Switch Light - Dark Mode' 

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

select * from LogAction  where ActionID = 1342
