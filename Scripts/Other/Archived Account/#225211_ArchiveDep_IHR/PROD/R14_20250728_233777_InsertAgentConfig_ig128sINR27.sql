/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250728@Tacy
	Task: ROUND 14 - ig128sINR27 [Redmine: #233777]
	DB: DBCUST-CustDB

	*** ig128sINR27 ~ 8.7M members
*/
USE CustDB
GO

--> Delete waiting members before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'

DELETE d
OUTPUT deleted.CustID, dbo.f_GetDateTime2()
INTO Dep_Customer_Archived_Del_InHouse (CustID, RepUpdateTime)
FROM  Dep_Customer_Archived d WITH(ROWLOCK)  
	INNER JOIN #TempDeleted t
		ON t.CustID = d.CustID
-------------------------------------
-------------------------------------

UPDATE cf
SET cf.Status=0
FROM Dep_Customer_Archived_Config cf WITH(UPDLOCK, ROWLOCK)
WHERE cf.Recommend=76504770
GO