/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250114
	Task: Clean data test - InHouse [Redmine:#215807] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Delete data test:
USE CustDB
GO

DELETE TOP (7) 
FROM Dep_CustSabaInfo WITH (ROWLOCK)
OUTPUT deleted.CustID, dbo.f_GetDateTime2() 
	INTO Dep_CustSabaInfo_Del_InHouse(CustID, RepUpdateTime)
GO