/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240418@Eden
	Task: Correct Member BetSetting of SportType IN (169,202,220,222) [Redmine: #204104]
	DB: DBCUST/CustDB 
*/ 
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_18
	 @srecommend INT
	--,@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	
	--IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	--IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
	   )
		RETURN
	
	DECLARE @BatchNum INT = 5000

	CREATE TABLE #CustTemp(CustID INT, Sporttype SMALLINT, bettype SMALLINT, MaxBet	money, MaxPerMatch	money)
	CREATE TABLE #CustTempBatch(CustID INT, Sporttype SMALLINT, bettype SMALLINT, MaxBet money, MaxPerMatch	money PRIMARY KEY(custid,sporttype,bettype))

	INSERT INTO #CustTemp(CustID,Sporttype,Bettype,MaxBet,MaxPerMatch)
	SELECT ci.custid,m.SportType,m.BetType,a.MaxBet,a.MaxPerMatch
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Member m WITH(NOLOCK) ON ci.CustID = m.CustID
		INNER JOIN CustBetSetting3rd_Agent a WITH(NOLOCK) 
			ON ci.Recommend = a.CustID 
			AND m.SportType = a.SportType
			AND m.BetType = a.BetType
	WHERE (m.MaxBet > a.MaxBet AND a.MaxBet > 0) OR (m.MaxPerMatch > a.MaxPerMatch AND a.MaxPerMatch > 0)
		AND ci.Enabled = 1
		AND ci.roleid = 1
		AND ci.srecommend = @srecommend
		AND m.SportType IN(169,202,220,222)

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP (@BatchNum)  t 
		OUTPUT DELETED.CustID, DELETED.Sporttype,deleted.bettype,deleted.MaxBet,deleted.MaxPerMatch 
		INTO #CustTempBatch(CustID,Sporttype,bettype,MaxBet,MaxPerMatch) 
		FROM #CustTemp t 

		IF @@ROWCOUNT=0
			BREAK

		UPDATE m
		SET m.MaxBet = ci.MaxBet,
			m.MaxPerMatch = ci.MaxPerMatch,
			m.MinBet = CASE WHEN m.MinBet > ci.MaxBet THEN ci.MaxBet ELSE m.MinBet END
		FROM #CustTempBatch ci
			INNER JOIN CustBetSetting3rd_Member m WITH(ROWLOCK,UPDLOCK,FORCESEEK) 
				ON ci.CustID = m.CustID 
				AND ci.Sporttype = m.SportType
				AND ci.bettype = m.BetType
		WHERE (m.MaxBet > ci.MaxBet AND ci.MaxBet > 0) OR (m.MaxPerMatch > ci.MaxPerMatch AND ci.MaxPerMatch > 0)
	END
	
	DROP TABLE #CustTemp
	DROP TABLE #CustTempBatch

END
GO
-------------------------------------------------------------
SET NOCOUNT ON
--PRINT N'Step : Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

--DECLARE @target VARCHAR(20)
--IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
--	SET @target = 'DBCUST'
--ELSE 
--	SET @target = 'REPLICATED'

--Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT DISTINCT TOP(2)  ci.srecommend
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN CustBetSetting3rd_Member m WITH(NOLOCK) ON ci.CustID = m.CustID
	INNER JOIN CustBetSetting3rd_Agent a WITH(NOLOCK) 
		ON ci.Recommend = a.CustID 
		AND m.SportType = a.SportType
		AND m.BetType = a.BetType
WHERE (m.MaxBet > a.MaxBet AND a.MaxBet > 0) OR (m.MaxPerMatch > a.MaxPerMatch AND a.MaxPerMatch > 0)
	AND ci.Enabled = 1
	AND ci.roleid = 1
	AND ci.srecommend NOT IN (SELECT custid FROM CustSuper WITH(NOLOCK))
	AND m.SportType IN(169,202,220,222)
	AND ci.currency <> 20

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

	EXEC dbo.Acc_DynamicCustSetting3rd_18 
				@srecommend = @srecommend
				--, @target = @target
			
	WAITFOR DELAY '00:00:00.050'
END
GO
GO
PRINT N'Step : End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF
