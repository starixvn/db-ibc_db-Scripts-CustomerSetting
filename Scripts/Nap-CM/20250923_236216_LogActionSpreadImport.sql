/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250923@Winfred
	Task: 20231101@Winfred: [NAP CM] - Customer - Sportsbook CC Management - Spread Management - Upload Excel File [#236216]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
			SELECT	31931, 'Data Import excel for customer class spread', 'NAP_CM_CustomerClassSpread_MultipleInsert', 1, NULL, NULL
UNION ALL	SELECT	31932, 'Data insert when Import excel for customer class spread', 'NAP_CM_CustomerClassSpread_MultipleInsert', 1, NULL, NULL ;

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID;

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID);