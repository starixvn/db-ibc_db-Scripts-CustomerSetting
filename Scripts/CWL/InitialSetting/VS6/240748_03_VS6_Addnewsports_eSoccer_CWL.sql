/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20251013@July
	Task: CWL - Virtual Sports 6 - Add new sports ''eSoccer" [Redmine: #240748]
	Database:	DBCUST.CustDB
*/
/*
	Full range: [13000 - 13199]
*/

USE CustDB
GO

DECLARE @GroupID INT 
SELECT @GroupID = GroupID
FROM Winlimit_Group WITH (NOLOCK) 
WHERE GroupName LIKE '%Virtual Sports 6%'

INSERT INTO Winlimit_GameGroupSetting (ProductID, BetTypeID, GroupID, RepUpdateTime)
SELECT DISTINCT ProductID, BetType, @GroupID, dbo.f_GetDateTime2()
FROM DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK) 
WHERE ProductID = 71 
AND BetType NOT IN (SELECT BetTypeID  FROM Winlimit_GameGroupSetting WITH (NOLOCK) WHERE ProductId = 71)
