/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: RNG Slot products - clean redundant data - Deposit
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB
*/
----------------------------------------------------------------------------------------------
PRINT N'DEPOSIT - Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------

DECLARE @Cust_cnt	INT,
		@max_custid INT

SELECT @max_custid = xxx
	
CREATE TABLE #SMA( 
			CustID	INT
			,roleID	TINYINT
			,ProductSettingID INT
			,SportType SMALLINT
			,BetType SMALLINT
			,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #Member(
			CustID	INT
			,SportType SMALLINT
			,BetType SMALLINT
			,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #SportRNG (SportType SMALLINT)
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SportType SMALLINT, BetType SMALLINT)

INSERT INTO #SportRNG (SportType)
	  SELECT 155 --MG-RNG
UNION SELECT 156 --SEAL Entertainment
UNION SELECT 158 --Jili
UNION SELECT 165 --Arcadia Gaming
UNION SELECT 167 --CG
UNION SELECT 172 --AdvantPlay
UNION SELECT 174 --AdvantPlay Mini
UNION SELECT 212 --Macau Games
UNION SELECT 232 --PG Soft
UNION SELECT 234 --Joker
UNION SELECT 237 --MaxGame
UNION SELECT 238 --Habanero
UNION SELECT 247 --SG
UNION SELECT 248 --PP

INSERT INTO #Dep_ProductSettingDetail(ProductSettingID, SportType, BetType)
SELECT ps.ProductSettingID, psd.SportType, psd.BetType
FROM  Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
INNER JOIN #SportRNG s ON s.sporttype=psd.SportType
WHERE SettingType=8 AND SettingStatus=2

------------------------------------------------
--SMA
INSERT INTO #SMA(custid, roleID, ProductSettingID, SportType, BetType)
SELECT ci.custid, ci.roleid, s.ProductSettingID, s.SportType, s.BetType
FROM customer ci WITH (NOLOCK) 
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
CROSS APPLY (SELECT ProductSettingID, SportType, BetType FROM #Dep_ProductSettingDetail) s
WHERE ci.custid > @max_custid
AND ci.roleid in (2,3,4)  

--Member
INSERT INTO #Member(custid, SportType, BetType)
SELECT ci.custid, s.SportType, s.BetType
FROM customer ci WITH (NOLOCK) 
INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
CROSS APPLY (SELECT SportType, BetType FROM #Dep_ProductSettingDetail) s
WHERE ci.custid > @max_custid
AND ci.roleid = 1
---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(DISTINCT CustID)
FROM #SMA

SELECT @Cust_cnt += COUNT(DISTINCT CustID)
FROM #Member

DECLARE @msg_total NVARCHAR(200) = 'Deposit - Total of New Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--SMA
IF EXISTS (SELECT TOP 1 1 FROM #SMA)
BEGIN
	--LicenseeProductSetting
	IF EXISTS (SELECT TOP 1 1 FROM #SMA WHERE roleID=4)
	BEGIN
		DELETE d
		FROM dbo.Dep_LicenseeProductSetting d WITH(ROWLOCK)
			INNER JOIN #SMA ci WITH(NOLOCK) ON d.CustID = ci.custid AND ci.ProductSettingID = d.ProductSettingID 
		WHERE ci.roleid=4
	END

	DELETE cg
	FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
	INNER JOIN #SMA ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType
END
	
--Member
IF EXISTS (SELECT TOP 1 1 FROM #Member)
BEGIN
	DELETE cg
	FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
	INNER JOIN #Member ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType
END

PRINT N'--------------------------------------------------------'
PRINT N'DEPOSIT - Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO