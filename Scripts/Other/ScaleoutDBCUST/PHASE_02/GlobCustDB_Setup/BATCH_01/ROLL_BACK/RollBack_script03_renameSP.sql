/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250116@Tacy	
	Task: DROP SPs on CustDB
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE CustDB
GO

DROP TABLE IF EXISTS #tmpPROCEDURE;
CREATE TABLE #tmpPROCEDURE (SP_Name VARCHAR(100), new_Name VARCHAR(100))

IF OBJECT_ID(N'dbo.SportBettypeSettingMatrix', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Acc_ReferenceSetting_Del%'
		OR [name] LIKE 'DEL_Acc_ReferenceSetting_Ins%'
		OR [name] LIKE 'DEL_Acc_ReferenceSetting_Upd%'
	)
GO

IF (OBJECT_ID(N'dbo.Dep_ProductBetSetting', 'U') IS NOT NULL
	OR OBJECT_ID(N'dbo.Dep_StakeLevel', 'U') IS NOT NULL
	OR OBJECT_ID(N'dbo.Dep_StakeLevelGroupDetail', 'U') IS NOT NULL
	OR OBJECT_ID(N'dbo.ProductBetSetting', 'U') IS NOT NULL
	OR OBJECT_ID(N'dbo.StakeLevel', 'U') IS NOT NULL)
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Acc_InitializingGlobal_BetLimitIns%'
	)
GO


IF OBJECT_ID(N'dbo.Dep_Initial_BetSetting', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Acc_Dep_Initial_DCS_BetSetting_Sel%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_SettingConfig_Del%'
	)
GO

IF OBJECT_ID(N'dbo.Dep_Initial_ProductConfig', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Acc_Dep_Initial_DCS_SettingConfig_Check%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_ConfigStatus_Upd%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_CurrentStep_Upd%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_CheckRunningStatusByConfigID%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_ProcessedStep_Upd%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_ScanConfig%'
	)
GO


IF OBJECT_ID(N'dbo.Dep_Initial_ProductConfig_Detail', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Acc_Dep_Initial_DCS_SettingConfigDetail_Sel%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_SettingConfig_Ins%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_SettingConfig_Sel%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_ProductProfile_Sel%'
	)
GO


IF OBJECT_ID(N'dbo.Dep_Initial_StepByConfig', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Acc_Dep_Initial_DCS_SettingConfig_Upd%'
	OR [name] LIKE 'DEL_Acc_Dep_Initial_DCS_InsertStepByConfigID%'

	)
GO

IF OBJECT_ID(N'dbo.Dep_StakeLevel_History', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_Task_DetectBet_Dep_StakeLevelHistory_Insert%'
	OR [name] LIKE 'DEL_Task_DetectBet_StakeLevelHistory_Insert%'
	)
GO

IF OBJECT_ID(N'dbo.DomainManagement', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
		[name] LIKE 'DEL_NAP_Domain_Check%'
	OR [name] LIKE 'DEL_NAP_Domain_Del%'
	OR [name] LIKE 'DEL_NAP_Domain_Ins%'
	OR [name] LIKE 'DEL_NAP_Domain_Upd%'
	)
GO

IF OBJECT_ID(N'dbo.GameLaunchPerSite', 'U') IS NOT NULL
	OR OBJECT_ID(N'dbo.GameLaunchPerCurrency', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
	[name] LIKE 'DEL_Acc_GameLaunchSel%'
	)
GO


IF OBJECT_ID(N'dbo.Site', 'U') IS NOT NULL
	INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
	SELECT [name], RIGHT([name], LEN([name]) - 4) 
	FROM sys.objects 
	WHERE [type] = 'P' AND 
	(
	[name] LIKE 'DEL_NAP_Admin_AddNewSite%'
	)
GO

DECLARE @cnt INT
DECLARE @_sp VARCHAR(100), @_new VARCHAR(100)
	, @SQL NVARCHAR(1000)

SELECT @cnt=COUNT(1) FROM #tmpPROCEDURE

DECLARE @msg_total nvarchar(200) = 'The total of the proc will be rename: %d.'

PRINT ('==========================================')
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT
PRINT ('==========================================')

WHILE EXISTS (SELECT TOP 1 1 FROM #tmpPROCEDURE)
BEGIN
	SELECT TOP 1 
		  @_sp=SP_Name
		, @_new=new_Name
	FROM #tmpPROCEDURE

	DELETE FROM #tmpPROCEDURE WHERE SP_Name=@_sp

	SET @SQL = 'EXEC sp_rename ''' + @_sp + ''', ''' + @_new + ''''

	PRINT @_sp

	EXEC (@SQL)

	SET @SQL = NULL
END

DROP TABLE #tmpPROCEDURE
GO