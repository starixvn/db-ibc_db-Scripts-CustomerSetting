/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230309@Johnson
	Task: initial virtualrate for basketball [redmine: #184339]
	DB: DBCUST/CustDB
*/
CREATE TABLE #supers (custid int PRIMARY KEY)

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
							
CREATE TABLE #tblCust (custid INT PRIMARY KEY, srecommend INT)
CREATE TABLE #Supers2 (custid INT PRIMARY KEY, IsFinished BIT DEFAULT 0)
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
DECLARE @VR_HDP SMALLMONEY
	
INSERT INTO #tblCust(custid, srecommend)
SELECT custid, srecommend 
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid
	AND enabled = 1	

INSERT INTO #supers2(custid)
SELECT DISTINCT srecommend
FROM #tblCust

WHILE(1=1)
BEGIN
	UPDATE TOP (1) t
	SET IsFinished = 1,
		@srecommend = custid
	FROM #Supers2 t
	WHERE IsFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK; 

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
	
	INSERT INTO @tmpCust (custid)
	SELECT custid
	FROM #tblCust 
	WHERE srecommend = @srecommend
	
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
			
	DELETE @virtualXML
	DELETE @tmpCust
	DELETE @tblVirtualrate 
	
	WAITFOR DELAY '0:0:0.28'		
END

DROP TABLE #tblCust
DROP TABLE #Supers
DROP TABLE #Supers2	