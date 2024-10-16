/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241024@Johnson
	Task: Fix comm Jili for Macaubet[RedmineID:#212146]
	DB: DBCUST/CustDB
*/

DECLARE @LicenseeID INT,
	@SportType INT = 158,
	@Bettype INT = 5100,
	@max_custid INT = xxx,
	@srecommend INT
	
SELECT @LicenseeID = LicenseeID 
FROM bodb_Licensee.dbo.Licensees WITH(NOLOCK)
WHERE licenseeName = 'Macaubet'		
	
--6 rows affected
INSERT INTO dbo.Dep_LicenseeProductSetting(CustID,ProductSettingID,RepUpdateTime)
SELECT s.custid, t.ProductSettingID, dbo.f_GetDateTime2()
FROM dbo.Dep_CustSuper s WITH(NOLOCK)
	CROSS APPLY(	SELECT 164 AS ProductSettingID, 75 AS ProductID							
				) t
	CROSS APPLY (SELECT TOP 1 lp.CustID 
				FROM Dep_LicenseeProductSetting lp WITH (NOLOCK) 
					INNER JOIN Dep_ProductSetting pd WITH (NOLOCK) ON pd.ProductSettingID = lp.ProductSettingID
				WHERE lp.CustID = s.custid AND pd.SettingType = 4
					AND pd.ProductID = t.ProductID
				) AS p_tmp
			
	LEFT JOIN Dep_LicenseeProductSetting p WITH(NOLOCK) 
		ON p.custid = s.custid
		AND p.ProductSettingID = t.ProductSettingID
WHERE p.custid IS NULL							
	AND s.site = 'Macaubet'

CREATE TABLE #Supers(CustID INT PRIMARY KEY, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #tmp(CustID INT PRIMARY KEY, Discount DECIMAL(9,8))
DECLARE @BatchCust TABLE (CustID INT, Discount DECIMAL(9,8))

INSERT INTO #Supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
WHERE  l.IsActive = 1 AND l.licenseeName = 'Macaubet'	 

WHILE (1=1)
BEGIN
	DELETE #tblCust
	DELETE #tmp
	
	UPDATE TOP (1) t 
	SET isFinished = 1,
		@srecommend = custid
	FROM #Supers t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT =0
		BREAK;

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
		,RepUpdateTime		
		)
	SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0, dbo.f_GetDateTime2()
	FROM #tblCust t	
		CROSS APPLY (
					SELECT @Sporttype Sporttype, @Bettype Bettype				
			)sb
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID and dcs.SportType = sb.sporttype
			AND dcs.BetType = sb.bettype	
				
	WHERE roleid = 2 AND dcs.AgentID IS NULL
	
	INSERT INTO #tmp(custid,Discount)
	SELECT cs.custid, ISNULL(lg.Discount,0)
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON t.CustID = cs.CustID
		OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
					 WHERE dcs_m.CustID = cs.CustID
						AND dcs_m.SportType = @SportType
						AND dcs_m.Bettype = @Bettype
					) AS tmp
		LEFT JOIN bodb_Licensee.dbo.LicenseeCustDiscount lc WITH(NOLOCK) ON t.custid = lc.custid
		LEFT JOIN bodb_Licensee.dbo.LicenseeGroupDiscountDetail lg WITH(NOLOCK) ON lc.GroupDiscountID = lg.GroupDiscountID
																				AND lg.LicenseeID = @LicenseeID
																				AND lg.SportType = @SportType
																				AND lg.Bettype = @Bettype
	WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		AND t.roleid = 1
		
	WHILE (1=1)
	BEGIN
		DELETE TOP (1000) t
		OUTPUT deleted.custid, DELETED.Discount INTO @BatchCust(custid,Discount)
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
		SELECT c.CustID, tmp.sporttype, tmp.bettype, cb.Discount,0,0,0, dbo.f_GetDateTime2()
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN @BatchCust cb ON c.CustID = cb.CustID
			CROSS APPLY (SELECT @Sporttype Sporttype, @Bettype Bettype										
						) AS tmp
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
				AND dcs_m.BetType = tmp.bettype	
																	
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
		
		DELETE @BatchCust
		
		WAITFOR DELAY '0:0:0.05'	
	END	
END		