/*
	Created: 20171031@Johnson
	Task : Correct comm setting for un-sync customers for GD
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@target VARCHAR(20)	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN--GD
		
	--GD
	SELECT ci.custid, cs.sdiscount, cs.adiscount, cs.discount, scs.sdiscount as superDiscount, mcs.adiscount as masterDiscount, cs.discount as agentDiscount
	INTO #tmpSetting
	FROM dbo.CustInfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustSettingGame cs WITH(NOLOCK) ON ci.custid = cs.CustID
																AND cs.sporttype = 255
																AND cs.bettype =1701
		INNER JOIN dbo.CustSettingGame scs WITH(NOLOCK) ON scs.custid = @srecommend
														AND scs.sporttype = cs.sporttype
														AND scs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = ci.mrecommend
														AND mcs.sporttype = cs.sporttype
														AND mcs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame acs WITH(NOLOCK) ON acs.custid = ci.recommend
														AND acs.sporttype = cs.sporttype
														AND acs.bettype = cs.bettype												
	WHERE srecommend = @srecommend
		AND roleid = 1
		AND enabled = 1		
		AND (cs.sdiscount <> scs.sdiscount
			OR cs.adiscount <> mcs.adiscount
			OR cs.discount <> acs.discount)
	
	IF @@ROWCOUNT = 0
		RETURN;
	
	UPDATE cs
	SET cs.sdiscount = CASE WHEN cs.sdiscount <> t.superDiscount THEN t.superDiscount ELSE cs.sdiscount END,
		cs.adiscount = CASE WHEN cs.adiscount <> t.masterDiscount THEN t.masterDiscount ELSE cs.adiscount END,
		cs.discount = CASE WHEN cs.discount <> t.agentDiscount THEN t.agentDiscount ELSE cs.discount END
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpSetting t ON cs.custid = t.custid
	WHERE cs.sporttype= 255
		AND cs.bettype=1701

	DROP TABLE #tmpSetting		
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Super(custid)
SELECT custid 
FROM dbo.custInfo WITH (Nolock) 
WHERE roleid = 4
	AND custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND Enabled = 1
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
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
DECLARE @srecommend INT
CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Super(custid)
SELECT custid 
FROM dbo.custInfo WITH (Nolock) 
WHERE roleid = 4
	AND custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND Enabled = 1
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------