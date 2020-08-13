/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20200811@Eden
	Task: SET VR = 0 for customers after check performance [#139229]
		Input of @Update_CustTbl table get from DW team
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO			
--SET Other sports VR Follow Upline for customers who were adjusted BasketBall VR Follow Upline
DECLARE @Update_CustTbl TABLE ( CustID INT)

--INSERT INTO @Update_CustTbl(CustID)


DECLARE @Sporttype SMALLINT = 99

--Update VR = 0 for Basket Ball (using VR2)
DECLARE @BasketBallLevelID INT
	, @ValueID_0 INT

SELECT @BasketBallLevelID = levelID
FROM VRSettingHierarchy  WITH(NOLOCK)
WHERE SportType = 2
	AND VRLeagueGroupID = -1
	AND BetType = -1

SELECT @ValueID_0 = ValueID
FROM VRValueMapping WITH(NOLOCK)
WHERE Value = 1.00 

SELECT @BasketBallLevelID = levelID
FROM VRSettingHierarchy  WITH(NOLOCK)
WHERE SportType = 2
	AND VRLeagueGroupID = -1
	AND BetType = -1

--SET basketball VR = 0 (at basketball level) 
UPDATE v
SET v.ValueIDLIVE = @ValueID_0
	,v.ValueIDNonLIVE = @ValueID_0
FROM VRCustSetting v WITH(ROWLOCK) 
	INNER JOIN @Update_CustTbl t ON v.CustID = t.CustID
WHERE v.LevelID = @BasketBallLevelID
	AND (v.ValueIDLIVE != @ValueID_0 OR v.ValueIDNonLIVE != @ValueID_0)

INSERT INTO VRCustSetting( CustID,LevelID,ValueIDLIVE,ValueIDNonLIVE) 
SELECT t.CustID,@BasketBallLevelID,@ValueID_0,@ValueID_0
FROM @Update_CustTbl t
WHERE NOT EXISTS( SELECT 1 FROM VRCustSetting v WITH(NOLOCK) WHERE v.CustID = t.CustID AND v.LevelID = @BasketBallLevelID)

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
SELECT sporttype,bettype,islive,1.00
FROM ProfileVirtualSetting 	WITH (NOLOCK)	
WHERE sporttype NOT IN (1,2,43)

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

UPDATE cvs
	SET cvs.bitmapVirtual = bm.bitmap
FROM		CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)			
	INNER JOIN	@virtualXML			AS tmp
			ON	cvs.seqNo = tmp.seqNo
	CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm
WHERE	cvs.custid IN ( SELECT custid FROM @Update_CustTbl)

--> Update Status = 4 : done update VR = 0
UPDATE v
SET v.Status = 4
FROM VRCustAutoAdjustment v WITH(ROWLOCK)
	INNER JOIN @Update_CustTbl t ON v.CustID = t.CustID
WHERE v.SportType = @Sporttype

DECLARE @NewLogData VARCHAR(MAX)
SELECT @NewLogData = '<R '
					+ 'CustIDList="'+ coalesce(cast(@CustIDList as varchar(MAX)),space(1)) + '" '
					+ 'Sporttype="'+ coalesce(cast(@Sporttype as varchar(50)),space(1)) + '" ' 
					+ ' />'

EXEC dbo.Acc_WriteLog_UserLog_RunSP_Wrapper
	@UserId				= 0,
	@ActionId			= 817,
	@TrackingValue		= @NewLogData