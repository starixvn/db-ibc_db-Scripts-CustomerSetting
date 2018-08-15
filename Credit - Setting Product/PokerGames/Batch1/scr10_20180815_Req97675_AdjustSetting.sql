/*
	Created: Elodie
	Task: Adjust Setting for PokerGames
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09] 
AS

BEGIN
	
	SET NOCOUNT ON

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN	

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.site IN ('789y')
		AND ci.currency <> 20

	INSERT INTO #supers(custid)
	SELECT custid
	FROM CustInfo ci WITH (NOLOCK)
	WHERE custid IN (2,3,16,17,35,21278849,21278858)

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	CREATE TABLE #SMAList_CommSetting (custid INT, Discount DECIMAL(9,8))
	CREATE TABLE #MemberList_CommSetting (custid INT, SuperDiscount DECIMAL(9,8), MasterDiscount DECIMAL(9,8), AgentDiscount DECIMAL(9,8), PlayerDiscount DECIMAL(9,8))

	DECLARE @ProductID INT = 33, @currency INT
	
	SELECT t.* 
	INTO #SportBettypeFilter6
	FROM ProductSettingDetail t WITH (NOLOCK)
	WHERE t.SettingType = 6 AND t.ProductID = @ProductID

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		currency INT,
		Credit MONEY
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		currency INT,
		Credit MONEY
	)
	
	SELECT custid INTO #ListCust
	FROM DBLOG.bodb_CustomerLog.dbo.UserLog_Credit WITH (NOLOCK)
	WHERE ActionID IN (1200,1201,1202,1203,1204,1205,1206,1211) AND logdate = GETDATE()
	
	IF @@ROWCOUNT = 0
		RETURN

	INSERT INTO #MemberTemp (CustID, currency, Credit)
	SELECT c.custid, currency, Credit
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #ListCust l ON l.custid = c.custid
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1
	
	INSERT INTO #SMATemp (CustID, roleid, currency, Credit)
	SELECT c.custid, roleid, currency, Credit
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #ListCust l ON l.custid = c.custid
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1

	--------------------------------------Win Loss Limit-------------------------------------------------		
	--Agent Level
	UPDATE cs
	SET cs.MaxLossLimit = CASE	WHEN FLOOR(ci.Credit * 0.1) < ls.MinLossLimit THEN ls.MinLossLimit
								WHEN FLOOR(ci.Credit * 0.1) > ls.DefaultLossLimit THEN ls.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END
	FROM CustWinLossLimit_Agent cs
		INNER JOIN #SMATemp ci ON ci.CustID = cs.CustId
		INNER JOIN dbo.LossLimit_GlobalSetting ls WITH(NOLOCK) ON ci.currency = ls.ExchangeId
		CROSS APPLY #SportBettypeFilter6 sb
	WHERE ls.ProductId = @ProductID	

	--Member Level
	UPDATE cs
	SET cs.MaxLossLimit = CASE	WHEN FLOOR(ci.Credit * 0.1) < ls.MinLossLimit THEN ls.MinLossLimit
								WHEN FLOOR(ci.Credit * 0.1) > ls.DefaultLossLimit THEN ls.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END
	FROM dbo.CustWinLossLimit_Member cs
		INNER JOIN #MemberTemp ci ON ci.CustID = cs.CustId
		INNER JOIN dbo.LossLimit_GlobalSetting ls WITH(NOLOCK) ON ci.currency = ls.ExchangeId
		CROSS APPLY #SportBettypeFilter6 sb
	WHERE ls.ProductId = @ProductID	

	DROP TABLE #SportBettypeFilter6			
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'