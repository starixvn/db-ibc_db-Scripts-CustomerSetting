/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230620@Luke
	Task: Add new ActionIDs for Update Limit New Account Update PT by SMA & Site/Currency [Redmine: #188950]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

IF NOT EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID IN (478, 479)
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
	SELECT 478, 'Update Limit New Account Update PT By SMA Line', '', '', '', 'NAP_LimitPT_Upd'
	UNION ALL
	SELECT 479, 'Update Limit New Account Update PT By Site/Currency', '', '', '', 'NAP_LimitPT_Upd'	

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
	RAISERROR('ActionID(s) has been used.', 16, 1)
    