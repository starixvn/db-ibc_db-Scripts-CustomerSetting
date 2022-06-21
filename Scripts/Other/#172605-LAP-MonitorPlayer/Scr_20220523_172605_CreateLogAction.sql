﻿﻿/* <info serverAlias="DBLOG-bodb_CustomerLog"></info> */
/*
	Created: 20220523@Eden
	Task: Create log action for LAP - Player Segmentation - Monitored Player [#RedmineID:#172605]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE ActionID BETWEEN 31805 AND 31807
--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = NULL, @IsInternal BIT = 1

INSERT INTO @Log (ActionID, SPName, ActionNameEN)
SELECT 31805,'Acc_Dep_WLMonitored_Player_Ins','Insert Personal Threshold for customers' UNION ALL
SELECT 31806,'Acc_Dep_WLMonitored_Player_Upd','Update Personal Threshold for customers' UNION ALL
SELECT 31807,'Acc_Dep_WLMonitored_Player_Del','Delete Personal Threshold for customers'
 
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN,  ActionNameEN,ActionNameEN, @IsInternal, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID BETWEEN 31805 AND 31807
GO

