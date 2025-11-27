/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Tacy@20251127
	Task: Correct data for members [#245412]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

UPDATE TOP (7) m
SET m.IsGroupedPT=1
	,m.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_CustSettingMode m WITH (ROWLOCK, UPDLOCK)
WHERE CustID IN (158297268, 275895021, 275895022
				,275895067, 275895103, 275895104)
GO

--
DELETE m
	OUTPUT deleted.CustID,deleted.SportType, deleted.BetType, deleted.IsLive, dbo.f_GetDateTime2()
	INTO Dep_CustPTSetting_Member_Del_InHouse (CustID, SportType, BetType, IsLive, RepUpdateTime)
FROM Dep_CustPTSetting_Member m WITH (ROWLOCK)
WHERE CustID IN (158297268, 275895021, 275895022
				,275895067, 275895103, 275895104)
GO