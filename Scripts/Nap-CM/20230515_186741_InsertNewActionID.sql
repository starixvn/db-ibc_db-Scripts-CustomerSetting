/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230504@Luke
	Task: Prepare log for Limit Monthly PT Update [Redmine: #186741]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

IF NOT EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID IN (473, 474)
)

BEGIN
	DECLARE @Log AS TABLE(
		ActionID INT
		,ActionNameEN NVARCHAR(256)
		,ActionNameCH NVARCHAR(256)
		,ActionNameCS NVARCHAR(256)
		,ActionNameTH NVARCHAR(256)
		,SPName VARCHAR(50)
	)

	DECLARE @ActionTypeID INT = 1,
			@IsInternal BIT = 0

	INSERT INTO @Log(ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, SPName)
	SELECT 473, 'Create PT Update Limitation Rule By Site/Currency', '', '', '', 'NAP_LimitPTDaily_Ins'
	UNION ALL
	SELECT 474, 'Delete PT Update Limitation Rule By Site/Currency', '', '', '', 'NAP_LimitPTDaily_Del'	

	INSERT INTO dbo.LogAction (
		ActionID
		,ActionTypeID
		,SPName
		,ActionNameEN
		,ActionNameCH
		,ActionNameCS
		,ActionNameJP
		,ActionNameIT
		,ActionnameTH
		,ActionNameKO
		,XsltContent
		,IsInternal
		,ActionNameVI
		,ActionNameCN
	)
	SELECT	ActionID
			,@ActionTypeID
			,SPName
			,ActionNameEN
			,ActionNameCH
			,ActionNameCS
			,ActionNameEN
			,NULL
			,ActionNameTH
			,ActionNameEN
			,NULL
			,@IsInternal
			,ActionNameEN
			,NULL
	FROM @Log

END
ELSE
	RAISERROR('ActionID(s) has already been used.', 16, 1)