/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230110@Winfred
	Task: Change Limitation to update PT one time per month [#RM:182469]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DELETE FROM LogAction where ActionID BETWEEN 470 AND 471
--Insert data
DECLARE @Log TABLE (Level TINYINT, ProductID TINYINT, ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50))
DECLARE @ActionTypeID INT = 1, @IsInternal BIT = 0

INSERT INTO @Log ( ActionID, ActionNameEN, SPName,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT  470,'Create Monthly PT Update Limitation Rule','NAP_LimitPTDaily_Ins',N'',N'',N'' UNION ALL
SELECT  471,'Delete Monthly PT Update Limitation Rule','NAP_LimitPTDaily_Del',N'',N'',N'' 


INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log





select * from LogAction  where ActionID  BETWEEN 470 AND 471
