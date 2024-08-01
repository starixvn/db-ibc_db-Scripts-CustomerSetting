/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240731@Winfred
	Task: [All licensees] - Change Sportsbook minbet to 30 [Redmine: #208605]
	DB: DBCust/CustDB and all replicated servers 
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @target VARCHAR(20),
	 @CustList XML,
	 @mode	 TINYINT -- 1 ~ SMA, 2 ~ Member
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0
		)
		RETURN
	
	CREATE TABLE #tbCustomer( CustID	INT, RoleID TINYINT , PRIMARY KEY CLUSTERED (CustID))
	CREATE TABLE #SportBettypeFilter (ProductID TINYINT, Sporttype SMALLINT, Bettype SMALLINT)
	
	INSERT INTO #SportBettypeFilter (ProductID,SportType,Bettype)
	SELECT 1 AS ProductID, SportType, Bettype 
	FROM dbo.f_Dep_CustSetting_SportBetTypeSettingSelect(1,10,0)

	INSERT INTO #tbCustomer (CustID, RoleID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@RoleID','TINYINT')	AS RoleID
	FROM @CustList.nodes('root') t(c)

	IF @mode=1 --For SMA
	BEGIN
		UPDATE d
		SET d.minbet = 30 
		from #tbCustomer tmp
		CROSS APPLY #SportBettypeFilter s
		CROSS APPLY(SELECT top 15 minbet from Dep_CustBetSettingGame_Agent WITH(ROWLOCK)
					WHERE CustID = tmp.CustID AND SportType = s.Sporttype 
						AND BetType = s.Bettype AND MinBet < 30) d

		UPDATE d
		SET d.minbet = 30 
		from #tbCustomer tmp
		CROSS APPLY #SportBettypeFilter s
		CROSS APPLY(SELECT top 15 minbet from Dep_CustBetSettingGameGroup_Member WITH(ROWLOCK)
					WHERE AgentID = tmp.CustID AND SportType = s.Sporttype 
						AND BetType = s.Bettype AND MinBet < 30) d
		Where tmp.RoleID = 2
	END

	IF @mode=2 --For Member
	BEGIN
		UPDATE d
		SET d.minbet = 30 
		from #tbCustomer tmp
		CROSS APPLY #SportBettypeFilter s
		CROSS APPLY(SELECT top 15 minbet from Dep_CustBetSettingGame_Member WITH(ROWLOCK)
					WHERE CustID = tmp.CustID AND SportType = s.Sporttype 
						AND BetType = s.Bettype AND MinBet < 30) d
	END

	DROP TABLE #tbCustomer
	DROP TABLE #SportBettypeFilter
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
PRINT N'COPY SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   XML
		,@BatchSize	INT = 300
		,@srecommend INT

SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target
CREATE TABLE #Supers(CustID INT PRIMARY KEY, site VARCHAR(20))
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #SportBettypeFilter (ProductID TINYINT, Sporttype SMALLINT, Bettype SMALLINT)
---------------------------------------------------------------------------------------------
INSERT INTO #SportBettypeFilter (ProductID,SportType,Bettype)
SELECT 1 AS ProductID, SportType, Bettype 
FROM dbo.f_Dep_CustSetting_SportBetTypeSettingSelect(1,10,0)

INSERT INTO #Supers(custid, site)
SELECT cs.custid, cs.site
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
WHERE  l.IsActive = 1-- AND l.licenseeName IN ('Athena000')
	AND cs.username NOT LIKE '3rdSuper%'
	AND cs.currency = 51
	AND cs.custid <= @max_custid
	
--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
	INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
WHERE c.roleid=3 
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID)
SELECT c.custid, c.roleid
FROM dbo.CustInfo c WITH(NOLOCK)
	INNER JOIN #Supers s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1

--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
	INNER JOIN #Supers s ON s.CustID=c.srecommend
	CROSS APPLY(SELECT top 1 minbet FROM Dep_CustBetSettingGame_Member b WITH(NOLOCK) WHERE CustID = c.CustID ) d
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid = 1
	AND c.Enabled=1

---------------------------------------------------------------------------------------------
-- Update defaule bet limit 
UPDATE d 
SET d.MinBet = 30
FROM Dep_CustBetLimit_Special d WITH(UPDLOCK)
	INNER JOIN #SportBettypeFilter s ON s.Sporttype = d.SportType AND s.Bettype = d.Bettype
WHERE d.CurrencyID = 51 AND d.Site IN (Select DISTINCT Site from #Supers)
AND d.MinBet IS NOT NULL AND d.MinBet < 30

DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #SMAs

SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.RoleID
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #SMAs t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 1
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Agent - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END			
	
--For Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, 1
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #Members t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 2
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END		
	
PRINT N'--------------------------------------------------------'
PRINT N': End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #SMAs, #Members, #tbCustomers_batch, #Supers, #Dummy, #SportBettypeFilter
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
