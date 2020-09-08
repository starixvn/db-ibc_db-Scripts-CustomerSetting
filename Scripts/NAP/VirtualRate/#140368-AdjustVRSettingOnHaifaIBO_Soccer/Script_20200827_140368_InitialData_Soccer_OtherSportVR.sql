/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20200827@Eden
	Task: SET soccer sports VR = 0 for customers who were adjusted Other sport VR = 0 ("Haifa & IBO" RMB currency) [#RM:140368]
		--step 1: Get custtomer list to update Soccer VR = 0 (status = 2)
		--step 2: Update VRCustAutoAdjustment change sporttype from 99 to 100 for old data (lock update VR downline on NAP)
		--step 3: process update Soccer VR = 0
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO		

DECLARE @Update_CustTbl TABLE ( CustID INT PRIMARY KEY, IsFinish BIT DEFAULT 0)

--step 1: Get custtomer list to update soccer VR = 0 (status = 2)
INSERT INTO @Update_CustTbl(CustID)
SELECT t.CustID
FROM VRCustAutoAdjustment t WITH(NOLOCK) 
	INNER JOIN customer c WITH(NOLOCK) ON t.CustID = c.custid
	INNER JOIN Customer ag WITH(NOLOCK) ON c.recommend = ag.custid 
WHERE t.SportType = 99 
	AND t.Status = 2
	AND c.currency = 13 --RMB
	AND ag.site IN ('haifa','IBO')

--step 2: Update VRCustAutoAdjustment change sporttype from 99 to 100 for old data
UPDATE t 
SET t.SportType = 100
FROM VRCustAutoAdjustment t WITH(ROWLOCK) 
	INNER JOIN customer c WITH(NOLOCK) ON t.CustID = c.custid
	INNER JOIN Customer ag WITH(NOLOCK) ON c.recommend = ag.custid 
WHERE t.SportType = 99 
	--AND t.Status = 2
	AND c.currency = 13 --RMB
	AND ag.site IN ('haifa','IBO')

--step 3: process update soccer VR = 0
DECLARE	@tblVirtualrate		TABLE (
							SportType			INT
						,	BetType				INT
						,	IsLive				BIT
						,	VirtualMultiplier	SMALLMONEY	
						);
										
INSERT INTO	@tblVirtualrate (
						SportType
					,	BetType
					,	IsLive
					,	VirtualMultiplier
				)
SELECT	sporttype,bettype,islive,1.00
FROM ProfileVirtualSetting 	WITH (NOLOCK)	
WHERE sporttype = 1

DECLARE	@virtualXML	TABLE (
								seqNo		TINYINT PRIMARY KEY
							,	Pos			VARBINARY(64)
							,	Val			VARBINARY(64)
							);
										
INSERT INTO @virtualXML(seqNo, Pos, Val )
SELECT	seqNo, p1.Pos, p2.Val
FROM (
		SELECT	DISTINCT seqNo
		FROM	ProfileVirtualSetting WITH (NOLOCK)
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

CREATE TABLE #tempUpdate_tbl (CustID INT)

WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #tempUpdate_tbl

	UPDATE TOP(3000) t
	SET t.IsFinish = 1
	OUTPUT inserted.CustID INTO #tempUpdate_tbl(CustID)
	FROM @Update_CustTbl t
	WHERE t.IsFinish = 0

	IF @@ROWCOUNT = 0 BREAK;
		
	UPDATE cvs
		SET cvs.bitmapVirtual = bm.bitmap
	FROM		CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)			
		INNER JOIN	@virtualXML			AS tmp
				ON	cvs.seqNo = tmp.seqNo
		CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm
	WHERE	cvs.custid IN ( SELECT custid FROM #tempUpdate_tbl)

	WAITFOR DELAY '00:00:00.010'
END

DROP TABLE #tempUpdate_tbl