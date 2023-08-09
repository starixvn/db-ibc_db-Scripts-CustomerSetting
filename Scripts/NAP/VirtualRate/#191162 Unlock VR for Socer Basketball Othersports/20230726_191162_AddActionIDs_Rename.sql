/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230724@Luke
	Task: Unlock VR for Soccer, Basketball, Other Sports [Redmine: #191162]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Insert new actionIDs
IF NOT EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID IN (840, 841, 842)
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

	DECLARE @ActionTypeID INT = 4,
			@IsInternal BIT = 1

	INSERT INTO @Log(ActionID, ActionNameEN, SPName)
	SELECT 840, 'Update Virtual Rate''s Additional Actions - Unlock VR for Soccer', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 841, 'Update Virtual Rate''s Additional Actions - Unlock VR for Basketball', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 842, 'Update Virtual Rate''s Additional Actions - Unlock VR for Other Sports', 'Acc_CustomerUpdVirtualMultiplier'
	
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
			,ActionNameEN
			,ActionNameEN
			,ActionNameEN
			,NULL
			,ActionNameEN
			,ActionNameEN
			,NULL
			,@IsInternal
			,ActionNameEN
			,ActionNameEN
	FROM @Log
END
ELSE
	RAISERROR('ActionID(s) has already been used.', 16, 1)
    
--Rename actionID 832
IF EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID = 832
)

BEGIN
	DECLARE @NewLog AS TABLE(
		ActionID INT,
		NewActionNameEN NVARCHAR(256)
	)

	INSERT INTO @NewLog(ActionID, NewActionNameEN)
	SELECT 832, 'Update Virtual Rate''s Additional Actions - Enable VR'

	UPDATE l
	SET l.ActionNameEN = n.NewActionNameEN
		,l.ActionNameCH = n.NewActionNameEN
		,l.ActionNameCS = n.NewActionNameEN
		,l.ActionNameJP = n.NewActionNameEN
		,l.ActionNameTH = n.NewActionNameEN
		,l.ActionNameKO = n.NewActionNameEN
		,l.ActionNameVI = n.NewActionNameEN
		,l.ActionNameCN = n.NewActionNameEN
	FROM dbo.LogAction l WITH (NOLOCK) 
		INNER JOIN @NewLog n ON l.ActionID = n.ActionID
END
ELSE
	RAISERROR('ActionID doesn''t exist.', 16, 1)
