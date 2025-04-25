/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241008@Winfred
	DB: DBCUST/CustDB
	Task:  Enlarge bet limit requirement - Initdata
	Revisions:
		- 20250220@Winfred: [NAP CM] - Enlarge bet limit requirement - Initdata [RedmineID: #218073]
*/

INSERT INTO SVIPMaxBetPlayer(SiteID, custid, SportType, Bettype, Multiplier, Note, IsTest, LastModifiedUser, LastModifiedTime)
SELECT TOP 3 SiteID, custid, 0 AS SportType, 0 AS Bettype ,4 AS Multiplier, 'Initial Data for twpgmadam.liu' as Note,0 AS  IsTest, 8 AS LastModifiedUser,GETDATE() AS LastModifiedTime
FROM Customer a WITH(NOLOCK)
CROSS APPLY (SELECT TOP 1 siteid  FROM site WITH(NOLOCK) WHERE site = a.site ) s
WHERE a.custid IN ( 123099619, 123099621, 123099622)

INSERT INTO SVIPMaxBetHistory(SiteID, custid, SportType, Bettype, Multiplier, IsTest, [Action], LastModifiedUser, LastModifiedTime)
SELECT TOP 3 SiteID, custid, 0 AS SportType, 0 AS Bettype ,4 AS Multiplier, 0 AS  IsTest,  'Insert' as [Action], 8 AS LastModifiedUser,GETDATE() AS LastModifiedTime
FROM Customer a WITH(NOLOCK)
CROSS APPLY (SELECT TOP 1 siteid  FROM site WITH(NOLOCK) WHERE site = a.site ) s
WHERE a.custid IN ( 123099619, 123099621, 123099622)
