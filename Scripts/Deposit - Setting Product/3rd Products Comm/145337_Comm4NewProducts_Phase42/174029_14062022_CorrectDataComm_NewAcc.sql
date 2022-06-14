/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220614@Winfred
	Task: Adjust HF LAP - Licensee Commission Group - Player discount don't update when user update Group Comm  [Redmine: #174029]   
	DB: DBCUST/CUSTDB

	Notes: 
	ProductID	SportType	BetType	ProductName
	49			231			5301	Virtual Sports 3
	62			167			7301	CG
	67			172			7701	AdvantPlay
	68			174			7801	AdvantPlay Mini
*/
	DECLARE @max_custid BIGINT = xxx
	DECLARE @Max_Custid2 INT

	SELECT TOP(1) @Max_Custid2 = custid FROM custinfo WITH(NOLOCK) ORDER BY custid DESC

	CREATE TABLE #CustComm_temp (CustID INT, recommend INT,CGComm DECIMAL(9,8),AdvantComm DECIMAL(9,8),AdvantMiniComm DECIMAL(9,8),VS3Comm DECIMAL(9,8))	
	DECLARE @CustComm_TempBatch TABLE (CustID INT, recommend INT,CGComm DECIMAL(9,8),AdvantComm DECIMAL(9,8),AdvantMiniComm DECIMAL(9,8),VS3Comm DECIMAL(9,8))
	
	CREATE TABLE #SporttypeBettype (Sporttype INT, Bettype INT)
	INSERT INTO #SporttypeBettype (Sporttype, Bettype)
	SELECT 231 as Sporttype, 5301 as Bettype UNION ALL -- 	Virtual Sports 3								
	SELECT 167 as Sporttype, 7301 as Bettype UNION ALL -- 	CG
	SELECT 172 as Sporttype, 7701 as Bettype UNION ALL -- 	AdvantPlay
	SELECT 174 as Sporttype, 7801 as Bettype		   -- 	AdvantPlay Mini

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
							AND p.ProductID IN (49, 62, 67, 68)
					WHERE  lp.CustID = cs.custid							
					)
					AS tmp (_sb)
	WHERE  l.IsActive = 1 AND l.LicenseeID = 19

	IF @@ROWCOUNT = 0
		RETURN;
	
	INSERT INTO #CustComm_temp(CustID,recommend,CGComm,AdvantComm,AdvantMiniComm,VS3Comm)
	SELECT co.custid,ci.recommend,co.CGComm,co.AdvantComm,co.AdvantMiniComm,co.VS3Comm
	FROM bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
		INNER JOIN Custinfo ci WITH(NOLOCK) ON co.CustID = ci.custid
	WHERE LicenseeID = 19    -- Macau
		AND ci.srecommend IN (SELECT custid FROM #Super) 
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND ci.mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend IN (SELECT custid FROM #Super)
									AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
									AND roleid=3
							)
		AND ci.custid > @max_custid AND ci.custid <= @Max_Custid2
	
	WAITFOR DELAY '00:00:30'					
			
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) c 
		OUTPUT DELETED.CustID,deleted.recommend,deleted.CGComm,deleted.AdvantComm,deleted.AdvantMiniComm,deleted.VS3Comm 
		INTO @CustComm_TempBatch(CustID,recommend,CGComm,AdvantComm,AdvantMiniComm,VS3Comm)
		FROM #CustComm_temp c 
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE cs
		SET isGroupedComm = 0
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @CustComm_TempBatch cb 
				ON cb.CustID = cs.CustID
			CROSS APPLY (SELECT Sporttype, Bettype
							FROM #SporttypeBettype				
							) AS tmp
			INNER JOIN Dep_CustDiscountGroupSetting_Member gr WITH(NOLOCK)
				ON cb.recommend = gr.AgentID
				AND gr.SportType = tmp.Sporttype
				AND gr.BetType = tmp.Sporttype
		WHERE cs.IsGroupedComm = 1
			AND ((cb.CGComm <> gr.PlayerDiscount AND gr.SportType = 167 and gr.BetType = 7301) -- CG Comm
				OR (cb.AdvantComm <> gr.PlayerDiscount AND gr.SportType = 172 and gr.BetType = 7701) -- Advant Comm
				OR (cb.AdvantMiniComm <> gr.PlayerDiscount AND gr.SportType = 174 and gr.BetType = 7801) -- AdvantMini Comm
				OR (cb.VS3Comm  <> gr.PlayerDiscount AND gr.SportType = 231 and gr.BetType = 5301 )) -- VS3 Comm

		--> insert comm on private tables if not exists (get all sport offered from agent)
		INSERT INTO Dep_CustDiscountSetting_Member (
			CustID
			,SportType
			,BetType
			,PlayerDiscount
			,AgentDiscount
			,MasterDiscount
			,SuperDiscount
		)
		SELECT c.CustID, ag.Sporttype, ag.BetType,ag.PlayerDiscount,ag.AgentDiscount,ag.MasterDiscount,ag.SuperDiscount
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN @CustComm_TempBatch cb 
				ON c.CustID = cb.CustID
			CROSS APPLY (SELECT Sporttype, Bettype
							FROM #SporttypeBettype				
							) AS tmp
			INNER JOIN Dep_CustDiscountGroupSetting_Member ag WITH(NOLOCK)
				ON cb.recommend = ag.AgentID AND ag.SportType = tmp.Sporttype AND ag.BetType = tmp.Bettype
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID 
				and dcs_m.SportType = ag.Sporttype
				AND dcs_m.BetType = ag.BetType			
		WHERE c.IsGroupedComm = 0 
			AND dcs_m.custid IS NULL
	
		--> UpdatePlayer comm on private Tables (insert if not exist)
		UPDATE dcs_m
		SET dcs_m.PlayerDiscount = CASE WHEN dcs_m.SportType = 167 and dcs_m.BetType = 7301  THEN cb.CGComm
										WHEN dcs_m.SportType = 172 and dcs_m.BetType = 7701  THEN cb.AdvantComm
										WHEN dcs_m.SportType = 174 and dcs_m.BetType = 7801  THEN cb.AdvantMiniComm
										WHEN dcs_m.SportType = 231 and dcs_m.BetType = 5301  THEN cb.VS3Comm
									ELSE dcs_m.PlayerDiscount END
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN @CustComm_TempBatch cb 
				ON c.CustID = cb.CustID
			CROSS APPLY (SELECT Sporttype, Bettype
							FROM #SporttypeBettype				
							) AS tmp
			INNER JOIN Dep_CustDiscountSetting_Member dcs_m WITH (ROWLOCK,UPDLOCK) 
				ON dcs_m.CustID = c.CustID 
				and dcs_m.SportType = tmp.Sporttype
				AND dcs_m.BetType = tmp.Bettype			
		WHERE c.IsGroupedComm = 0
			
		DELETE FROM @CustComm_TempBatch
	END
	
	DROP TABLE #CustComm_temp
	DROP TABLE #SporttypeBettype
	DROP TABLE #Super
	
