/*
	Created: 20200713@Eden
	Task: Delete new games settings for credit customers - Real Currencies [Redmine:#137475]	
	DB: DBCUST/CUSTDB
*/	
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]	
	@target VARCHAR(50)
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
			AND dbo.f_CheckRepTable('CustGameType') = 1
			)
		RETURN		
	
	CREATE TABLE #supers (custid INT)
	DECLARE @NewGame TABLE(fGameType INT, tGameType INT)
	INSERT INTO @NewGame (fGameType, tGameType) 
	SELECT 15, 27
	UNION SELECT 15, 28
	UNION SELECT 15, 29

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
		AND ci.currency <> 20 -- Exclude UUS

	SELECT DISTINCT cg.custid 
	INTO #CustGameType
	FROM CustGameType cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE GameTypeID IN (SELECT tGameType FROM @NewGame)

	DELETE cs
	FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustGameType ci ON cs.custid = ci.custid
	WHERE GameTypeID IN (SELECT tGameType FROM @NewGame)
	
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------

EXEC dbo.[Acc_CustSetting3rd_19] @target = 'REPLICATED' 	
GO			

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
-----------------------------------------------------------------------------------

---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
-------------------------------------------------
EXEC dbo.[Acc_CustSetting3rd_19] @target = 'DBCUST' 	
GO

--END STEP 3