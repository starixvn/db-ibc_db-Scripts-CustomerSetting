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

DECLARE @_sp VARCHAR(100), @_new VARCHAR(100)
	, @SQL NVARCHAR(1000)

CREATE TABLE #tmpPROCEDURE (SP_Name VARCHAR(100), new_Name VARCHAR(100))

INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
SELECT [name], 'DEL_'+[name]
FROM sys.objects 
WHERE [type] = 'P' AND 
-- Original
	(  [name] LIKE 'Acc_ReferenceSetting_Del%'
	OR [name] LIKE 'Acc_ReferenceSetting_Ins%'
	OR [name] LIKE 'Acc_ReferenceSetting_Upd%'

	OR [name] LIKE 'Acc_InitializingGlobal_BetLimitIns%'

	OR [name] LIKE 'Acc_Dep_Initial_DCS_SettingConfigDetail_Sel%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_SettingConfig_Sel%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_ProductProfile_Sel%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_BetSetting_Sel%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_SettingConfig_Del%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_SettingConfig_Check%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_SettingConfig_Ins%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_SettingConfig_Upd%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_ConfigStatus_Upd%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_CheckRunningStatusByConfigID%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_ScanConfig%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_InsertStepByConfigID%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_CurrentStep_Upd%'
	OR [name] LIKE 'Acc_Dep_Initial_DCS_ProcessedStep_Upd%'

	OR [name] LIKE 'NAP_Domain_Check%'
	OR [name] LIKE 'NAP_Domain_Del%'
	OR [name] LIKE 'NAP_Domain_Ins%'
	OR [name] LIKE 'NAP_Domain_Upd%'

	OR [name] LIKE 'NAP_Admin_AddNewSite%'
	OR [name] LIKE 'Acc_GameLaunchSel%'

	OR [name] LIKE 'Task_DetectBet_Dep_StakeLevelHistory_Insert%'
	OR [name] LIKE 'Task_DetectBet_StakeLevelHistory_Insert%'
)

DECLARE @cnt INT

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