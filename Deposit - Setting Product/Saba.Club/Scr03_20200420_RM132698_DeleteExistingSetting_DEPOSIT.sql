/*
	Date: 20200420
	Created: Eden
	Task: DELETE existed setting for Saba.Club - Deposit [#132698]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency IN (20,51)
 AND s.site IN ('Athena000', 'Spondemo'
				,'12Bet'
				,'asiabet88'
				,'mansion88'
				,'alog'
				,'SunGame'
				,'Mayfair'
				,'haifa'
				,'Bodog'
				,'W88'
				,'88Macao'
				,'Boma365'
				,'Ae88'
				,'Hengcai88'
				,'368Cash'
				,'KeenOcean'
				,'9Club'
				,'iBET'
				,'ISC888'
				,'DEWA'
				,'IBO'
				,'GamingSoft'
				,'DBP'
				,'HL8'
				,'Starnet'
				,'365online'
				,'NextBet'
				,'KhmerG'
				,'IONclub'
				,'webet88'
				,'Brown888'
				,'Taipanbet'
				,'IGPTech'
				,'Dawoo'
				,'IvoryBet'
				,'Opal88'
				,'Sunrise'
				,'UN168'
				,'K8VN'
				,'ECLBET'
				,'Lucky88'
				,'GPIGAME'
				,'Bobo88'
				,'Sunriseb2b'
				,'396Club'
				,'BBIN2'
				,'YongBao'
				,'GMASTER'
				,'ALPHA88'
				,'Tripleone'
				,'11bet'
				,'ENTAPLAY'
				,'zt828'
				,'9wickets'
				,'FB88'
				,'Monaco'
				,'MARS'
				,'Fabet'
				,'One88'
				,'VWIN66'
				,'A1game'
				,'AEUG'
				,'ig128'
				,'VN88'
				,'Sin88'
				,'Zbet'
				,'Debet'
				,'Sunwin'
				,'GGBOOK'
				,'HeleThai'
				,'Onegaming'
				,'Five88'
				,'WKCUR'
				,'WKPHIL'
				,'Win88'
				,'Xtu168'
				,'Asian88'
				,'BBIN3'
				,'ENT22'
				,'INSERTGAME'
				,'B24VN'
				,'Nova88'
				,'BBIN4'
				,'BOG22'
				,'Wanfang'
				,'24AVIA'
				,'KUTECH'
				,'Datang'
				,'erhaozhan'
				,'WKIBPH'
				,'MTech'
				,'12B'
				,'N88'
				,'QASite'
				,'Red88'
				,'Lode88'
				,'afb99'
				,'XTDGT'
				,'Zowin'
				,'N8G'
				,'N8B'
				,'GGBOOKES'
				,'SV88'
				,'Junbet'
				)

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (200, 1611)

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

-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustStakeLevel_Agent
FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustStakeLevel_Member
FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
INNER JOIN #supers s ON ci.srecommend = s.custid

DELETE a
FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 
-------------
SELECT dl.CustID,dl.ProductSettingID
INTO #Dep_LicenseeProductSetting
FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
		INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
		INNER JOIN #supers s ON ci.custid = s.custid
WHERE dp.ProductID = 42

DELETE a
FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

DROP TABLE #Dep_CustPTGroupSetting_Member
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Member
DROP TABLE #Dep_LicenseeProductSetting
DROP TABLE #Dep_CustStakeLevel_Agent
DROP TABLE #Dep_CustStakeLevel_Member