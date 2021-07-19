/*
	Creator: 20200709@Eden
	Task: Insert Sport_Bettype_Reference_VirtualRate - Redmine: #134978
	DB: DBTXN/bodb02
*/

USE bodb02
GO

DELETE
FROM dbo.Sport_Bettype_Reference_VirtualRate WITH(ROWLOCK) 
WHERE sporttype = 2

INSERT INTO dbo.Sport_Bettype_Reference_VirtualRate(SportType,BetType,SportTypeRefVirtualRate,BetTypeRefVirtualRate,isActive)
SELECT 2, 1, 2, 1, 1
UNION ALL SELECT 2, 2, 2, 2, 1
UNION ALL SELECT 2, 3, 2, 3, 1
UNION ALL SELECT 2, 7, 2, 7, 1
UNION ALL SELECT 2, 8, 2, 8, 1
UNION ALL SELECT 2, 20, 2, 20, 1
UNION ALL SELECT 2, 21, 2, 21, 1
UNION ALL SELECT 2, 401, 2, 401, 1
UNION ALL SELECT 2, 603, 2, 603, 1
UNION ALL SELECT 2, 606, 2, 606, 1
UNION ALL SELECT 2, 609, 2, 609, 1
UNION ALL SELECT 2, 610, 2, 610, 1
UNION ALL SELECT 2, 612, 2, 612, 1


SELECT * 
FROM dbo.Sport_Bettype_Reference_VirtualRate WITH(NOLOCK) 
WHERE sporttype = 2