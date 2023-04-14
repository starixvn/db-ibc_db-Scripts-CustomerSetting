/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/17
	Task: CREDIT - Enhance Initial data Setting For PP - Pragmatic [RM:#181686]
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686] 
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
		@Custid INT
		,@maxcustid INT
		,@target VARCHAR(20)


AS
BEGIN
	SET NOCOUNT ON  
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only


---------------------------------Check Replicate---------------------------------
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN

---------------------------------COLLECT DATA---------------------------------
DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @New_BetType = 7000
	,  @SportType = 248

IF OBJECT_ID('tempdb..#CustListAgent') IS NOT NULL
    DROP TABLE #CustListAgent ;  
IF OBJECT_ID('tempdb..#CustListMember') IS NOT NULL
    DROP TABLE #CustListMember ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Agent') IS NOT NULL
    DROP TABLE #CustStakeLevel_Agent ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Member') IS NOT NULL
    DROP TABLE #CustStakeLevel_Member ;  

CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #CustListMember (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #CustStakeLevel_Agent  (CustID INT	 PRIMARY KEY(CustID))
CREATE TABLE #CustStakeLevel_Member (CustID INT	 PRIMARY KEY(CustID))

INSERT INTO #CustListAgent(CustID)
SELECT cg.custid  
FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)	
INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
WHERE SportType = @Sporttype 
AND BetType = @Old_BetType
AND ci.srecommend = @Custid
AND ci.Enabled = 1
AND ci.roleid in (2,3,4) 
AND ci.custid <= @maxcustid
GROUP BY cg.custid
	
INSERT INTO #CustListMember(CustID)
SELECT cg.custid  
FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)	
INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
WHERE SportType = @Sporttype
AND BetType = @Old_BetType
AND ci.srecommend = @Custid 
AND ci.Enabled = 1 
AND ci.roleid = 1	
AND ci.custid <= @maxcustid 
GROUP BY cg.custid


DECLARE @BatchSize INT = 5000     

-----------------------------------CustStakeLevel_Agent---------------------------------

WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Agent (CustID)
		FROM #CustListAgent c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cA SET BetType = @New_BetType
		FROM CustStakeLevel_Agent cA WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Agent cust on cA.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #CustStakeLevel_Agent
	END

-------------------------------------CustStakeLevel_Member---------------------------------

WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Member (CustID)
		FROM #CustListMember c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cM SET BetType = @New_BetType
		FROM CustStakeLevel_Member cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Member cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #CustStakeLevel_Member
	END
END
GO
 --END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

----------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
	DECLARE @max_custid INT, @srecommend INT , @target VARCHAR(20)
	SELECT @max_custid = xxx

	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

	CREATE TABLE #supers (custid int,isfinished bit default(0))



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
			AND ci.custid <= @max_custid
-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #Supers
		SET isfinished = 1
			,@srecommend = custid	
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
				
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @custid = @srecommend
				,@maxcustid = @max_custid
				,@target = @target
				
				
		waitfor delay '00:00:0.100'
	END
	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	GO

	

