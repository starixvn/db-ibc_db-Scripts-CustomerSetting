/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250716@Tacy
	Task: [Haifa] - Adjust maxbet & maxpermatch for Virtual Sports[Redmine: #232298]
	DB: DBCust/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@Target VARCHAR(20),
	@CustList XML
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
		
	IF (
		OBJECT_ID('Dep_CustBetSetting_Agent') IS NULL				
		OR OBJECT_ID('Dep_CustBetSetting_Member') IS NULL	
		OR OBJECT_ID('customer') IS NULL
		)
		RETURN

	DECLARE @SportType		SMALLINT = 9908
			,@betType		SMALLINT = 1201
			,@MaxBet		MONEY = 3000
			,@MaxPerMatch	MONEY = 10000
			,@MinBet		MONEY = 10
	
	CREATE TABLE #tblCust(CustID	INT PRIMARY KEY)
	
	INSERT INTO #tblCust(CustID)
	SELECT   t.c.value('@CustID','INT')		AS CustID			
	FROM @CustList.nodes('root') t(c)
	
	UPDATE cs
	SET cs.MaxBet = @MaxBet,
		cs.MaxPerMatch = @MaxPerMatch,
		cs.MinBet = @MinBet
	FROM dbo.Dep_CustBetSetting_Member cs WITH(ROWLOCK, UPDLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust)
		AND SportType = @SportType
		AND Bettype = @Bettype
	
	DROP TABLE #tblCust	
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
SET NOCOUNT ON;

DECLARE @target VARCHAR(20)
		,@max_custid	INT
		,@CustList		XML
		,@BatchSize		INT = 2000
		,@srecommend	INT = 4359240 -- HAIFASuperRMB
		
SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #BatchCust (CustID INT PRIMARY KEY)

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
WHERE c.roleid=3 
	AND c.srecommend = @srecommend	
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1
	
--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND c.roleid = 1
	AND c.Enabled=1
	AND (c.username not like '%ClearBal' and c.username not like '%CashOut' and c.username not like '%OddsAdj' and c.username not like '%OddsBoostAdj')

DECLARE @SportType SMALLINT = 9908,@betType SMALLINT = 1201
	
--Update SMAs ON DBCUST and repl by in-house 
IF @Target = 'DBCUST'
BEGIN
	--3rows affects
	UPDATE cs
	SET cs.MaxBet	= 3000,
		cs.MaxPerMatch = 10000,
		cs.MinBet = 10,
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSetting_Agent cs WITH(ROWLOCK, UPDLOCK)
	WHERE custid IN (SELECT custid FROM #SMAs)
		AND SportType = @SportType
		AND Bettype = @Bettype
END

DECLARE @msg nvarchar(200) = 'Currently at No. of Customers: %d'
DECLARE @msg_total nvarchar(200) = 'Total of members: %d.'
DECLARE @cnt INT = 0,
		@_cnt INT

SELECT @_cnt = COUNT(1) FROM #Members

RAISERROR (@msg_total, 0, 1, @_cnt) WITH NOWAIT
	
--For Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #BatchCust

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID
		INTO #BatchCust(CustID)
	FROM #Members t 

	SELECT @_cnt = @@ROWCOUNT
	
	IF @_cnt = 0 
		BREAK;
	
	SELECT @cnt = @cnt + @_cnt
	
	RAISERROR (@msg, 0, 1,@cnt) WITH NOWAIT
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 							
					FROM #BatchCust
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList
	
	WAITFOR DELAY '00:00:0.020'
END		

DROP TABLE #Dummy
DROP TABLE #SMAs
DROP TABLE #Members
DROP TABLE #BatchCust

GO
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
