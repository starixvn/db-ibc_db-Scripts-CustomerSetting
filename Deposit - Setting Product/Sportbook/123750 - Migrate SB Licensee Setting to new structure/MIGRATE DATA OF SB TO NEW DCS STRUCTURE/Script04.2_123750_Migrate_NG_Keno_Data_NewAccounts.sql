/*
	Created: Eden
	Date: 20191029
	Task: Migrate data of Number Games and Keno to DCS - New accounts [RM:#123750]
	DB: DBCust/CustDB
*/
DECLARE @max_custid INT = xxx

DELETE a 
FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid

DELETE a 
FROM Dep_CustBetSetting_Member a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid

DELETE a 
FROM Dep_CustBetSettingGame_Agent a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid 

DELETE a 
FROM Dep_CustBetSettingGame_Member a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid

DELETE a 
FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid
  
DELETE a 
FROM Dep_CustPTSetting_Member a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid
 
DELETE a 
FROM Dep_CustDiscountSetting_Agent a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid
   
DELETE a 
FROM Dep_CustDiscountSetting_Member a WITH(ROWLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.Sporttype IN (161,202) AND a.CustID > @max_custid
  

-----------------------------------------

CREATE TABLE #MemberTemp(
		CustID INT PRIMARY KEY CLUSTERED
	,maxpermatch161	money
	,MaxPerBall161	money
)
CREATE TABLE #SMATemp(
		CustID INT PRIMARY KEY CLUSTERED
	,roleid TINYINT
	,maxpermatch161	money
	,MaxPerBall161	money
)

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	AND c.currency NOT IN (20,72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 AND username LIKE '%Acc%'

INSERT INTO #MemberTemp (
		CustID
	,maxpermatch161	
	,MaxPerBall161	
	)
SELECT custid
	,maxpermatch161	
	,MaxPerBall161	
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  AND Enabled = 1 AND custid > @max_custid
	AND srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	
INSERT INTO #SMATemp (
		CustID
	,roleid
	,maxpermatch161	
	,MaxPerBall161	
	)
SELECT custid
	,roleid
	,maxpermatch161	
	,MaxPerBall161	
FROM Custinfo WITH (NOLOCK)
WHERE roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid
	AND srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

------------------------------------PRODUC STATUS-----------------------------------------------
DECLARE @bitmapOrder_NG TINYINT, @bitmapOrder_KN TINYINT
SELECT @bitmapOrder_NG = bitmapOrder FROM Dep_ProductStatusProfile psp WITH (NOLOCK) WHERE PSP.Sporttype = 161 AND PSP.Bettype = 81
SELECT @bitmapOrder_KN = bitmapOrder FROM Dep_ProductStatusProfile psp WITH (NOLOCK) WHERE PSP.Sporttype = 202 AND PSP.Bettype = 1501

UPDATE c
SET	 bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder_KN,ci.HideKeno)
	,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder_NG,ci.DisableNumber)
FROM Dep_CustProductStatus c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	INNER JOIN  #SMATemp temp ON temp.CustID = c.custid

UPDATE c
SET	 bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder_KN,ci.HideKeno)
	,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder_NG,ci.DisableNumber)
FROM Dep_CustProductStatus c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

UPDATE c
SET c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder_KN,cg.IsDisabled)
FROM Dep_CustProductStatus c
	INNER JOIN CustGameType cg WITH(NOLOCK) ON c.CustID = cg.CustID AND GameTypeID = 1
	INNER JOIN  #SMATemp temp ON temp.CustID = c.custid

UPDATE c
SET c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder_KN,cg.IsDisabled)
FROM Dep_CustProductStatus c
	INNER JOIN CustGameType cg WITH(NOLOCK) ON c.CustID = cg.CustID AND GameTypeID = 1
	INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

------------------------------------Bet Setting-------------------------------------------------	
--Number Gamnes
INSERT INTO Dep_CustBetSettingGame_Agent(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
	,MaxPerBall
)
SELECT a.custid
		,a.sporttype
		,a.bettype
		,a.minbet
		,a.maxbet
		,c.maxpermatch161
		,c.MaxPerBall161
FROM Dep_CustSetting3rd a WITH(NOLOCK) 
	INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid 
WHERE SportType = 161 and bettype = 81 and islive = 0 

INSERT INTO Dep_CustBetSettingGame_Member(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
	,MaxPerBall
)
SELECT a.custid
		,a.sporttype
		,a.bettype
		,a.minbet
		,a.maxbet
		,c.maxpermatch161
		,c.MaxPerBall161
FROM Dep_CustSetting3rd a WITH(NOLOCK) 
	INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid
WHERE SportType IN (161) and bettype = 81 and islive = 0

--Keno
INSERT INTO Dep_CustBetSetting_Agent(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT a.custid
		,sporttype = 202
		,bettype = 1501
		,a.MinBet
		,a.maxbet
		,a.MaxPerGameType
FROM  CustGameType a WITH(NOLOCK) 
		INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
WHERE GameTypeID = 1

INSERT INTO Dep_CustBetSetting_Member(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT a.custid
		,sporttype = 202
		,bettype = 1501
		,a.MinBet
		,a.maxbet
		,a.MaxPerGameType
FROM CustGameType a WITH(NOLOCK)
		INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid  
WHERE GameTypeID = 1

------------------------------------PT Setting-------------------------------------------------------
--Number games	
INSERT INTO Dep_CustPTSetting_Agent (CustID, SportType, BetType, IsLive, AgentPT, MasterPT, SuperPT)
SELECT a.CustID, SportType, BetType, IsLive, apositiontaking * 100, mpositiontaking * 100, spositiontaking * 100
FROM Dep_CustSetting3rd a WITH(NOLOCK) 
	INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
WHERE SportType = 161 and bettype = 81 and islive = 0 

INSERT INTO Dep_CustPTSetting_Member(CustID, SportType, BetType, IsLive, AgentPT, MasterPT, SuperPT)
SELECT a.CustID, SportType, BetType, IsLive, apositiontaking * 100, mpositiontaking * 100, spositiontaking * 100
FROM Dep_CustSetting3rd a WITH(NOLOCK) 
	INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid 
WHERE SportType = 161 and bettype = 81 and islive = 0 

--Keno
INSERT INTO Dep_CustPTSetting_Agent (CustID, SportType, BetType, IsLive, AgentPT, MasterPT, SuperPT)
SELECT a.CustID, SportType, BetType, IsLive = 0, apositiontaking * 100, mpositiontaking * 100, spositiontaking * 100
FROM CustSettingGame a WITH(NOLOCK) 
		INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
WHERE SportType = 202 AND bettype = 1501

INSERT INTO Dep_CustPTSetting_Member (CustID, SportType, BetType, IsLive, AgentPT, MasterPT, SuperPT)
SELECT a.CustID, SportType, BetType, IsLive = 0, apositiontaking * 100, mpositiontaking * 100, spositiontaking * 100
FROM CustSettingGame a WITH(NOLOCK) 
		INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid 
WHERE SportType = 202 AND bettype = 1501

------------------------------------Commisson Setting-------------------------------------------------	
--Number Games
INSERT INTO Dep_CustDiscountSetting_Agent (CustID,SportType,BetType,Discount)
SELECT a.CustID,SportType,BetType
	,Discount = CASE WHEN c.roleid = 2 THEN a.adiscount 
						WHEN c.roleid = 3 THEN a.discount
						WHEN c.roleid = 4 THEN a.sdiscount
				END
FROM Dep_CustSetting3rd a WITH(NOLOCK) 
		INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
WHERE SportType = 161 and bettype = 81 and islive = 0 


INSERT INTO Dep_CustDiscountSetting_Member (CustID,SportType,BetType,PlayerDiscount,AgentDiscount,MasterDiscount,SuperDiscount)
SELECT a.CustID,SportType,BetType,PlayerDiscount,adiscount,discount,sdiscount
FROM Dep_CustSetting3rd a WITH(NOLOCK) 
	INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid
WHERE SportType = 161 and bettype = 81 and islive = 0

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #Dummy
DROP TABLE #supers