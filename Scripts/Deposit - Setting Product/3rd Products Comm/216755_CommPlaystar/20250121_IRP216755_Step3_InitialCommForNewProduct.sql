/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250121@Johnson
	Task: Init Comm Setting for Playstar [redmine: #216755]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT
	,@max_custid INT
	,@target VARCHAR(30) =''	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
		
	IF( dbo.f_CheckRepTable('CustInfo') = 0	
		--OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0			
		--OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0	
		--OR dbo.f_CheckRepTable('Dep_CustSettingMode') = 0			
	   )
	RETURN
	
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
	CREATE TABLE #tmp(CustID INT PRIMARY KEY)
	DECLARE @BatchCust TABLE (CustID INT)
	
	INSERT INTO #tblCust(Custid,roleid)
	SELECT custid, roleid
	FROM dbo.CustInfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend 
		AND mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend=@srecommend 
									AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
									AND roleid=3
							)
		AND (ci.username not like '%ClearBal' and ci.username not like '%CashOut' and ci.username not like '%OddsAdj' and ci.username not like '%OddsBoostAdj')
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
		,RepUpdateTime
		)
	SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0, NULL
	FROM #tblCust t	
		CROSS APPLY (
					SELECT 143 Sporttype, 11600 Bettype										
			)sb
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID 
				AND dcs.SportType = sb.sporttype
				AND dcs.BetType = sb.bettype
	WHERE roleid = 2 AND dcs.AgentID IS NULL	
	
	INSERT INTO #tmp(custid)
	SELECT cs.custid
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t ON t.CustID = cs.CustID
			OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
						 WHERE dcs_m.CustID = cs.CustID
							AND dcs_m.SportType IN (143)
						) AS tmp
	WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		AND t.roleid = 1
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT deleted.custid INTO @BatchCust(custid)
		FROM #tmp t		
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		INSERT INTO Dep_CustDiscountSetting_Member (CustID
							,SportType
							,BetType
							,PlayerDiscount
							,AgentDiscount
							,MasterDiscount
							,SuperDiscount
							,RepUpdateTime)  	
		SELECT c.CustID, tmp.sporttype, tmp.bettype,0,0,0,0, NULL
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN @BatchCust cb ON c.CustID = cb.CustID
			CROSS APPLY (SELECT 143 Sporttype, 11600 Bettype																				
						) AS tmp
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
				AND dcs_m.BetType = tmp.bettype	
																	
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
		
		DELETE @BatchCust			
	END	
	
	DROP TABLE #tblCust
	DROP TABLE #tmp
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------

DECLARE @srecommend INT, 
		@max_custid INT = xxx

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Super(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
					INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 
						AND p.ProductID IN (91)
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1


DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #super)

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = @target
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	

