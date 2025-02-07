/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250109
	Task: Test - InHouse [Redmine:#215807] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--[Dep_CustSabaInfo]
INSERT INTO Dep_CustSabaInfo ([CustID],	[CustType],	[SabaID], [RepUpdateTime])
SELECT 123, 1, 1, dbo.f_GetDateTime2()

--SELECT
SELECT TOP 2 * FROM Dep_CustSabaInfo WITH (NOLOCK) WHERE CustID=123
SELECT TOP 2 * FROM DBBAH.bodb02.dbo.Dep_CustSabaInfo WITH (NOLOCK) WHERE CustID=123

------------------------------------------------------------------------
--Delete data test:
DELETE FROM Dep_CustSabaInfo WITH (ROWLOCK)
OUTPUT deleted.CustID, dbo.f_GetDateTime2() 
	INTO Dep_CustSabaInfo_Del_InHouse(CustID, RepUpdateTime)
WHERE CustID=123

--SELECT
SELECT TOP 2 * FROM Dep_CustSabaInfo WITH (NOLOCK) WHERE CustID=123
SELECT TOP 2 * FROM DBBAH.bodb02.dbo.Dep_CustSabaInfo WITH (NOLOCK) WHERE CustID=123
GO