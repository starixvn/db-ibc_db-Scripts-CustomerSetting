/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250307@Johnson
	Task: DROP SPs on CustDB
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250307@Johnson: list sps rename on dbcust [RedmineID: #216870]
*/

USE CustDB
GO

DECLARE @_sp VARCHAR(100), @_new VARCHAR(100)
	, @SQL NVARCHAR(1000)

CREATE TABLE #tmpPROCEDURE (SP_Name VARCHAR(100), new_Name VARCHAR(100))

INSERT INTO #tmpPROCEDURE (SP_Name, new_Name)
SELECT [name], 'DEL_'+[name]
FROM sys.objects 
WHERE 
-- Original
(	[name] LIKE 'Acc_Initial_DCS_ConfigStatus_Upd'
	OR [name] LIKE 'Acc_Initial_DCS_CurrentStep_Upd'
	OR [name] LIKE 'Acc_Initial_DCS_ProcessedStep_Upd'
	OR [name] LIKE 'Acc_Initial_DCS_SettingConfig_Del'
	OR [name] LIKE 'Acc_Initial_DCS_SettingConfig_Ins'
	OR [name] LIKE 'Acc_Initial_DCS_SettingConfig_Upd'
	OR [name] LIKE 'Acc_Initial_DCS_InsertStepByConfigID'
	OR [name] LIKE 'Acc_ManageCansee_Del'
	OR [name] LIKE 'Acc_ManageCansee_Upd'
	OR [name] LIKE 'Acc_ManageCansee_Ins'
	OR [name] LIKE 'Acc_Initial_DCS_ProcessConfigStep'
	OR [name] LIKE 'Acc_UMTool_Configuration_Del'
	OR [name] LIKE 'Acc_UMTool_Configuration_Ins'
	OR [name] LIKE 'Acc_UMTool_Configuration_Upd'
	OR [name] LIKE 'Acc_UMTool_InUMWarning_Check'
	OR [name] LIKE 'NAP_WinLimit_AllGameGroupSettingSel'
	OR [name] LIKE 'NAP_WinLimit_CurrencySettingAllSiteSel'
	OR [name] LIKE 'f_Nap_WinLimit_ProductSettingSel'
	OR [name] LIKE 'f_Nap_WinLimit_CreditCurrencySel'
	OR [name] LIKE 'NAP_WinLimit_CurrencySettingSel'
	OR [name] LIKE 'NAP_WinLimit_GameGroupSettingSel'
	OR [name] LIKE 'NAP_Winlimit_GameGroupSettingIns'
	OR [name] LIKE 'NAP_WinLimit_GroupByProductSel'
	OR [name] LIKE 'NAP_WinLimit_UnassignedBettypeSel'
	OR [name] LIKE 'NAP_CWL_Update_Settings'
	OR [name] LIKE 'NAP_CWL_Initialize_Settings'
	OR [name] LIKE 'NAP_WinLimit_AllGroupSel'
	OR [name] LIKE 'NAP_WinLimit_AllProductSel'
	OR [name] LIKE 'NAP_WinLimit_CurrencySettingInactiveSiteUpd'
	OR [name] LIKE 'NAP_WinLimit_CurrencySettingSingleSel'
	OR [name] LIKE 'NAP_WinLimit_CustSettingValidateInsertingUser'
	OR [name] LIKE 'NAP_WinLimit_CurrencySettingUpd'
)

DECLARE @cnt INT

SELECT @cnt=COUNT(1) FROM #tmpPROCEDURE

DECLARE @msg_total nvarchar(200) = 'The total of the proc will be deleted: %d.'

PRINT ('==========================================')
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT
PRINT ('==========================================')

WHILE EXISTS (SELECT TOP 1 1 FROM #tmpPROCEDURE)
BEGIN
	SELECT TOP 1 @_sp=SP_Name
	FROM #tmpPROCEDURE

	DELETE FROM #tmpPROCEDURE WHERE SP_Name=@_sp

	SET @SQL = 'EXEC sp_rename ''' + @_sp + ''', ''' + @_new + ''''

	PRINT @_sp

	EXEC (@SQL)

	SET @SQL = NULL
END

DROP TABLE #tmpPROCEDURE
GO
