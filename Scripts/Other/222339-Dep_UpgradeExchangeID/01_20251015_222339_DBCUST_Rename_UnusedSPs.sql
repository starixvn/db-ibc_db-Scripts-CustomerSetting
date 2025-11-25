/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251010@Tacy	
	Task: Drop unused SPs [RedmineId : 222339]
	DB: DBCUST-CustDB
*/

/*
	Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect
	Acc_Dep_CustSetting_NewBetLimitSettingSelect
	Acc_Dep_CustomerCheckMoveAgent
	Acc_Dep_CustomerCheckMoveMaster
	Acc_Dep_CustomerUpdMoveMember
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE CustDB
GO

DECLARE @_sp VARCHAR(100), @_new VARCHAR(100)
		, @SQL NVARCHAR(1000)

CREATE TABLE #tmpPROCEDURE (SP_Name VARCHAR(100))

INSERT INTO #tmpPROCEDURE (SP_Name)
SELECT [name] FROM sys.objects 
WHERE [type] = 'P' AND 
-- Original
	(  [name] = 'Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect'
	OR [name] = 'Acc_Dep_CustSetting_NewBetLimitSettingSelect'
	OR [name] = 'Acc_Dep_CustomerCheckMoveAgent'
	OR [name] = 'Acc_Dep_CustomerCheckMoveMaster'
	OR [name] = 'Acc_Dep_CustomerUpdMoveMember'

	OR [name] = 'Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect_xpre'
	OR [name] = 'Acc_Dep_CustSetting_NewBetLimitSettingSelect_xpre'
	OR [name] = 'Acc_Dep_CustomerCheckMoveAgent_xpre'
	OR [name] = 'Acc_Dep_CustomerCheckMoveMaster_xpre'
	OR [name] = 'Acc_Dep_CustomerUpdMoveMember_xpre'

	OR [name] = 'Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect_xtest'
	OR [name] = 'Acc_Dep_CustSetting_NewBetLimitSettingSelect_xtest'
	OR [name] = 'Acc_Dep_CustomerCheckMoveAgent_xtest'
	OR [name] = 'Acc_Dep_CustomerCheckMoveMaster_xtest'
	OR [name] = 'Acc_Dep_CustomerUpdMoveMember_xtest'

	OR [name] LIKE 'Acc_Dep_CustSetting_NewBetLimitFullLineSettingSelect_UAT%'
	OR [name] LIKE 'Acc_Dep_CustSetting_NewBetLimitSettingSelect_UAT%'
	OR [name] LIKE 'Acc_Dep_CustomerCheckMoveAgent_UAT%'
	OR [name] LIKE 'Acc_Dep_CustomerCheckMoveMaster_UAT%'
	OR [name] LIKE 'Acc_Dep_CustomerUpdMoveMember_UAT%'
)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @cnt INT

SELECT @cnt=COUNT(1) FROM #tmpPROCEDURE

DECLARE @msg_total VARCHAR(100) = @@SERVERNAME + ' - The total of the proc will be renamed: %d.'

PRINT ('===============================================================')
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT
PRINT ('===============================================================')

WHILE EXISTS (SELECT TOP 1 1 FROM #tmpPROCEDURE)
BEGIN
	SELECT TOP 1 
		  @_sp=SP_Name
		, @_new='DEL_' + SP_Name
	FROM #tmpPROCEDURE

	DELETE FROM #tmpPROCEDURE WHERE SP_Name=@_sp
	
	PRINT @_sp

	SET @SQL = N'EXEC sp_rename @OldName, @NewName, ''OBJECT'';';

	EXEC sp_executesql 
		@SQL,
		N'@OldName VARCHAR(100), @NewName VARCHAR(100)',
		@OldName = @_sp,
		@NewName = @_new;

	SET @SQL = NULL
END

DROP TABLE #tmpPROCEDURE
GO