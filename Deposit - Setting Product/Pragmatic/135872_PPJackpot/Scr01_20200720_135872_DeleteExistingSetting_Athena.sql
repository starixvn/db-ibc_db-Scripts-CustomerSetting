/*
	Date: 20200720
	Created: Elodie
	Task: DELETE existed setting for PP Jackpot - Deposit [#135872]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @ProductSettingID INT

SELECT @ProductSettingID = p.ProductSettingID
FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
	INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
WHERE sporttype = 248 AND SettingType = 1 AND bettype = 4101

CREATE TABLE #supers (custid int, isfinished bit default(0))

DECLARE @max_custid INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN Dep_LicenseeProductSetting ls WITH (NOLOCK) ON c.custid = ls.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency NOT IN (20)
 AND s.site IN ('Athena000', 'Spondemo')
 AND ls.ProductSettingID = @ProductSettingID

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (248, 4297)

------------------------------------PT Setting-------------------------------------------------	
SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustPTSetting_Agent
FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustPTSetting_Member
FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.AgentID,a.SportType,a.BetType
INTO #Dep_CustPTGroupSetting_Member
FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.AgentID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

---------------
--SELECT dl.CustID,dl.ProductSettingID
--INTO #Dep_LicenseeProductSetting
--FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
--		INNER JOIN Dep_ProductSettingDetail dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
--		INNER JOIN @SportBettype t ON dp.SportType = t.SportType and dp.BetType = t.BetType
--		INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
--		INNER JOIN #supers s ON ci.custid = s.custid

--DELETE a
--FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
--INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

DROP TABLE #Dep_CustPTGroupSetting_Member
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Member

