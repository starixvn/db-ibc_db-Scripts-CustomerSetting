/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20241119@Johnson
	Task: Adjust PT SB for 755555
	DB: DBCust/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19] 
	@custid INT = 0,    
	@Target VARCHAR(20) = ''	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN	
	
	DECLARE @PT smallmoney = 85
	
	UPDATE cs
	SET SuperPT = CASE WHEN SuperPT < @PT THEN @PT ELSE SuperPT END,
		MasterPT = CASE WHEN SuperPT < @PT THEN @PT - SuperPT + MasterPT ELSE MasterPT END,
		AgentPT = CASE WHEN SuperPT < @PT THEN @PT - SuperPT + AgentPT ELSE AgentPT END,
		MinPT = CASE WHEN MinPT < @PT THEN @PT ELSE MinPT END
	FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK,UPDLOCK)
	WHERE custid = @custid
		AND Sporttype IN (9913,9914,9915)
		AND (SuperPT < @PT OR MinPT < @PT)
	
	IF @@ROWCOUNT = 0
		RETURN;
		
	DECLARE @SportBettypeXML NVARCHAR(MAX) = ''	

	SELECT @SportBettypeXML = CONVERT(VARCHAR(MAX),
	(
		SELECT * 
		FROM (
			SELECT 9913 SportType,	915 BetType,	1 IsLive
			UNION SELECT 9913,	916, 	1
			UNION SELECT 9913,	917, 	1
			UNION SELECT 9914,	915,	0
			UNION SELECT 9914,	916,	0
			UNION SELECT 9914,	917,	0
			UNION SELECT 9915,	918,	0
		)t
		FOR XML RAW('PT'), ROOT ('ROOT'), TYPE
	))
	--correct PT when update S4
	EXEC dbo.Acc_DynamicCustSetting3rd_09 
		@SuperID = @custid
		,@RoleID = 4
		,@SportBettypeXML = @SportBettypeXML 
		,@target = @target
	
	--correct PT when update MinPT
	EXEC dbo.Acc_DynamicCustSetting3rd_10
		@SuperID = @custid
		,@RoleID = 4
		,@SportBettypeXML = @SportBettypeXML
		,@target = @target
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT,
	@PT SMALLMONEY = 85

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site = '755555'
	AND c.Enabled = 1
	AND EXISTS (SELECT 1 
				FROM CustPTSetting3rd_Agent cs WITH(NOLOCK)
				WHERE cs.custid = ci.custid
					AND Sporttype IN (9913,9914,9915)
					AND (SuperPT < @PT OR MinPT < @PT)
				)

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

	EXEC dbo.Acc_CustSetting3rd_19 @custid = @srecommend
			,@target = @target			
			
	waitfor delay '00:00:0.200'
END
DROP TABLE #supers
GO
