/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230919
	Task: [ug396] - Adjust Sportsbook betlimit for subsidiary "3mplay & 3mplay2" RedmineID:#194046
	DB: DBCUST/CustDB
	Step 2 : update betlimit for new acc
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	(@maxcustID INT)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT ,SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY,isfinished BIT DEFAULT(0), PRIMARY KEY CLUSTERED (CustID,SportType,BetType))
	CREATE TABLE #CustListTemp (CustID INT ,SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY, PRIMARY KEY CLUSTERED (CustID,SportType,BetType))
	DECLARE  @SportBetType	TABLE (SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY)
		
	DECLARE @batch SMALLINT = 300, @srecommend INT
	SET @srecommend = 44521396 --ug396SuperIN

	INSERT INTO @SportBetType(SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch) --15 row
	SELECT SportType, BetType ,  15 AS MinBet, 25000 AS MaxBet,50000 AS MaxPerMatch, 400000 AS MaxPayoutPerMatch
	FROM Dep_ProductSetting a WITH(NOLOCK)
	INNER JOIN Dep_ProductSettingDetail b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE ProductID = 1 AND SettingType = 10 AND SettingStatus = 0
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #CustList(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT c.custid,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch
	FROM Customer c WITH (NOLOCK)
		INNER JOIN custinfo ci WITH (NOLOCK) on c.custid = ci.custid
		LEFT JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.custid = m.CustID
		CROSS APPLY @SportBetType b
	WHERE c.srecommend = @srecommend AND c.roleid = 1  AND Enabled = 1 AND c.custid > @maxcustID	
	AND c.mrecommend NOT IN (SELECT custid FROM #Dummy) AND ISNULL(m.IsGroupedBetLimit,0) = 0
	AND c.recommend in(62325561,47778984) -- 3mplay2, 3mplay
	AND c.currency = 15 

	WHILE(1 = 1)
	BEGIN
			
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID, DELETED.SportType, DELETED.BetType, DELETED.MinBet, DELETED.MaxBet, DELETED.MaxPerMatch , DELETED.MaxPayoutPerMatch
		INTO #CustListTemp(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
		FROM #CustList c 
		WHERE isfinished = 0
			
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		UPDATE dca 
		SET dca.MinBet= KQ.MinBet,
			dca.MaxBet= KQ.MaxBet,
			dca.MaxPerMatch= KQ.MaxPerMatch,
			dca.MaxPayoutPerMatch= KQ.MaxPayoutPerMatch
		FROM Dep_CustBetSettingGame_Member dca WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #CustListTemp KQ ON KQ.CustID =  dca.CustID AND KQ.SportType = dca.sporttype AND KQ.BetType = dca.bettype
		
		TRUNCATE TABLE #CustListTemp
	END 	
	
	DROP TABLE #Dummy
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID

