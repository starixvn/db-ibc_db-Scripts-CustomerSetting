﻿﻿/* <info serverAlias="DBLOG-bodb_CustomerLog"></info> */
/*
	Created: 20220523@Eden
	Task: Create log action for Alpha - My Monitor Accounts for Risk & Control [#RedmineID:#170467]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 31800 AND 31805
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
SELECT 31800,'Acc_WLMonitored_Global_Ins','Insert Global Threshold for customers',N'',N'',N'' UNION ALL
SELECT 31801,'Acc_WLMonitored_Global_Upd','Update Global Threshold for customers',N'',N'',N'' UNION ALL
SELECT 31802,'Acc_WLMonitored_Global_Del','Delete Global Threshold for customers',N'',N'',N'' UNION ALL
SELECT 31803,'Acc_WLMonitored_Personal_Ins','Insert Personal Threshold for customers',N'',N'',N'' UNION ALL
SELECT 31804,'Acc_WLMonitored_Personal_Upd','Update Personal Threshold for customers',N'',N'',N'' UNION ALL
SELECT 31805,'Acc_WLMonitored_Personal_Del','Delete Personal Threshold for customers',N'',N'',N'' 
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 31800 AND 31805
GO

