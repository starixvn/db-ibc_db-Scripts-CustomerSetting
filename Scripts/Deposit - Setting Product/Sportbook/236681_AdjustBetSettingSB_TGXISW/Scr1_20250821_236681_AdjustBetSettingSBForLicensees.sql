/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250821@Tacy
	Task: Deposit - Adjust Sportsbook PHP minbet for TGXISW [RedmineID:#236681]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @target VARCHAR(20),
	 @CustList XML
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBSPARE','DBCUST','SITDBCUST','TESTDBCUST','DBSPARE1')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBSPARE','DBCUST','SITDBCUST','TESTDBCUST','DBSPARE1')) RETURN -- run at dbcust only
	
	IF OBJECT_ID('Dep_CustBetSettingGame_Member') IS NULL	
		RETURN

	CREATE TABLE #tbCustomer(
				 CustID	INT
				,MinBet MONEY
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

	INSERT INTO #tbCustomer (CustID, MinBet, Sporttype, Bettype)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@MinBet','MONEY')	AS MinBet
			,t.c.value('@SportType','SMALLINT')	AS SportType
			,t.c.value('@BetType','SMALLINT')	AS BetType
	FROM @CustList.nodes('root') t(c)

	UPDATE main
	SET main.minbet	= tmp.MinBet
	FROM dbo.Dep_CustBetSettingGame_Member main WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #tbCustomer tmp	ON main.CustID=tmp.CustID AND tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
	WHERE main.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)

	DROP TABLE #tbCustomer
END
GO
--End Step 1
------------------------------------------------------


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------

DECLARE @max_custid INT = xxx
		,@CustList  XML
		,@BatchSize	INT = 200

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE','DBSPARE1')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'	

Print 'Server Name : ' + @target

---------------------------------------------------------------------------------------------
DECLARE @tmpSetting TABLE (code VARCHAR(3), MinBet MONEY)
DECLARE @SportBettype TABLE (SportType SMALLINT
								,BetType SMALLINT)
INSERT INTO @tmpSetting(code,MinBet)
SELECT 'PHP', 10

INSERT INTO @SportBettype (SportType, BetType)
SELECT DISTINCT psd.SportType, psd.BetType
FROM Dep_ProductSetting ps WITH (NOLOCK)
INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK)
		ON ps.ProductSettingID=psd.ProductSettingID
WHERE ps.ProductID=1 AND ps.SettingType=10

---------------------------------------------------------------------------------------------
CREATE TABLE #Super(CustID INT PRIMARY KEY, MinBet MONEY)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT, MinBet MONEY)
CREATE TABLE #Members (CustID INT PRIMARY KEY, MinBet MONEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY, MinBet MONEY)

--supers
INSERT INTO #Super(custid, MinBet)
SELECT cs.custid, t.MinBet
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_Licensee.dbo.licensees l WITH(NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT t.MinBet
				FROM exchange e WITH(NOLOCK)
					INNER JOIN @tmpSetting t ON e.Code = t.Code
				WHERE cs.currency = e.ExchangeId
				)t
WHERE l.IsActive = 1 AND l.LicenseeName='TGXISW'
	
--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
INNER JOIN #Super s ON s.CustID=c.srecommend 
WHERE c.roleid=3 
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID, MinBet)
SELECT c.custid, c.roleid, s.MinBet
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend 
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1

--Members have individual settings only
INSERT INTO #Members (CustID, MinBet)
SELECT c.custid, s.MinBet
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend 
INNER JOIN Dep_CustSettingMode m WITH (NOLOCK) ON c.custid=m.CustID
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid <= @max_custid
	AND c.roleid = 1
	AND c.Enabled=1
	AND m.IsGroupedBetLimit=0
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @cnt INT = 0,
		@_cnt INT

SELECT @_cnt = COUNT(1)
FROM #SMAs

SELECT @_cnt += COUNT(1)
FROM #Members

DECLARE @msg nvarchar(200) = 'Currently at No. of Customers: %d'
DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @_cnt) WITH NOWAIT

--For SMA
--Update SMAs ON DBCUST and repl by in-house 
IF @Target = 'DBCUST'
BEGIN
	UPDATE main
		SET main.minbet	= tmp.MinBet
			,main.RepUpdateTime=dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSettingGame_Agent main WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #SMAs tmp	ON main.CustID=tmp.CustID
		CROSS APPLY (SELECT * FROM @SportBettype s 
					 WHERE s.SportType = main.sporttype 
					 AND s.BetType = main.bettype) sb
	WHERE main.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
		
	UPDATE main
		SET main.minbet	= tmp.MinBet
			,main.RepUpdateTime=dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSettingGameGroup_Member main WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #SMAs tmp	ON main.AgentID=tmp.CustID
		CROSS APPLY (SELECT * FROM @SportBettype s 
					 WHERE s.SportType = main.sporttype 
					 AND s.BetType = main.bettype) sb
	WHERE main.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
END

--For Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.MinBet
		INTO #tbCustomers_batch(CustID,MinBet)
	FROM #Members t 

	SELECT @_cnt = @@ROWCOUNT
	
	IF @_cnt = 0 
		BREAK;
	
	SELECT @cnt = @cnt + @_cnt
	
	RAISERROR (@msg, 0, 1,@cnt) WITH NOWAIT
	
	SELECT @CustList=(SELECT t.CustID	AS '@CustID' 
							,t.MinBet	AS '@MinBet'
							,s.SportType AS '@SportType'
							,s.BetType	AS '@BetType'
					FROM #tbCustomers_batch t
					CROSS APPLY (SELECT * FROM @SportBettype) s
					FOR XML PATH('root')
					)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList
	
	WAITFOR DELAY '00:00:0.050'
END		
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
