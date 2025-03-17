/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBCust-CustDB
	Note: Step 1 - Rename SPs no longer using
*/
USE CustDB
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpRenameObjectsName TABLE ( command VARCHAR(MAX), IsRename BIT)

INSERT INTO @tmpRenameObjectsName (command)
SELECT 'sp_rename ' + name + ', DEL_' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'Lrf_LicenseeBACust_Playerdiscount_Upd%'
	OR name LIKE 'Lrf_CustomerUpdMemberBAComm%'
	OR name LIKE 'Lrf_CustomerUpdMemberBAPositionTakingDCS%'
	OR name LIKE 'Lrf_EnableDisableBAMember%'
	OR name LIKE 'Lrf_CustBAActive_SynData%'
	OR name LIKE 'Lrf_CustomerUpdMemberBAStatus%'
	OR name LIKE 'Lrf_CustomerBAStatusSel%'
	OR name LIKE 'Lrf_BATimeCheck%'
	OR name LIKE 'Lrf_CustomerUpdMemberBA_PositionTaking%'
)

WHILE (1=1)
BEGIN
	UPDATE TOP (1) @tmpRenameObjectsName
	SET @command = command, 
		IsRename = 1
	WHERE IsRename IS NULL

	IF @@ROWCOUNT = 0
		BREAK;
	
	EXEC (@command)

END

SELECT * FROM @tmpRenameObjectsName
