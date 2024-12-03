/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241126@Johnson
	Task: Data patch for SA-TB
	DB: DBCust/CustDB
*/
CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)

--148 customers
INSERT INTO #tblCust(custid,roleid)
SELECT custid, roleid
FROM Custinfo WITH(NOLOCK)
WHERE srecommend = 4 --SA-TB
	AND enabled = 1

-- Create Temp Table stored SportType - BetType...
CREATE TABLE #Tmp_ProductSetting
(
	SettingType	  SMALLINT
	, Scr_SportType SMALLINT
	, Scr_BetType	  SMALLINT
	, Islive	  BIT DEFAULT 0
	, Dst_SportType SMALLINT
	, Dst_BetType	  SMALLINT
	PRIMARY KEY CLUSTERED (SettingType , Scr_SportType , Scr_BetType , Islive)
)

INSERT INTO #Tmp_ProductSetting
				(
					SettingType
				    , Scr_SportType
				    , Scr_BetType
				    , Islive
				    , Dst_SportType
				    , Dst_BetType
				)

-- PT			: SettingType = 28
SELECT 28 , 1 , 1 , 0 , 9914 , 915
UNION
SELECT 28 , 1 , 1 , 1 , 9913 , 915
UNION
SELECT 28 , 1 , 5 , 0 , 9914 , 916
UNION
SELECT 28 , 1 , 5 , 1 , 9913 , 916
UNION
SELECT 28 , 1 , 9999 , 0 , 9914 , 917
UNION
SELECT 28 , 1 , 9999 , 1 , 9913 , 917
UNION
SELECT 28 , 99 , 9 , 0 , 9915 , 918

--PT 
INSERT INTO [dbo].[CustPTSetting3rd_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]           
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]		   
           ,[IsAutoSuperPT]
           ,[AutoMasterPT]
		   ,[IsAutoMasterPT]
           ,[MinPT]
           ,[MaxPT]
           ,[RepUpdateTime])
-- Just affected Non Live PT Values
SELECT
	ci.custId
	, ps.Dst_SportType					AS SportType
	, ps.Dst_BetType					AS BetType
	, ps.Islive						AS Islive
	, spositiontaking			* 100		AS SuperPT
	, mpositiontaking			* 100		AS MasterPT
	, apositiontaking			* 100		AS AgentPT
	, autopositiontaking		* 100		AS AutoSuperPT
	, isautopositiontaking				AS IsAutoSuperPT
	, autompositiontaking		* 100		AS AutoMasterPT
	, isautompositiontaking				AS IsAutoMasterPT
	, ISNULL ( co.minpositiontaking * 100 , 0 ) AS MinPT
	, 100							AS MaxPT
	, dbo.f_GetDateTime2()
FROM #tblCust ci 
INNER JOIN custOverride co WITH (NOLOCK)
		ON ci.custid = co.custid
INNER JOIN #Tmp_ProductSetting ps
		ON co.SportType = ps.Scr_SportType
		AND co.BetType = ps.Scr_BetType
INNER JOIN custSetting cs WITH (NOLOCK)
		ON cs.custid = co.custid
		AND cs.SportType = co.SportType
		AND cs.BetType = co.BetType
WHERE roleid IN (2,3,4)
	AND ps.Islive = 0

UNION
-- BetType = 1  is Handicap : Collect Live Values
-- BetType <> 1 is (1X2, Others) : Copy Values From NonLive

SELECT
	ci.custId
	, ps.Dst_SportType AS SportType
	, ps.Dst_BetType   AS BetType
	, ps.Islive	     AS Islive
	, CASE
		WHEN cs.betType = 1 THEN slivepositiontaking * 100
		ELSE spositiontaking * 100
	END		     AS SuperPT
	, CASE
		WHEN cs.betType = 1 THEN mlivepositiontaking * 100
		ELSE mpositiontaking * 100
	END		     AS MasterPT
	, CASE
		WHEN cs.betType = 1 THEN alivepositiontaking * 100
		ELSE apositiontaking * 100
	END		     AS AgentPT
	, CASE
		WHEN cs.betType = 1 THEN autolivepositiontaking * 100
		ELSE autopositiontaking * 100
	END		     AS AutoSuperPT
	, CASE
		WHEN cs.betType = 1 THEN isautolivepositiontaking
		ELSE isautopositiontaking
	END		     AS IsAutoSuperPT
	, CASE
		WHEN cs.betType = 1 THEN autolivempositiontaking * 100
		ELSE autompositiontaking * 100
	END		     AS AutoMasterPT
	, CASE
		WHEN cs.betType = 1 THEN isautolivempositiontaking
		ELSE isautompositiontaking
	END		     AS IsAutoMasterPT
	, CASE
		WHEN cs.betType = 1 THEN ISNULL ( co.minlivepositiontaking * 100 , 0 )
		ELSE ISNULL ( co.minpositiontaking * 100 , 0 )
	END		     AS MinPT
	, 100		     AS MaxPT
	, dbo.f_GetDateTime2()
FROM #tblCust ci 
INNER JOIN custOverride co WITH (NOLOCK)
	ON ci.custid		= co.custid
INNER JOIN #Tmp_ProductSetting ps
	ON co.SportType	= ps.Scr_SportType
	AND co.BetType	= ps.Scr_BetType
INNER JOIN custSetting cs WITH (NOLOCK)
	ON cs.custid		= co.custid
	AND cs.SportType	= co.SportType
	AND cs.BetType	= co.BetType
WHERE ci.roleid	IN (2 , 3 , 4)	
	AND ps.Islive	= 1

INSERT INTO [dbo].[CustPTSetting3rd_Member]
           ([CustID]
           ,[SportType]
           ,[BetType] 
			,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]	
           ,[IsAutoSuperPT]
           ,[AutoMasterPT]
		   ,[IsAutoMasterPT]
           ,[RepUpdateTime])
SELECT
	ci.custid
	, ps.Dst_SportType				AS SportType
	, ps.Dst_BetType				AS BetType
	, ps.Islive					AS Islive
	, spositiontaking		* 100		AS SuperPT
	, mpositiontaking		* 100		AS MasterPT
	, apositiontaking		* 100		AS AgentPT
	, autopositiontaking	* 100		AS AutoSuperPT
	, isautopositiontaking			AS IsAutoSuperPT
	, autompositiontaking	* 100		AS AutoMasterPT
	, isautompositiontaking			AS IsAutoMasterPT
	, dbo.f_GetDateTime2()
FROM #tblCust ci 
INNER JOIN custSetting cs WITH (NOLOCK)
		ON ci.custid = cs.custid
INNER JOIN #Tmp_ProductSetting ps
		ON cs.SportType = ps.Scr_SportType
		AND cs.BetType = ps.Scr_BetType
WHERE roleid = 1
	AND ps.Islive	 = 0

UNION
-- BetType = 1  is Handicap : Collect Live Values
-- BetType <> 1 is (1X2, Others) : Copy Values From NonLive
SELECT
	ci.custId
	, ps.Dst_SportType AS SportType
	, ps.Dst_BetType   AS BetType
	, ps.Islive	     AS Islive
	, CASE
		WHEN cs.betType = 1 THEN slivepositiontaking * 100
		ELSE spositiontaking * 100
	END		     AS SuperPT
	, CASE
		WHEN cs.betType = 1 THEN mlivepositiontaking * 100
		ELSE mpositiontaking * 100
	END		     AS MasterPT
	, CASE
		WHEN cs.betType = 1 THEN alivepositiontaking * 100
		ELSE apositiontaking * 100
	END		     AS AgentPT
	, CASE
		WHEN cs.betType = 1 THEN autolivepositiontaking * 100
		ELSE autopositiontaking * 100
	END		     AS AutoSuperPT
	, CASE
		WHEN cs.betType = 1 THEN isautolivepositiontaking
		ELSE isautopositiontaking
	END		     AS IsAutoSuperPT
	, CASE
		WHEN cs.betType = 1 THEN autolivempositiontaking * 100
		ELSE autompositiontaking * 100
	END		     AS AutoMasterPT
	, CASE
		WHEN cs.betType = 1 THEN isautolivempositiontaking
		ELSE isautompositiontaking
	END		     AS IsAutoMasterPT
	, dbo.f_GetDateTime2()
FROM #tblCust ci 
INNER JOIN custSetting cs WITH (NOLOCK)
		ON ci.custid = cs.custid
INNER JOIN #Tmp_ProductSetting ps
		ON cs.SportType = ps.Scr_SportType
		AND cs.BetType = ps.Scr_BetType
WHERE roleid = 1
	AND ps.Islive = 1
GO

INSERT INTO [dbo].[CustSettingMode3rd]
           ([CustID]
           ,[IsGrouped]
           ,[RepUpdateTime])
SELECT ci.custid, 0, dbo.f_GetDateTime2()
FROM #tblCust ci
	LEFT JOIN CustSettingMode3rd cs (NOLOCK) ON ci.custid = cs.custId
WHERE cs.custid IS NULL
	AND ci.roleid = 1
GO	
	
--Comm
INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, Discount,RepUpdateTime)
SELECT
	cs.custid
	, cs.sporttype
	, cs.bettype
	, CASE
		WHEN cs.bettype = 1				   THEN cs.groupa					-- GroupA
		WHEN cs.bettype = 3				   THEN cs.groupb					-- GroupB
		WHEN cs.bettype = 7				   THEN cs.groupc					-- GroupC
		WHEN cs.bettype = 8				   THEN cs.groupd					-- GroupD
		WHEN cs.bettype IN (4 , 5) AND ci.roleid = 4 THEN cs.sdiscount				-- 1x2 Comm ,  Others Comm
		WHEN cs.bettype IN (4 , 5) AND ci.roleid = 3 THEN cs.adiscount				-- 1x2 Comm ,  Others Comm
		WHEN cs.bettype IN (4 , 5) AND ci.roleid = 2 THEN cs.discount				-- 1x2 Comm ,  Others Comm	
	END
	AS Discount,
	dbo.f_GetDateTime2()
FROM #tblCust ci 
	INNER JOIN custSetting cs WITH (NOLOCK)
		ON cs.custid = ci.custid
WHERE ci.roleid IN (2 , 3 , 4)
	AND cs.sporttype = 1
	AND cs.bettype IN (1,3,4,5,7,8)

INSERT INTO CustDiscount3rd_Member (CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount,RepUpdateTime)
SELECT
	cs.custid
	, cs.sporttype
	, cs.bettype
	, cs.playerdiscount
	, cs.discount
	, cs.adiscount
	, cs.sdiscount
	, dbo.f_GetDateTime2()
FROM
	#tblCust ci
INNER JOIN custSetting cs WITH (NOLOCK)
		ON cs.custid = ci.custid
INNER JOIN Customer c WITH (NOLOCK)
		ON cs.custid = c.custid
WHERE ci.roleid = 1		
	AND cs.sporttype = 1
	AND ( cs.bettype = CASE
					WHEN c.ugroup IN ('a' , 'hka' , 'dea') THEN 1
					WHEN c.ugroup IN ('b' , 'hkb' , 'deb') THEN 3
					WHEN c.ugroup IN ('c' , 'hkc' , 'dec') THEN 7
					WHEN c.ugroup IN ('d' , 'hkd' , 'ded') THEN 8
				  END 
	   OR cs.bettype IN (4 , 5)
		 )

INSERT INTO [dbo].[BetSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPayoutPerMatch]
           ,[RepUpdateTime])
SELECT [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPayoutPerMatch]
	   ,dbo.f_GetDateTime2()
FROM CustBetSetting_Agent WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
	AND sporttype NOT IN (161,164)
UNION 
SELECT [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,NULL [MaxPayoutPerMatch]
	   ,dbo.f_GetDateTime2()
FROM CustBetSetting3rd_Agent WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
	AND sporttype IN (43,44)
	
INSERT INTO [dbo].[BetSetting_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPayoutPerMatch]
           ,[RepUpdateTime])
SELECT [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPayoutPerMatch]
	   ,dbo.f_GetDateTime2()
FROM CustBetSetting_Member WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
	AND sporttype NOT IN (161,164)
UNION 
SELECT [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,NULL [MaxPayoutPerMatch]
	   ,dbo.f_GetDateTime2()
FROM CustBetSetting3rd_Member WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
	AND sporttype IN (43,44)		   
		   