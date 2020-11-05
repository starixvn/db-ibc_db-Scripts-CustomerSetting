/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBCUST/CustDB
	
	1.SEXY GAMING
	2.SpadeGaming
	3.Keno (non DCS)
	4.Lottery
	5.Virtual Sport
	6.Virtual Sport 2
	7.Table Game
*/
USE CustDB
GO

CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT, srecommend INT)
SELECT DISTINCT srecommend 
INTO #srecommend
FROM custinfo (NOLOCK)
where custid in (40145966, 13682919, 36338495, 28307307, 32951617, 33120310, 31719323, 17126540, 4359308, 21975128, 14649242, 37208432, 15617041, 21203992, 
38469021, 15568418, 26192662, 43054417, 1574100, 31607889, 37099102, 40483121, 27429150, 43844052, 17433118, 44249382, 29740101, 35479115, 
40695064, 35684489, 10580724, 10580769, 10580778, 10580787, 40720570, 38321517, 29315709, 40515740, 34189562, 43183848, 41561087, 38583559)
 
CREATE TABLE #SporttypeBettype (Sporttype INT, Bettype INT, srecommend INT)
INSERT INTO #SporttypeBettype (Sporttype, Bettype, srecommend)
SELECT DISTINCT pd.SportType, pd.BetType,lp.CustID
FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
	INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
	INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID 
WHERE lp.CustID in (select srecommend FROM #srecommend)
	AND p.SettingType = 4
	AND p.ProductID IN (28,45,36,40,5,27) 
	
INSERT INTO #tblCust(Custid,roleid,srecommend)
SELECT custid, roleid, srecommend
FROM dbo.CustInfo WITH(NOLOCK)
WHERE custid IN (40145966, 13682919, 36338495, 28307307, 32951617, 33120310, 31719323, 17126540, 4359308, 21975128, 14649242, 37208432, 15617041, 21203992, 
38469021, 15568418, 26192662, 43054417, 1574100, 31607889, 37099102, 40483121, 27429150, 43844052, 17433118, 44249382, 29740101, 35479115, 
40695064, 35684489, 10580724, 10580769, 10580778, 10580787, 40720570, 38321517, 29315709, 40515740, 34189562, 43183848, 41561087, 38583559)	
			
--insert group comm setting
INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
	(AgentID
	,SportType
	,BetType
	,PlayerDiscount
	,AgentDiscount
	,MasterDiscount
	,SuperDiscount		
	)
SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0
FROM #tblCust t	
	CROSS APPLY (
				SELECT Sporttype, Bettype
				FROM #SporttypeBettype t1
				WHERE t.srecommend = t1.srecommend
		)sb
WHERE roleid = 2 
	AND NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustDiscountGroupSetting_Member ds (NOLOCK) 
		WHERE t.CustID = ds.agentID and sb.Sporttype = ds.sporttype and sb.Bettype = ds.bettype)
		
DROP TABLE #SporttypeBettype
DROP TABLE #srecommend
DROP TABLE #tblCust