/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBCust-CustDB
	Note: Step 2 - Drop SPs
*/
USE CustDB
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpDropObjectsName TABLE ( command VARCHAR(MAX), IsDrop BIT)

INSERT INTO @tmpDropObjectsName (command)
SELECT 'DROP PROCEDURE ' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DEL_Lrf_LicenseeBACust_Playerdiscount_Upd%'
	OR name LIKE 'DEL_Lrf_CustomerUpdMemberBAComm%'
	OR name LIKE 'DEL_Lrf_CustomerUpdMemberBAPositionTakingDCS%'
	OR name LIKE 'DEL_Lrf_EnableDisableBAMember%'
	OR name LIKE 'DEL_Lrf_CustBAActive_SynData%'
	OR name LIKE 'DEL_Lrf_CustomerUpdMemberBAStatus%'
	OR name LIKE 'DEL_Lrf_CustomerBAStatusSel%'
)

SELECT * FROM @tmpDropObjectsName

WHILE (1=1)
BEGIN
	UPDATE TOP (1) @tmpDropObjectsName
	SET @command = command, 
		IsDrop = 1
	WHERE IsDrop IS NULL

	IF @@ROWCOUNT = 0
		BREAK;
	
	EXEC (@command)

END


