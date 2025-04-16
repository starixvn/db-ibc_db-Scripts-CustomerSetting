/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240612@Winfred
	Task: 20240612@Winfred: NAP CM Customer Class - Add Peak Hour Spread on rule setting [RedmineID: #186118]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31921, 'Delete rule customer class Peak Hour Spread', 'NAP_CM_CustomerClassSpreadDel', 1, NULL, NULL UNION ALL
SELECT	31922, 'Enabled rule customer class  Peak Hour Spread', 'NAP_CM_CustomerClassSpreadEnable', 1, NULL, NULL UNION ALL
SELECT	31923, 'Update rule customer class  Peak Hour Spread', 'NAP_CM_CustomerClassSpreadUpd', 1, NULL, NULL UNION ALL
SELECT	31924, 'Insert rule customer class  Peak Hour Spread', 'NAP_CM_CustomerClassSpreadIns', 1, NULL, NULL UNION ALL
SELECT	31925, 'Delete rule customer class Peak Hour Ranger', 'NAP_CM_CCPeakHourRangerDel', 1, NULL, NULL UNION ALL
SELECT	31926, 'Update rule customer class Peak Hour Ranger', 'NAP_CM_CCPeakHourRangerUpd', 1, NULL, NULL UNION ALL
SELECT	31927, 'Insert rule customer class  Peak Hour Ranger', 'NAP_CM_CCPeakHourRangerIns', 1, NULL, NULL UNION ALL 
SELECT	31907, 'Delete rule customer class Spread', 'NAP_CM_CustomerClassSpreadDel', 1, NULL, NULL UNION ALL -- For CC Spread
SELECT	31908, 'Enabled rule customer class Spread', 'NAP_CM_CustomerClassSpreadEnable', 1, NULL, NULL UNION ALL
SELECT	31909, 'Update rule customer class Spread', 'NAP_CM_CustomerClassSpreadUpd', 1, NULL, NULL UNION ALL
SELECT	31910, 'Insert rule customer class Spread', 'NAP_CM_CustomerClassSpreadIns', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)