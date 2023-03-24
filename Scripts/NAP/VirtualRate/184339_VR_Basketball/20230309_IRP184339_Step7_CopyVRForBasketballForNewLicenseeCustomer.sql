/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230309@Johnson
	Task: initial virtualrate for basketball [redmine: #184339]
	DB: DBCUST/CustDB
*/

CREATE TABLE #supers (custid int PRIMARY KEY)
CREATE TABLE #supers2 (custid int PRIMARY KEY, IsFinished BIT DEFAULT 0)

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	
CREATE TABLE #tblCust
	(
		CustID INT PRIMARY KEY CLUSTERED,
		srecommend INT
	)

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88' + 'CAS%')
	
INSERT INTO #tblCust (CustID,srecommend)
SELECT custid, srecommend
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND Enabled = 1 
	AND custid > @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

INSERT INTO #supers2(custid)	
SELECT DISTINCT srecommend 
FROM #tblCust	

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

DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
							
DECLARE @VR_HDP SMALLMONEY

WHILE(1=1)
BEGIN
	UPDATE TOP(1) t
	SET IsFinished = 1,
		@srecommend = custid
	FROM #supers2 t
	WHERE IsFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	IF @srecommend IN (41878825,36334368,61560761,43841247,46906347,27109620,47022039,52761432,50926990)
		SELECT @VR_HDP = 1 -- 0%
	ELSE IF @srecommend IN (3167631,836226,836203,38338991,20121325,32657295,4833492,932253,932181,18722189,2747989,56788369,56947976,22773651,56678273,23400762,24509702,26130115,56506780,29336836,48984435,36003656,21975126,16379946,33663777,21475588,55141461,56899343,31607887,29721025,23400675,39469788,55539328,3293743,36236353,10580785,10580767,39264233,38321515,29461691,56947845,29315707,28926982)
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
	
	INSERT INTO @tmpCust(custid)
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
	
	DELETE @tmpCust
	DELETE @tblVirtualrate
	DELETE @virtualXML
	
	WAITFOR DELAY '0:0:0.28'
END

DROP TABLE #supers
DROP TABLE #supers2
DROP TABLE #Dummy
DROP TABLE #tblCust
