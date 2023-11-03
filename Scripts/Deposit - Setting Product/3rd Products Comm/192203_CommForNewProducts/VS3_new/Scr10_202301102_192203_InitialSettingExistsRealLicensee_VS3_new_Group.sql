/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231102@Tacy
	Task: Update VS3 (old) 's sport/bettype to VS3 (new) 's sport/bettype for real Licensee
	DB: DBCust/CustDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @CustList XML,
 	 @target VARCHAR(20),
	 @mode	 TINYINT -- 1 ~ Agent, 2 ~ Member
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0)
		RETURN
	
	DECLARE @Sporttype SMALLINT, @Bettype INT

	SELECT  @Sporttype=178, @Bettype=5302

	CREATE TABLE #Customers_batch (
					CustID INT, 
					Sporttype SMALLINT DEFAULT(231), 
					Bettype INT DEFAULT(5301),
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)
	
	INSERT INTO #Customers_batch (CustID, Sporttype, Bettype)
	SELECT   t.c.value('@CustID','INT')			AS CustID
			,t.c.value('@Sporttype','SMALLINT')	AS Sporttype
			,t.c.value('@Bettype','INT')		AS Bettype
	FROM @CustList.nodes('root') t(c)

	IF @mode=1
	BEGIN
		UPDATE dcs 
		SET dcs.SportType=@Sporttype, dcs.BetType=@Bettype
		FROM dbo.Dep_CustDiscountGroupSetting_Member dcs WITH (UPDLOCK,ROWLOCK)
		INNER JOIN #Customers_batch t ON t.CustID=DCS.AgentID
									AND t.Sporttype=dcs.SportType
									AND t.Bettype=dcs.BetType
		OUTER APPLY (SELECT TOP 1 1 AS VAL
					 FROM Dep_CustDiscountGroupSetting_Member d WITH (NOLOCK)
					 WHERE d.AgentID=t.CustID
						AND d.SportType=@Sporttype AND d.BetType=@Bettype) d
		WHERE d.VAL IS NULL
	END
END
GO

--------------------------------------------------------------------------------------
---
---
--------------------------------------------------------------------------------------
DECLARE @max_custid INT
	   ,@CustList   XML

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Super (CustID INT PRIMARY KEY)

CREATE TABLE #Agents (CustID INT PRIMARY KEY)

CREATE TABLE #Customers_batch (
					CustID INT, 
					Sporttype SMALLINT DEFAULT(231), 
					Bettype INT DEFAULT(5301),
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

SELECT @max_custid = 101576345
---------------------------------------------------------------------------------------------
INSERT INTO #Super(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 
						AND p.ProductID IN (77)
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1 AND l.licenseeName NOT IN ('Athena000')

--Agents
INSERT INTO #Agents (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend
OUTER APPLY (SELECT TOP 1 1 AS val
			 FROM Dep_CustDiscountGroupSetting_Member d WITH (NOLOCK)
			 WHERE d.AgentID=c.custid AND d.SportType=178 and d.BetType=5302) d
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND c.custid <= @max_custid
	AND c.roleid=2
	AND d.val IS NULL

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #Agents

DECLARE @msg_total NVARCHAR(200) = 'Total of Existing Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--Update for Agent
WHILE (1 = 1)
BEGIN
	DELETE FROM #Customers_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID
		INTO #Customers_batch(CustID)
	FROM #Agents t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID		AS '@CustID', 
							 Sporttype	AS '@Sporttype',
							 Bettype	AS '@Bettype'
					  FROM #Customers_batch
					  FOR XML PATH('root')
					 )

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@CustList=@CustList,
				@target = @target,
				@mode = 1
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Agent - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END			
	
DROP TABLE #Agents, #Customers_batch, #Super
GO