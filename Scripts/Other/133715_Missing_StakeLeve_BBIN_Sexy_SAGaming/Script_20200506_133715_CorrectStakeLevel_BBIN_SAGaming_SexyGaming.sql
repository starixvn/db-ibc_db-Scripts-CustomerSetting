/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200506@Eden
	Task: Correct missing data of StakeLevel of SA Gaming ,Sexy Gaming, BBIN [Redmine: 132323]
	DB: DBCUST/CustDB
*/
CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED,currency INT)
CREATE TABLE #MemberTempBatch(CustID	INT PRIMARY KEY CLUSTERED,currency INT)
CREATE TABLE #tmpSTListMember (BettypeID INT, Currency INT, StakeLevelList VARCHAR(500))
CREATE TABLE #SportBettype (SportType INT , Bettype INT)

INSERT INTO #SportBettype (SportType,Bettype)
SELECT 244,3001 --SA Gaming 
UNION ALL SELECT 243,3101 --Sexy Gaming
UNION ALL SELECT 241,3300 --BBIN

--List member wrong StakeLevel
INSERT INTO #MemberTemp (CustID, currency)
SELECT custid, currency
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  
	AND Enabled = 1 
	AND custid IN (
					42675447
					,42675469
					,42675496
					,42675511
					,42675830
					,42488781
					,42488941
					,42489093
					,42489608
					,42489630
					,42489652
					,42489826
					,42489835
					,42490285
					,42490303
					,42490316
					,42490321
					,42490343
					,42490391
					,42490405
					,42490534
					,42487950
					,42487979
					,42488062
					,42488781
					,42488941
					,42489093
					,42489608
					,42489630
					,42489652
					,42489826
					,42489835
					,42490285
					,42490303
					,42490316
					,42490321
					,42490343
					,42490534
					)

INSERT INTO #tmpSTListMember(BettypeID, Currency, StakeLevelList)
SELECT DISTINCT ST.GameTypeID,currency, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
FROM #MemberTemp M CROSS JOIN StakeLevel ST 
CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=M.currency
			FOR XML PATH ('') ) AS A(STL)
WHERE ST.GameTypeID IN (SELECT Bettype from #SportBettype) 
ORDER BY ST.GameTypeID


WHILE EXISTS(SELECT 1 FROM #MemberTemp)
BEGIN
	DELETE TOP (3000) #MemberTemp OUTPUT DELETED.* INTO #MemberTempBatch

	IF @@ROWCOUNT=0
	BREAK		

	DELETE c
	FROM CustStakeLevel_Member c WITH(ROWLOCK)
		INNER JOIN #MemberTempBatch m ON c.CustID = m.CustID
		INNER JOIN #SportBettype tmp On tmp.SportType = c.SportType AND tmp.Bettype = c.BetType


	INSERT INTO dbo.CustStakeLevel_Member([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]
										,LastUpdated) 
	SELECT DISTINCT t.custid,MAX(sb.SportType),TB.BettypeID, CAST(MIN(StakeLevelID) AS varchar(50)),GETDATE()
	FROM StakeLevel S WITH(NOLOCK) 
		INNER JOIN #tmpSTListMember TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID AND S.ExchangeId = TB.Currency
		INNER JOIN  #SportBettype sb ON tb.BettypeID =sb.Bettype
		CROSS JOIN  #MemberTempBatch t
	WHERE S.ExchangeId=t.currency
	GROUP BY t.custid, TB.BettypeID

	TRUNCATE TABLE #MemberTempBatch
END

DROP TABLE #MemberTemp
DROP TABLE #SportBettype
DROP TABLE #MemberTempBatch
DROP TABLE #tmpSTListMember