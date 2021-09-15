/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210914@Eden
	Task: Insert LogAction for VRMemberBigStake exclude [RM#156824]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	836, 'Big Given Credit Member - Put On Queue', 'Acc_VR_MemberBigStake_Ins', 1, NULL, NULL  UNION ALL
SELECT	831, 'Big Given Credit Member - First Ticket', 'Acc_VR_MemberBigStake_FirstBetDate_Upd', 1, NULL, NULL  

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID IN(836,831)
