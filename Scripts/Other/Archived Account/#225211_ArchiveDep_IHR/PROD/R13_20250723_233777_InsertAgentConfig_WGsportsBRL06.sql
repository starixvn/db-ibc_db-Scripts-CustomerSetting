/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250723@Tacy
	Task: ROUND 13 - WGsportsBRL06 [Redmine: #233777]
	DB: DBCUST-CustDB

	*** WGsportsBRL06 ~ 5.6M members
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
WHERE cf.Recommend=91207301
GO