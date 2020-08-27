/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200826
	Task:  Insert Data keno RedmineID:#137768
	DB: DBCust/CustDB
*/
USE CustDB
GO 

Declare @CustID Int = 23639489
,@srecommend INT,@mrecommend INT,@recommend Int, @roleid TINYINT  ,@currency INT

SELECT 
	@roleid = roleid, 
	@srecommend = srecommend, 
	@mrecommend = mrecommend, 
	@recommend = recommend	,
	@currency = currency
FROM custinfo WITH(NOLOCK)
WHERE custid = @custid 

IF @srecommend <> 72 
BEGIN
	return
	Print 'Super Error' 
END
    
DECLARE @GameType TABLE (GameTypeID INT, IBCBetTypeID INT)
INSERT INTO @GameType (GameTypeID, IBCBetTypeID)
SELECT GameTypeID, IBCBetTypeID 
FROM DBAGE.bodb02.dbo.GameType WITH (NOLOCK) 
WHERE IBCBetTypeID BETWEEN 1501 AND 1599 AND IsDisabled = 0


-- create cust line
CREATE TABLE #CustList		(CustID INT PRIMARY KEY,Roleid INT)
INSERT INTO #CustList(CustID,Roleid)
SELECT custid,Roleid 
FROM custinfo WITH(NOLOCK)  
WHERE srecommend =  @srecommend  AND Enabled=1

CREATE TABLE #CustGameType_Temp (CustID INT,GameTypeID	INT,StakeLevelList	VARCHAR DEFAULT('')
								,MaxPerGameType	MONEY,MinBet	MONEY
								,MaxBet	MONEY, IsDisabled	BIT DEFAULT(0))
						

-- delete data old
Delete a
FROM   CustGameType  a 
INNER JOIN #CustList b on a.CustID = b.CustID
where a.GameTypeID in (select GameTypeID from  @GameType )

-- Insert List Keno
INSERT INTO #CustGameType_Temp (CustID,GameTypeID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled)  
SELECT  b.CustID 
		,a.GameTypeID
		,'' as StakeLevelList
		,0 as MaxPerGameType
		,0 as MinBet
		,0 as MaxBet
		,0 as IsDisabled
FROM @GameType a,#CustList b
WHERE NOT EXISTS(SELECT 1 FROM CustGameType c WHERE b.CustID = c.CustID and c.GameTypeID in (select GameTypeID from  @GameType ))

INSERT INTO CustGameType(GameTypeID,CustID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled)
SELECT  GameTypeID,CustID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled FROM #CustGameType_Temp
--SELECT * from #CustGameType_Temp

--CREATE TABLE #CustSettingGame_Temp (								
--					CustID	int	,Bettype SMALLINT,Sporttype	SMALLINT
--					,apositiontaking SMALLMONEY	,mpositiontaking SMALLMONEY	,spositiontaking SMALLMONEY
--					,playerdiscount	DECIMAL(9,8),discount DECIMAL(9,8) ,adiscount DECIMAL(9,8)
--					,sdiscount	DECIMAL(9,8),autopositiontaking	SMALLMONEY,isautopositiontaking	BIT
--					,autompositiontaking	SMALLMONEY,isautompositiontaking	BIT	)

--CREATE TABLE #BETTYPE(Bettype INT)
--INSERT INTO #BETTYPE VALUES (1511),(1503),(1504),(1505),(1513),(1507),(1508),(1509),(1514),(1501)

---- delete data old
--Delete a
--FROM   CustSettingGame  a with(nolock)
--INNER JOIN #CustList b on a.CustID = b.CustID
--where a.Bettype in (select Bettype from  #BETTYPE ) AND Sporttype = 202

--INSERT INTO #CustSettingGame_Temp (CustID,Bettype,Sporttype ,apositiontaking,mpositiontaking,spositiontaking,playerdiscount,discount,adiscount,sdiscount,autopositiontaking
--									,isautopositiontaking,autompositiontaking,isautompositiontaking)
--SELECT  b.CustID 
--		,a.Bettype
--		,202 as Sportype
--		,CASE WHEN B.Roleid = 4 THEN 0.85 ELSE 0 END AS apositiontaking
--		,CASE WHEN B.Roleid = 4 THEN 0.85 ELSE 0 END AS mpositiontaking
--		,CASE WHEN B.Roleid IN (1,3,4) THEN 0.85 ELSE 0 END AS spositiontaking
--		,0 as playerdiscount
--		,0 as discount
--		,0 as adiscount
--		,0 as sdiscount
--		,0 as autopositiontaking
--		,0 as isautopositiontaking
--		,0 as autompositiontaking
--		,0 as isautompositiontaking
--FROM #BETTYPE a,#CustList b
--WHERE NOT EXISTS(SELECT 1 FROM CustSettingGame c WHERE b.CustID = c.CustID and c.Bettype in (select Bettype from #BETTYPE ) AND Sporttype = 202)
--order by Bettype,CustID

--INSERT INTO CustSettingGame(CustID,Bettype,Sporttype ,apositiontaking,mpositiontaking,spositiontaking,playerdiscount,discount,adiscount,sdiscount,autopositiontaking
--									,isautopositiontaking,autompositiontaking,isautompositiontaking)
--SELECT  CustID,Bettype,Sporttype ,apositiontaking,mpositiontaking,spositiontaking,playerdiscount,discount,adiscount,sdiscount,autopositiontaking
--		,isautopositiontaking,autompositiontaking,isautompositiontaking
-- FROM #CustSettingGame_Temp

--SELECT * from #CustSettingGame_Temp

DROP TABLE #CustGameType_Temp,#CustList
--,#BETTYPE ,#CustSettingGame_Temp

