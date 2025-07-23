/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250515@Johnson	
	Task: Initial Potential Winning Limit/Threshold for customers [redmine:#226060]
	DB: DBCUST-CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF OBJECT_ID(N'CustPotentialWinLimit') IS NULL
		RETURN;

	CREATE TABLE #supers (custid int,isfinished bit default(0))
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED)
	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)

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
		AND ci.currency <> 20

	INSERT INTO #MemberTemp (CustID)
	SELECT cs.custid
	FROM CustPotentialWinLimit cs WITH (NOLOCK)
		INNER JOIN custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid = 1
	
    WHILE(1=1)
    BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.CustID INTO #tmpCust(CustID)
		FROM #MemberTemp t

		IF @@ROWCOUNT = 0
            BREAK;

        DELETE cs FROM dbo.CustPotentialWinLimit cs WITH(ROWLOCK)
		WHERE cs.CustID IN (SELECT CustID FROM #tmpCust)
		
        DELETE #tmpCust
        
        WAITFOR DELAY '00:00:0.200'        
    END

	DROP TABLE #supers
	DROP TABLE #MemberTemp
	DROP TABLE #tmpCust
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target