/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240418@Eden
	Task: Correct Member BetSetting of SportType IN (169,202,220,222) [Redmine: #204104]
	DB: DBCUST/CustDB 
*/ 
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_18
	 @JsonData VARCHAR(MAX) 

AS
BEGIN
	SET NOCOUNT ON
	
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
	FROM OPENJSON(@JsonData) WITH (
				  CustID	INT '$.CustID'
				, recommend	INT '$.recommend'
				) AS ci
		INNER JOIN CustBetSetting3rd_Member m WITH(NOLOCK) ON ci.CustID = m.CustID
		INNER JOIN CustBetSetting3rd_Agent a WITH(NOLOCK) 
			ON ci.recommend = a.CustID 
			AND m.SportType = a.SportType
			AND m.BetType = a.BetType
	WHERE (
			(m.MaxBet > a.MaxBet AND a.MaxBet > 0) 
			OR (m.MaxPerMatch > a.MaxPerMatch AND a.MaxPerMatch > 0)
		  )
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
IF	OBJECT_ID('tempdb..#MemberTemp') IS NOT NULL
	DROP TABLE	#MemberTemp;
IF	OBJECT_ID('tempdb..#MemberTempBatch') IS NOT NULL
	DROP TABLE	#MemberTempBatch;

CREATE TABLE #MemberTemp(CustID INT, recommend INT)
CREATE TABLE #MemberTempBatch(CustID INT, recommend INT)

INSERT INTO #MemberTemp(custid,recommend)
SELECT DISTINCT ci.CustID,ci.recommend
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN CustBetSetting3rd_Member m WITH(NOLOCK) ON ci.CustID = m.CustID
	INNER JOIN CustBetSetting3rd_Agent a WITH(NOLOCK) 
		ON ci.Recommend = a.CustID 
		AND m.SportType = a.SportType
		AND m.BetType = a.BetType
WHERE (
		(m.MaxBet > a.MaxBet AND a.MaxBet > 0) 
		OR (m.MaxPerMatch > a.MaxPerMatch AND a.MaxPerMatch > 0)
	  )
	AND ci.Enabled = 1
	AND ci.roleid = 1
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND m.SportType IN(169,202,220,222)
	--AND ci.currency <> 20

DECLARE @Batch	INT = 5000, @JsonData		VARCHAR(MAX)

-- For deployer info
DECLARE @cnt INT, @index INT = 0
DECLARE @msg_total NVARCHAR(200) = 'Total of Custids: %d.'

SET @cnt = (SELECT COUNT(*) FROM #MemberTemp )
RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	TRUNCATE TABLE #MemberTempBatch
	DELETE TOP (@Batch)  t 
	OUTPUT DELETED.CustID,deleted.recommend
	INTO #MemberTempBatch(CustID,recommend) 
	FROM #MemberTemp t 

	IF @@ROWCOUNT = 0 
	BREAK;

	SELECT @JsonData = (SELECT CustID,recommend FROM #MemberTempBatch FOR JSON PATH)


	EXEC dbo.Acc_DynamicCustSetting3rd_18 
				@JsonData = @JsonData
			
	WAITFOR DELAY '00:00:00.050'
END
GO
GO
PRINT N'Step : End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF
