
/*
	Created: Winnie
	Date: 20190913
	Task: Delete existing CustSetting 
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custoverride') = 0 RETURN
	
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'		
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0		

	CREATE TABLE #temp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID,Sporttype,Bettype))
	
	INSERT INTO #temp(CustID,Sporttype,Bettype)
	SELECT cg.custid,99,9999
	FROM CustSetting cg WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType =99 AND bettype = 9999

	DELETE cg
	FROM CustSetting cg 
		INNER JOIN #temp t ON cg.custid=t.CustID AND cg.sporttype=t.Sporttype AND cg.bettype=t.Bettype

	TRUNCATE TABLE #temp

	INSERT INTO #temp(CustID,Sporttype,Bettype)
	SELECT cg.custid,99,9999
	FROM custOverride cg WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType =99 AND bettype = 9999

	DELETE cg
	FROM custOverride cg 
		INNER JOIN #temp t ON cg.custid=t.CustID AND cg.sporttype=t.Sporttype AND cg.bettype=t.Bettype
	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_CustSetting3rd_19 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_CustSetting3rd_19 @target = 'DBCUST'

