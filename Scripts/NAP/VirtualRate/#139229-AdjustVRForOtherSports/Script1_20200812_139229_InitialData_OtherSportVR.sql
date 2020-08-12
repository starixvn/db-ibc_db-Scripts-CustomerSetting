/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20200811@Eden
	Task: SET Other sports VR = 0 for customers who were adjusted BasketBall VR = 0
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO		

DECLARE @Update_CustTbl TABLE ( CustID INT)

INSERT INTO @Update_CustTbl(CustID)
SELECT CustID
FROM VRCustAutoAdjustment WITH(NOLOCK) 
WHERE SportType = 2 AND Status = 2

DECLARE	@tblVirtualrate		TABLE (
							CustID				INT
						,	SportType			INT
						,	BetType				INT
						,	IsLive				BIT
						,	VirtualMultiplier	SMALLMONEY	
						);
										
INSERT INTO	@tblVirtualrate (CustID,SportType,BetType,IsLive,VirtualMultiplier)
SELECT	sporttype,bettype,islive,1.00
FROM ProfileVirtualSetting 	WITH (NOLOCK)	
WHERE sporttype NOT IN (1,2,43)

DECLARE	@virtualXML	TABLE (
						seqNo		TINYINT
					,	Pos			VARBINARY(64)
					,	Val			VARBINARY(64)
					,	CustID		INT
					);
										
INSERT INTO @virtualXML(CustID,seqNo, Pos, Val)
SELECT	t.CustID, pvs.seqNo, p1.Pos, p2.Val
FROM @Update_CustTbl t 
		CROSS APPLY (
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
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.CustID = t.CustID
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
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.CustID = t.CustID
				FOR XML PATH ('')						
			), 2) AS Val
		) p2

UPDATE cvs
SET cvs.bitmapVirtual = bm.bitmap
FROM CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)			
	INNER JOIN	@virtualXML	AS tmp
			ON	cvs.seqNo = tmp.seqNo
			AND cvs.custid = tmp.CustID
	CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm