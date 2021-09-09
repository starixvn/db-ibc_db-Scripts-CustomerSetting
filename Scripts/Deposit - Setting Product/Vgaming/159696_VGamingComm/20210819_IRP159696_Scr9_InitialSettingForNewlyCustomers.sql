/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210818@Johnson
	Task: initial comm setting for newly customers real licensees
	DB: DBCust/CustDB
*/
	DECLARE @max_custid BIGINT = xxx
	
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
	DECLARE @BatchCust TABLE (CustID INT)
	
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
							AND p.ProductID IN (66)
					WHERE  lp.CustID = cs.custid							
					)
					AS tmp (_sb)
	WHERE  l.IsActive = 1 AND l.licenseeName <> 'Athena000'

	IF @@ROWCOUNT = 0
		RETURN;
		
	INSERT INTO #tblCust(Custid,roleid)
	SELECT custid, roleid
	FROM dbo.CustInfo WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #Super)
		AND mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend IN (SELECT custid FROM #Super)
									AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
									AND roleid=3
							)
		AND custid > @max_custid
						
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
					SELECT 171 as Sporttype, 3801 as Bettype
			)sb
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID and dcs.SportType = sb.sporttype
			AND dcs.BetType = sb.bettype	
				
	WHERE roleid = 2 AND dcs.AgentID IS NULL
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (500) t
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
		WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
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
			CROSS APPLY (SELECT 171 as Sporttype, 3801 as Bettype									
						) AS tmp
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
				AND dcs_m.BetType = tmp.bettype	
																	
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
			
		DELETE @BatchCust
		
		WAITFOR DELAY '0:0:0.01'
	END
	
	DROP TABLE #tblCust
	DROP TABLE #Super
	