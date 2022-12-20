/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20221220@Eden
	Task: Create log action for Monitor SMA Win Loss [#RedmineID:#179067]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 31808 AND 31810
--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = NULL, @IsInternal BIT = 0

INSERT INTO @Log (ActionID, SPName, ActionNameEN,ActionNameCS,ActionNameCH,ActionNameTH)
SELECT 31808,'Acc_WLMonitored_SMA_Upd','Update Super Threshold',N'',N'',N'' UNION ALL
SELECT 31809,'Acc_WLMonitored_SMA_Upd','Update Master Threshold',N'',N'',N'' UNION ALL
SELECT 31810,'Acc_WLMonitored_SMA_Upd','Update Agent Threshold',N'',N'',N'' 
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN  31808 AND 31810
GO

