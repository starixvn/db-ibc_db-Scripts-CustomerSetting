/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230807@Tacy
	Task: initial comm setting for YeeBet, MG-RnG for Athena000
	DB: DBCust/CustDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @target VARCHAR(20),
	 @mode	 TINYINT -- 1 ~ Agent, 2 ~ Member	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0		
		)
	RETURN
	
	CREATE TABLE #tmp(CustID INT PRIMARY KEY)

	IF @mode=1
	BEGIN
		--insert group comm setting
		INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
			(AgentID
			,SportType
			,BetType
			,PlayerDiscount
			,AgentDiscount
			,MasterDiscount
			,SuperDiscount		
			)
		SELECT t.custid, t.Sporttype, t.Bettype, 0, 0, 0, 0
		FROM #Customers_batch t	
			LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
				ON dcs.AgentID = t.CustID 
				AND dcs.SportType = t.sporttype
				AND dcs.BetType = t.bettype	
		WHERE dcs.AgentID IS NULL
	END

	IF @mode=2
	BEGIN
		--get: cust have not offered comm yet
		INSERT INTO #tmp(custid)
		SELECT DISTINCT cs.custid
		FROM dbo.Dep_CustSettingMode cs WITH(NOLOCK)
				INNER JOIN #Customers_batch t ON t.CustID = cs.CustID
				OUTER APPLY (SELECT TOP 1 dcs_m.CustID 
							 FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
							 WHERE dcs_m.CustID = cs.CustID
							) AS tmp
		WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
		-- UPDATE comm group for cust have not offered comm yet.
		UPDATE cs
			SET isGroupedComm = 1
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tmp cb ON cb.CustID = cs.CustID
			OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
							WHERE dcs_m.CustID = cs.CustID
						) AS tmp
		WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
		-- insert private setting if already offered comm before and not belong to comm group
		DELETE #tmp
	
		INSERT INTO #tmp(custid)
		SELECT DISTINCT c.CustID
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN #Customers_batch t ON c.CustID = t.CustID
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID 
				AND dcs_m.SportType = t.sporttype
				AND dcs_m.BetType = t.bettype	
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
	
		INSERT INTO Dep_CustDiscountSetting_Member (CustID
							,SportType
							,BetType
							,PlayerDiscount
							,AgentDiscount
							,MasterDiscount
							,SuperDiscount)  	
		SELECT c.CustID, cb.sporttype, cb.bettype, 0,0,0,0
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN #tmp t ON t.CustID=c.CustID
			INNER JOIN #Customers_batch cb ON t.CustID = cb.CustID
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID and dcs_m.SportType = cb.sporttype
				AND dcs_m.BetType = cb.bettype	
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
	END

	DROP TABLE #tmp
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Super(CustID INT)

CREATE TABLE #SuperSportBettype (
					CustID INT,
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

CREATE TABLE #Agents (
					CustID INT, 
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

CREATE TABLE #Members (
					CustID INT, 
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

CREATE TABLE #Customers_batch ( 
					CustID INT, 
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

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
						AND p.ProductID IN (73,76)
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1 AND l.licenseeName IN ('Athena000')

INSERT INTO #SuperSportBettype (CustID, Sporttype, Bettype)
SELECT DISTINCT s.CustID, pd.SportType, pd.BetType
FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
	INNER JOIN #Super s ON s.CustID=lp.CustID
	INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
	INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID 
WHERE p.SettingType = 4
	AND p.ProductID IN (73,76)

--Agents
INSERT INTO #Agents (CustID, Sporttype, Bettype)
SELECT c.custid, s.Sporttype, s.Bettype
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #SuperSportBettype s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND c.custid <= @max_custid
	AND c.roleid=2

--Members
INSERT INTO #Members (CustID, Sporttype, Bettype)
SELECT c.custid, s.Sporttype, s.Bettype
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #SuperSportBettype s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND c.custid <= @max_custid
	AND c.roleid=1
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #Agents

SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--Update for Agent
WHILE (1 = 1)
BEGIN
	DELETE FROM #Customers_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID, deleted.Sporttype, deleted.Bettype
		INTO #Customers_batch(CustID,Sporttype, Bettype)
	FROM #Agents t 

	IF @@ROWCOUNT = 0 BREAK
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@mode = 1
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Agent - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END			
	
--Update for Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #Customers_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID, deleted.Sporttype, deleted.Bettype
		INTO #Customers_batch(CustID,Sporttype, Bettype)
	FROM #Members t 

	IF @@ROWCOUNT = 0 BREAK
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@mode = 2
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END		
	
DROP TABLE #Agents, #Members, #Customers_batch, #Super, #SuperSportBettype
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
