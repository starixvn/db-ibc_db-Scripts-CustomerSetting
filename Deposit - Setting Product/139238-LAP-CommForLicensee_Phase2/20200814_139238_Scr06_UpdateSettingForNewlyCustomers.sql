/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBCUST/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_08]
 	@max_custid INT		
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0		
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0
		OR dbo.f_CheckRepTable('CustInfo') = 0
		
		)
	RETURN
	
	CREATE TABLE #Super(CustID INT)
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY)
	
	INSERT INTO #Super(custid)
	SELECT DISTINCT cs.custid
	FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
		INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
		INNER JOIN dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) ON lp.CustID = cs.custid
		INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
		INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID
	WHERE  l.IsActive = 1
		AND p.SettingType = 4
		AND P.ProductID IN (28,45,36,40,5,27)  
			
	INSERT INTO #tblCust(Custid)
	SELECT ci.custid
	FROM dbo.CustInfo ci WITH(NOLOCK)
		INNER JOIN dbo.Dep_CustSettingMode cs WITH(NOLOCK) ON ci.custid = cs.CustID
	WHERE srecommend IN (SELECT custid FROM #super)
		AND mrecommend NOT IN (SELECT custid 
								FROM dbo.custinfo WITH(NOLOCK)
								WHERE srecommend IN (SELECT custid FROM #super)
									AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
									AND roleid=3
							)
		AND ci.custid > @max_custid
		AND isGroupedComm = 0
		AND roleid = 1
		
	-- UPDATE comm group for cust have not offered comm yet.
	UPDATE cs
		SET isGroupedComm = 1
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust cb ON cb.CustID = cs.CustID
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
		INNER JOIN #tblCust cb ON c.CustID = cb.CustID
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
	
	DROP TABLE #Super
	DROP TABLE #tblCust
END		
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT DBCUST/CustDB only -----
------------------------------------------------------------------------------
DECLARE @max_custid INT		

SELECT @max_custid = xxx

EXEC Acc_Dep_DynamicCustSetting_08 @max_custid = @max_custid

-- END STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB -----
-----------------------------------------------------------------------------------	
