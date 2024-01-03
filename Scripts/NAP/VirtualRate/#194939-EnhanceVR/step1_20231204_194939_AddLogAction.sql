/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231204@Luke
	Task: NAP - Virtual rate - Enhance VR [Redmine: #194939]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--Insert new actionIDs
IF NOT EXISTS (
	SELECT TOP 1 1
	FROM dbo.LogAction
	WHERE ActionID IN (843,844,845,846,847,95116,95117,95118,2803,2804,2805)
)

BEGIN
	DECLARE @Log AS TABLE(
		ActionID INT
		,ActionNameEN NVARCHAR(256)
		,SPName VARCHAR(50)
	)

	DECLARE @ActionTypeID INT = 4,
			@IsInternal BIT = 1

	INSERT INTO @Log(ActionID, ActionNameEN, SPName)
	SELECT 843, 'Update VR Accumulated Balance Status for downlines', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 844, 'Update Soccer Virtual Rate Lock Status', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 845, 'Update Other Sports Virtual Rate Lock Status', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 846, 'Update Basketball Virtual Rate Lock Status', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 847, 'Update VR Accumulated Balance Status', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 95116, 'Update Virtual Rate on Super', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 95117, 'Update Virtual Rate on Master', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 95118, 'Update Virtual Rate on Agent', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 2803, 'Update Virtual Rate on Super', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 2804, 'Update Virtual Rate on Master', 'Acc_CustomerUpdVirtualMultiplier'
	UNION ALL
	SELECT 2805, 'Update Virtual Rate on Agent', 'Acc_CustomerUpdVirtualMultiplier'


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
			,ActionNameEN
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