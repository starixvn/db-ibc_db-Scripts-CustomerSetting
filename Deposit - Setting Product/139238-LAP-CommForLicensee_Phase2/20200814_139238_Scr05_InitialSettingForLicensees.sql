/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBCUST/CustDB
	
	1.SEXY GAMING
	2.SpadeGaming
	3.Keno (non DCS)
	4.Lottery
	5.Virtual Sport
	6.Virtual Sport 2
	7.Table Game
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_08]
 	 @srecommend	INT
	, @max_custid INT
	, @target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0		 		 
		OR dbo.f_CheckRepTable('CustInfo') = 0
		)
	RETURN
	
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
	DECLARE @BatchCust TABLE (CustID INT)

	CREATE TABLE #SporttypeBettype (Sporttype INT, Bettype INT)
	INSERT INTO #SporttypeBettype (Sporttype, Bettype)
	SELECT DISTINCT pd.SportType, pd.BetType
	FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
		INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
		INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID 
	WHERE lp.CustID = @srecommend
		AND p.SettingType = 4
		AND p.ProductID IN (28,45,36,40,5,27) 
		
	INSERT INTO #tblCust(Custid,roleid)
	SELECT custid, roleid
	FROM dbo.CustInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend 
		AND mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend=@srecommend 
									AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
									AND roleid=3
							)
		AND custid <= @max_custid
						
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
	SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0
	FROM #tblCust t	
		CROSS APPLY (
					SELECT Sporttype, Bettype
					FROM #SporttypeBettype
			)sb
	WHERE roleid = 2
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT deleted.custid INTO @BatchCust
		FROM #tblCust t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		-- UPDATE comm group for cust have not offered comm yet.
		UPDATE cs
			SET isGroupedComm = 1
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @BatchCust cb ON cb.CustID = cs.CustID
			OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
						WHERE dcs_m.CustID = cs.CustID
						) AS tmp
		WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NOT NULL
		
		-- insert private setting if already offered comm before and not belong to comm group
		INSERT INTO Dep_CustDiscountSetting_Member (CustID
							,SportType
							,BetType
							,PlayerDiscount
							,AgentDiscount
							,MasterDiscount
							,SuperDiscount)  	
		SELECT c.CustID, tmp.sporttype, tmp.bettype, 0,0,0,0
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN @BatchCust cb ON c.CustID = cb.CustID
			CROSS APPLY (SELECT  220 AS sporttype,	1021 bettype -- Lottery
						--UNION ALL SELECT  202,	1501--RNG Keno
						UNION ALL SELECT  243,	3101--Sexy Gaming
						UNION ALL SELECT  247,	4301--SG
						UNION ALL SELECT  222,	4901--Table Game
						UNION ALL SELECT  180,	1201 --VS
						UNION ALL SELECT  190,	2701 --VS 2
						) as tmp
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
															AND dcs_m.BetType = tmp.bettype	
																	
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
			
		DELETE @BatchCust
	END
	
	DROP TABLE #tblCust
	DROP TABLE #SporttypeBettype
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, 
		@max_custid INT


CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID AND p.SettingType = 4 
						AND p.ProductID IN (28,45,36,40,5,27) 
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1 

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) -----
-----------------------------------------------------------------------------------	


---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, 
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID AND p.SettingType = 4 
						AND p.ProductID IN (28,45,36,40,5,27) 
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1 

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------