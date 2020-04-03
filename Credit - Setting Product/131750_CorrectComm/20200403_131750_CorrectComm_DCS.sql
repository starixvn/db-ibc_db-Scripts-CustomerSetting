/*
	Created: Elodie
	Task: Correct DCS product's commission for Direct account
	DB: DBCUST/CustDB
	Date: 20200403
*/
USE CustDB
GO

ALTER PROCEDURE Acc_DynamicCustSetting3rd_09
	@target VARCHAR(20)
AS
BEGIN
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	SET NOCOUNT ON

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN

	DECLARE @batch INT = 4000

	CREATE TABLE #DirectTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	CREATE TABLE #MemberTemp 
	(	
		CustID INT,
		srecommend INT,
		mrecommend INT,
		recommend INT
	)
	
	CREATE TABLE #MemberBatch 
	(	
		CustID INT,
		srecommend INT,
		mrecommend INT,
		recommend INT
	)

	INSERT INTO #DirectTemp (CustID,roleid) --Direct Master, Agent
	SELECT ci.custid, ci.roleid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN dbo.CustDirectAccount da WITH(NOLOCK) ON ci.CustID = da.custid
	WHERE ci.Enabled=1
		AND ci.roleid IN (2,3)

	INSERT INTO #MemberTemp (CustID, srecommend, mrecommend, recommend)
	SELECT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE ci.mrecommend = D.CustID)
		AND ci.roleid = 1

	INSERT INTO #MemberTemp (CustID, srecommend, mrecommend, recommend)
	SELECT custid, ci.srecommend, ci.mrecommend, ci.recommend
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE ci.recommend = D.CustID)
		AND NOT EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE ci.mrecommend = D.CustID)
		AND ci.roleid = 1

	WHILE (1 = 1)
	BEGIN
		TRUNCATE TABLE #MemberBatch

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID, deleted.srecommend, deleted.mrecommend, deleted.recommend INTO #MemberBatch(CustID, srecommend, mrecommend, recommend)
		FROM #MemberTemp a 

		IF @@ROWCOUNT = 0 
			BREAK

		UPDATE cs
		SET  cs.SuperDiscount = css.Discount
		FROM dbo.CustDiscount3rd_Member cs WITH(ROWLOCK)
			INNER JOIN #MemberBatch ci WITH (NOLOCK) ON cs.CustID = ci.custid
			INNER JOIN dbo.CustDiscount3rd_Agent css WITH (NOLOCK) ON css.BetType = cs.BetType AND css.SportType = cs.SportType AND css.CustID = ci.srecommend

		UPDATE cs
		SET  cs.MasterDiscount = csm.Discount
		FROM dbo.CustDiscount3rd_Member cs WITH(ROWLOCK)
			INNER JOIN #MemberBatch ci WITH (NOLOCK) ON cs.CustID = ci.custid
			INNER JOIN dbo.CustDiscount3rd_Agent csm WITH (NOLOCK) ON csm.BetType = cs.BetType AND csm.SportType = cs.SportType AND csm.CustID = ci.mrecommend

		UPDATE cs
		SET  cs.AgentDiscount = csa.Discount
		FROM dbo.CustDiscount3rd_Member cs WITH(ROWLOCK)
			INNER JOIN #MemberBatch ci WITH (NOLOCK) ON cs.CustID = ci.custid
			INNER JOIN dbo.CustDiscount3rd_Agent csa WITH (NOLOCK) ON csa.BetType = cs.BetType AND csa.SportType = cs.SportType AND csa.CustID = ci.recommend
		
		WAITFOR DELAY '00:00:00.100'
	END
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'