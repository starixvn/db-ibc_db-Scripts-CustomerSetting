/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230504@Luke
	Task: Prepare log for Separate VR Basketball [Redmine: #185991]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DECLARE @ActionID INT,
		@ActionNameEN NVARCHAR(256),
		@SPName VARCHAR(50),
		@ActionTypeID INT = 4,
		@IsInternal BIT = 1

SELECT	@ActionID = 837,
		@ActionNameEN = 'Update Basketball Virtual Rate Lock Status',
		@SPName = 'Acc_VRCustLockStatusUpd'

IF NOT EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID = @ActionID)

BEGIN
	INSERT INTO dbo.LogAction(
		ActionID
		,ActionTypeID
		,SPName
		,ActionNameEN	
		,ActionNameCH 
		,ActionNameCS 
		,ActionNameJP 
		,ActionNameIT 
		,ActionNameTH 
		,ActionNameKO 
		,XsltContent 
		,IsInternal 
		,ActionNameVI 
		,ActionNameCN 
	)
	VALUES(
		@ActionID
		,@ActionTypeID
		,@SPName
		,@ActionNameEN
		,@ActionNameEN
		,@ActionNameEN
		,@ActionNameEN
		,NULL
		,@ActionNameEN
		,@ActionNameEN
		,NULL
		,@IsInternal
		,@ActionNameEN
		,@ActionNameEN
		)
END
ELSE
	RAISERROR('This ActionID has already been used.', 16, 1)