/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230721
	Task: [NAP/Alpha] New Account Missing Bet Setting Bitcoin
		https://nexdev.net/issues/191556
	DB: DBCust-CustDB
*/ 
CREATE TABLE #Agents (CustID INT PRIMARY KEY CLUSTERED, mrecommend INT)

CREATE TABLE #Members ( CustID INT PRIMARY KEY CLUSTERED, recommend INT)

CREATE TABLE #tbCustomer_batch (CustID INT PRIMARY KEY CLUSTERED,
								mrecommend INT NULL,
								recommend INT NULL
								)

DECLARE @releasedDate DATETIME,
		@cnt INT

SET @releasedDate='2023-07-18 10:00:00'	--VN time

--convert to server time
SELECT @releasedDate=DATEADD(MINUTE,-1,(DATEADD(HOUR,-11,@releasedDate)))

SELECT @releasedDate

--------------------------------------------------------------
INSERT INTO #Agents(CustID, mrecommend)
SELECT c.custid, c.mrecommend
FROM Customer c WITH (NOLOCK)
OUTER APPLY (SELECT TOP 1 CUSTID 
			 FROM CustBetSetting3rd_Agent ag WITH (NOLOCK)
			 WHERE ag.CustID=c.custid AND SportType=175) ag
WHERE ag.CustID IS NULL AND c.roleid=2
AND c.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
AND creatdate>=@releasedDate 

INSERT INTO #Members(CustID, recommend)
SELECT c.custid, c.recommend
FROM Customer c WITH (NOLOCK)
OUTER APPLY (SELECT TOP 1 CUSTID 
			 FROM CustBetSetting3rd_Member m WITH (NOLOCK)
			 WHERE m.CustID=c.custid AND SportType=175) m
WHERE m.CustID IS NULL AND c.roleid=1
AND c.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
AND creatdate>=@releasedDate 

--------------------------------------------------------------
SELECT @cnt=COUNT(1)
FROM #Agents

SELECT @cnt+=COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT

--------------------------------------------------------------
--Insert Bitcoin' Bet Setting
--SMA
WHILE (1=1)
BEGIN
	DELETE FROM #tbCustomer_batch

	DELETE TOP (3000) FROM #Agents
	OUTPUT deleted.CustID, deleted.mrecommend
	INTO #tbCustomer_batch(CustID, mrecommend)

	IF @@ROWCOUNT=0	BREAK;

	INSERT INTO CustBetSetting3rd_Agent([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
	SELECT t.[CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch]
	FROM CustBetSetting3rd_Agent ag WITH (NOLOCK)
	CROSS APPLY (SELECT CustID, mrecommend FROM #tbCustomer_batch) t
	WHERE SportType=175
	AND ag.CustID = t.mrecommend

	WAITFOR DELAY '00:00:0.001'
END

--Memeber
WHILE (1=1)
BEGIN
	DELETE FROM #tbCustomer_batch

	DELETE TOP (3000) FROM #Members
	OUTPUT deleted.CustID, deleted.recommend 
	INTO #tbCustomer_batch(CustID,recommend)

	IF @@ROWCOUNT=0	BREAK;

	INSERT INTO CustBetSetting3rd_Member([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
	SELECT t.[CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch]
	FROM CustBetSetting3rd_Agent ag WITH (NOLOCK)
	CROSS APPLY (SELECT CustID, recommend FROM #tbCustomer_batch) t
	WHERE ag.CustID=t.recommend AND SportType=175

	WAITFOR DELAY '00:00:0.001'
END
GO