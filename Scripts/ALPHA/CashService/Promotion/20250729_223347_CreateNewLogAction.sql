/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250508@Elodie
	Task: Create log action [#RedmineID:#224778]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 
DELETE 
FROM LogAction WITH(ROWLOCK,UPDLOCK) 
WHERE ActionID IN (	
					 315107 -- Add bonus transaction for cash member
				)

----Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, ActionNameCS NVARCHAR(256)
		, ActionNameCH NVARCHAR(256)
		, ActionNameTH NVARCHAR(256)
		, ActionNameVI NVARCHAR(256)
		, SPName VARCHAR(50)
		, ActionTypeID INT
		, IsInternal BIT
	)

INSERT INTO @Log (ActionID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI, ActionTypeID, IsInternal)
VALUES 
(315107, 'Task_CashService_BonusTransaction_Ins', 'Add bonus', 
 N'Add bonus', N'Add bonus', 
 N'Add bonus', 
 N'Add bonus',103,0)


INSERT INTO dbo.LogAction (ActionID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,ActionNameVI,ActionNameIT,ActionNameCN,ActionTypeID,IsInternal)
SELECT ActionID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameEN,  ActionNameTH,ActionNameEN,ActionNameVI,ActionNameEN, ActionNameEN,ActionTypeID,IsInternal
FROM @Log


GO


