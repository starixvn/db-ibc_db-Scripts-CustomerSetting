/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20241024@Eden
	Task: Create log action for crate Shadow account [#RedmineID:#204358]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE  ActionID IN (271005)
--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = NULL, @IsInternal BIT = 0

INSERT INTO @Log (ActionID, SPName, ActionNameEN)
SELECT 271005,'Dot_Dep_CustomerInsMember_Ag_Cust_Shadow','API Create New Shadow Account'
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameIT,ActionNameCN)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, @IsInternal, ActionNameEN, ActionNameEN, ActionNameEN
FROM @Log

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID IN (271005)
GO