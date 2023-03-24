/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230308@Johnson
	Task: initial virtualrate for basketball [redmine: #184339]
	DB: DBCUST/CustDB
*/
--BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
	@srecommend INT	
	,@maxcustid INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustVirtualSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('ProfileVirtualSetting') = 0 RETURN
	
	DECLARE	@tblVirtualrate		TABLE (
									SportType			INT
								,	BetType				INT
								,	IsLive				BIT
								,	VirtualMultiplier	SMALLMONEY	
								);
	
	DECLARE	@virtualXML	TABLE (
									seqNo		TINYINT PRIMARY KEY
								,	Pos			VARBINARY(64)
								,	Val			VARBINARY(64)
								);
								
	DECLARE @VR_HDP SMALLMONEY
	
	IF @srecommend IN (3800272,26393456,1575555,39583203,13864417,4802250,11674017,51266705,840993,398437)
		SELECT @VR_HDP = 1 -- 0%
	ELSE IF @srecommend IN (13744152)
		SELECT @VR_HDP = 0.1 -- -90%
	ELSE
		SELECT @VR_HDP =  dbo.f_GetVirtualSetting(cvs.bitmapVirtual, pvs.profileID) 
		FROM        CustVirtualSetting    AS cvs WITH(NOLOCK)
		INNER JOIN  ProfileVirtualSetting       AS pvs WITH(NOLOCK)
				ON  cvs.seqNo = pvs.seqNo
		WHERE cvs.custid = @srecommend	
			AND Sporttype = 1
			AND Bettype = 1
			AND IsLive = 1
	
	INSERT INTO @tblVirtualrate(SportType,Bettype,IsLive,VirtualMultiplier)
	SELECT SportType,Bettype,IsLive, @VR_HDP
	FROM ProfileVirtualSetting AS pvs WITH(NOLOCK)            
    WHERE Sporttype = 2		
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @maxcustid
		AND enabled = 1	
		
	INSERT INTO @virtualXML
			(seqNo, Pos, Val)
	SELECT	seqNo, p1.Pos, p2.Val
	FROM (
		SELECT	DISTINCT seqNo
		FROM	ProfileVirtualSetting WITH (NOLOCK)
		WHERE sporttype = 2
	) pvs
	CROSS APPLY (
		SELECT CONVERT(VARBINARY(64), (
			SELECT	CONVERT(VARCHAR, CAST(ipvs.profileID - 64 * (ipvs.seqNo - 1) AS BINARY(1)), 2)
			FROM		@tblVirtualrate			AS tmp
				INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
					ON	tmp.sporttype	= ipvs.sporttype
						AND	tmp.bettype		= ipvs.bettype
						AND	tmp.isLive		= ipvs.islive
			WHERE	ipvs.seqNo = pvs.seqNo 
			FOR XML PATH ('')						
		), 2) AS Pos
	) p1
	CROSS APPLY (
		SELECT CONVERT(VARBINARY(64), (
			SELECT	CONVERT(VARCHAR, CAST(CASE WHEN CAST(VirtualMultiplier * 100 AS INT) > 200 THEN ((CAST(VirtualMultiplier * 100 AS INT) - 200) / 5 + 200) ELSE CAST(VirtualMultiplier * 100 AS INT) END AS BINARY(1)), 2)
			FROM		@tblVirtualrate			AS tmp
				INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
					ON	tmp.sporttype	= ipvs.sporttype
						AND	tmp.bettype		= ipvs.bettype
						AND	tmp.isLive		= ipvs.islive
			WHERE	ipvs.seqNo = pvs.seqNo
			FOR XML PATH ('')						
		), 2) AS Val
	) p2;

	WHILE(1=1)
	BEGIN
		DELETE TOP (2000) t
		OUTPUT DELETED.custid INTO @tmpCust
		FROM #tblCust t
		
		IF @@rowcount = 0 
			BREAK;
		
		UPDATE cvs
		SET cvs.bitmapVirtual = bm.bitmap
		FROM	@tmpCust t
			CROSS APPLY (
				SELECT TOP 3 cvs.seqNo, cvs.bitmapVirtual
				FROM CustVirtualSetting	AS cvs WITH (UPDLOCK, ROWLOCK)
				WHERE cvs.custID = t.custID
			) cvs
			CROSS APPLY (
				SELECT TOP 1 bm.bitmap
				FROM @virtualXML	AS tmp
					CROSS APPLY dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos) AS bm
				WHERE cvs.seqNo = tmp.seqNo
			) bm
			
		DELETE @tmpCust	
	END
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

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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

	EXEC dbo.Acc_CustSetting_19 @srecommend = @srecommend
			,@maxcustid = @max_custid			
			,@target = @target
	
END
DROP TABLE #supers
GO	