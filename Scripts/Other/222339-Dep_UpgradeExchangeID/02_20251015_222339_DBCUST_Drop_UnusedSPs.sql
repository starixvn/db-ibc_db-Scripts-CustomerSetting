/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251010@Tacy	
	Task: Drop unused SPs [RedmineId : 222339]
	DB: DBCUST-CustDB
*/

/*
	DEL_Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect
	DEL_Acc_Dep_CustSetting_NewBetLimitSettingSelect
	DEL_Acc_Dep_CustomerCheckMoveAgent
	DEL_Acc_Dep_CustomerCheckMoveMaster
	DEL_Acc_Dep_CustomerUpdMoveMember
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE CustDB
GO

DECLARE @_sp VARCHAR(100), @SQL NVARCHAR(1000)

CREATE TABLE #tmpPROCEDURE (SP_Name VARCHAR(100))

INSERT INTO #tmpPROCEDURE (SP_Name)
SELECT [name] FROM sys.objects 
WHERE [type] = 'P' AND 
-- Original
	(  [name] = 'DEL_Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect'
	OR [name] = 'DEL_Acc_Dep_CustSetting_NewBetLimitSettingSelect'
	OR [name] = 'DEL_Acc_Dep_CustomerCheckMoveAgent'
	OR [name] = 'DEL_Acc_Dep_CustomerCheckMoveMaster'
	OR [name] = 'DEL_Acc_Dep_CustomerUpdMoveMember'

	OR [name] = 'DEL_Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect_xpre'
	OR [name] = 'DEL_Acc_Dep_CustSetting_NewBetLimitSettingSelect_xpre'
	OR [name] = 'DEL_Acc_Dep_CustomerCheckMoveAgent_xpre'
	OR [name] = 'DEL_Acc_Dep_CustomerCheckMoveMaster_xpre'
	OR [name] = 'DEL_Acc_Dep_CustomerUpdMoveMember_xpre'

	OR [name] = 'DEL_Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect_xtest'
	OR [name] = 'DEL_Acc_Dep_CustSetting_NewBetLimitSettingSelect_xtest'
	OR [name] = 'DEL_Acc_Dep_CustomerCheckMoveAgent_xtest'
	OR [name] = 'DEL_Acc_Dep_CustomerCheckMoveMaster_xtest'
	OR [name] = 'DEL_Acc_Dep_CustomerUpdMoveMember_xtest'

	OR [name] LIKE 'DEL_Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect_UAT%'
	OR [name] LIKE 'DEL_Acc_Dep_CustSetting_NewBetLimitSettingSelect_UAT%'
	OR [name] LIKE 'DEL_Acc_Dep_CustomerCheckMoveAgent_UAT%'
	OR [name] LIKE 'DEL_Acc_Dep_CustomerCheckMoveMaster_UAT%'
	OR [name] LIKE 'DEL_Acc_Dep_CustomerUpdMoveMember_UAT%'
)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @cnt INT

SELECT @cnt=COUNT(1) FROM #tmpPROCEDURE

DECLARE @msg_total nvarchar(200) = @@SERVERNAME + ' - The total of the proc will be deleted: %d.'

PRINT ('===============================================================')
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT
PRINT ('===============================================================')

WHILE EXISTS (SELECT TOP 1 1 FROM #tmpPROCEDURE)
BEGIN
	SELECT TOP 1 @_sp=SP_Name
	FROM #tmpPROCEDURE

	DELETE FROM #tmpPROCEDURE WHERE SP_Name=@_sp

	PRINT @_sp

	SET @SQL = 'DROP PROCEDURE IF EXISTS ' + @_sp 

	EXEC sp_executesql @SQL

	SET @SQL = NULL
END

DROP TABLE #tmpPROCEDURE
GO