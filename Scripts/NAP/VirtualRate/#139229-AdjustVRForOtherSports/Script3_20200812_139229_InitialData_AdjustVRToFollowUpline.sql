/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20200811@Eden
	Task: SET VR Follow upline for customers after check performance [#139229]
		Input of @Update_CustTbl table get from DW team
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO			
--SET Other sports VR Follow Upline for customers who were adjusted BasketBall VR Follow Upline
DECLARE @Update_CustTbl TABLE ( CustID INT, AgentID INT, Islog BIT DEFAULT 0)

--INSERT INTO @Update_CustTbl(CustID) 

UPDATE t
SET t.AgentID = c.recommend
FROM @Update_CustTbl t
		INNER JOIN custInfo c WITH(NOLOCK) ON t.custid = c.custid AND c.roleid = 1

DECLARE @BasketBallLevelID INT, @Sporttype SMALLINT = 99

SELECT @BasketBallLevelID = levelID
FROM VRSettingHierarchy  WITH(NOLOCK)
WHERE SportType = 2
	AND VRLeagueGroupID = -1
	AND BetType = -1

--SET basketball VR = follow upline (at basketball level) 
DELETE vr
FROM VRCustSetting vr WITH(ROWLOCK)
	INNER JOIN @Update_CustTbl t ON vr.CustID = t.CustID 
WHERE vr.LevelID = @BasketBallLevelID

DECLARE	@tblVirtualrate		TABLE (
							CustID				INT
						,	SportType			INT
						,	BetType				INT
						,	IsLive				BIT
						,	VirtualMultiplier	SMALLMONEY	
						);
										
INSERT INTO	@tblVirtualrate (CustID,SportType,BetType,IsLive,VirtualMultiplier)
SELECT t.custid, 
		pvs.sporttype, 
		pvs.bettype, 
		pvs.islive, 
		dbo.f_GetVirtualSetting(cvs.bitmapVirtual, pvs.profileID) AS virtualMultiplier
FROM @Update_CustTbl t 
	INNER JOIN CustVirtualSetting AS cvs WITH(NOLOCK)
		ON cvs.custid = t.AgentID
	INNER JOIN ProfileVirtualSetting AS pvs WITH(NOLOCK)
		ON cvs.seqNo = pvs.seqNo
WHERE pvs.sporttype NOT IN(1, 2, 43);

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

--> Update Status = 3 : done update VR follow parent
UPDATE v
SET v.Status = 3
FROM VRCustAutoAdjustment v WITH(ROWLOCK)
	INNER JOIN @Update_CustTbl t ON v.CustID = t.CustID
WHERE v.SportType = @Sporttype

DECLARE @LogData VARCHAR(MAX)
DECLARE @CustID INT

WHILE 1 = 1
BEGIN
	UPDATE TOP (1) @Update_CustTbl
	SET IsLog = 1,
		@CustID = CustID
	WHERE IsLog = 0

	IF @@ROWCOUNT = 0
		BREAK;

	SELECT @LogData = '<R '
					+ 'Sporttype="'+ coalesce(cast(@Sporttype as varchar(50)),space(1)) + '" ' 
					+ ' />'
		
	EXEC dbo.Acc_WriteLog_UserLog_RunSP_Wrapper
		@UserId				= 0,
		@CustID             = @CustID,
		@ActionId			= 816,
		@TrackingValue		= @LogData
END

DECLARE @Update_CustIDList VARCHAR(MAX) = ''

SELECT @Update_CustIDList = @Update_CustIDList + ',' + convert(varchar,CustID)
FROM @Update_CustTbl

SELECT @Update_CustIDList = STUFF(@Update_CustIDList,1,1,'')

DECLARE @NewLogData VARCHAR(MAX)
SELECT @NewLogData = '<R '
					+ 'InputCustIDList="'+ coalesce(cast(@Update_CustIDList as varchar(MAX)),space(1)) + '" '
					+ 'UpdatedCustIDList="'+ coalesce(cast(@Update_CustIDList as varchar(MAX)),space(1)) + '" '
					+ 'Sporttype="'+ coalesce(cast(@Sporttype as varchar(50)),space(1)) + '" ' 
					+ ' />'

EXEC dbo.Acc_WriteLog_UserLog_RunSP_Wrapper
	@UserId				= 0,
	@ActionId			= 815,
	@TrackingValue		= @NewLogData
