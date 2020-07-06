/*
	Created: Johnson
	Date: 2020-04-11
	Task: Initial setting for newly created customers
	DB: DBCUST/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@max_custid INT		
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0		
		OR dbo.f_CheckRepTable('CustInfo') = 0
		)
	RETURN
	
	CREATE TABLE #Super(CustID INT)
	CREATE TABLE #tblCust(CustID INT PRIMARY KEY)
	DECLARE @BatchCust TABLE (CustID INT)
	
	INSERT INTO #Super(custid)
	SELECT DISTINCT cs.custid
	FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
		INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
		INNER JOIN dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) ON lp.CustID = cs.custid
		INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
		INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID
	WHERE  l.IsActive = 1
		AND p.SettingType = 4
		AND P.ProductID IN (22,32,24) -- remove allbet
			
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
		
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT deleted.custid INTO @BatchCust
		FROM #tblCust t
				
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE cs
			SET isGroupedComm = 1
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
		
		DELETE @BatchCust
	END	
	
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

EXEC Acc_Dep_DynamicCustSetting_09 @max_custid = @max_custid

-- END STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB -----
-----------------------------------------------------------------------------------	
