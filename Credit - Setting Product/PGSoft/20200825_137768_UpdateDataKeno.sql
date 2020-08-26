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
-- show data old
SELECT a.*
FROM   CustGameType  a 
INNER JOIN #CustList b on a.CustID = b.CustID
where a.GameTypeID in (select GameTypeID from  @GameType )
-- delete data old
Delete a
FROM   CustGameType  a 
INNER JOIN #CustList b on a.CustID = b.CustID
where a.GameTypeID in (select GameTypeID from  @GameType )


-- Insert List
INSERT INTO #CustGameType_Temp (CustID,GameTypeID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled)  
SELECT  b.CustID 
		,a.GameTypeID
		,0 as StakeLevelList
		,0 as MaxPerGameType
		,0 as MinBet
		,0 as MaxBet
		,0 as IsDisabled
FROM @GameType a,#CustList b
WHERE NOT EXISTS(SELECT 1 FROM CustGameType c WHERE b.CustID = c.CustID and c.GameTypeID in (select GameTypeID from  @GameType ))



INSERT INTO CustGameType(GameTypeID,CustID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled)
SELECT  GameTypeID,CustID,StakeLevelList,MaxPerGameType,MinBet,MaxBet,IsDisabled FROM #CustGameType_Temp
SELECT * from #CustGameType_Temp

DROP TABLE #CustGameType_Temp,#CustList 