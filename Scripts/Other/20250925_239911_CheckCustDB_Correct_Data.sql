/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Tacy@20250925
	Task: Correct data for member ug396IN19S1007608 [#239911]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

UPDATE TOP (2) m
SET m.IsGroupedPT=1
	,m.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_CustSettingMode m WITH (ROWLOCK, UPDLOCK)
WHERE CustID=263491389
go

-- 12 rows
DELETE TOP (13) m
	OUTPUT deleted.CustID,deleted.SportType, deleted.BetType, deleted.IsLive, dbo.f_GetDateTime2()
	INTO Dep_CustPTSetting_Member_Del_InHouse (CustID, SportType, BetType, IsLive, RepUpdateTime)
FROM Dep_CustPTSetting_Member m WITH (ROWLOCK)
WHERE CustID=263491389
GO