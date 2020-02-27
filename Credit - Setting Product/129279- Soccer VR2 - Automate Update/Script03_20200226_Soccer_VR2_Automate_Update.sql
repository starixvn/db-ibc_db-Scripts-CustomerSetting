/*
	Created: Eden
	Date: 20200226
	Task: Soccer VR2 - Automate update from VRSettingAutoUpdate [Redmine:#129279]	
	DB: DBCust/CustDB
*/
USE CustDB
GO
SET NOCOUNT ON

DECLARE @SportType INT = 1

IF EXISTS ( SELECT TOP 1 1
			FROM VRSettingAutoUpdate vv WITH(NOLOCK)
				LEFT JOIN VRValueMapping vrv WITH(NOLOCK)
					ON vv.VirtualMultiplier = vrv.Value
			WHERE vrv.ValueID IS NULL
	)
BEGIN
	PRINT 'VirtualMultiplier of VRSettingAutoUpdate is not valid' 
	RETURN
END

;WITH VRlive AS(
	SELECT vv.CustID, 
		   h.LevelID, 
		   vrv.ValueID
	FROM VRSettingHierarchy h WITH(NOLOCK)
		 INNER JOIN VRSettingAutoUpdate vv WITH(NOLOCK)
		   ON h.VRLeagueGroupID = vv.VRLeagueGroupID
			  AND h.VRBetTypeGroupID = vv.VRBetTypeGroupID
			  AND h.BetType = vv.BetType
			  AND h.SportType = vv.SportType
		 LEFT JOIN VRCustSetting vr WITH(NOLOCK)
		   ON vr.CustID = vv.CustID
			  AND vr.LevelID = h.LevelID
		 INNER JOIN VRValueMapping vrv WITH(NOLOCK)
		   ON vv.VirtualMultiplier = vrv.Value
	WHERE vv.Islive = 1
		AND (vrv.ValueID <> ISNULL(vr.ValueIDLIVE,0) 
			 OR (vv.CustId = 0 AND h.LevelID IN (154,1))
		)
		AND vv.SportType = @SportType
)
,VRNonlive AS
(
	SELECT vv.CustID, 
		   h.LevelID, 
		   vrv.ValueID
	FROM VRSettingHierarchy h WITH(NOLOCK)
		 INNER JOIN VRSettingAutoUpdate vv WITH(NOLOCK)
		   ON h.VRLeagueGroupID = vv.VRLeagueGroupID
			  AND h.VRBetTypeGroupID = vv.VRBetTypeGroupID
			  AND h.BetType = vv.BetType
			  AND h.SportType = vv.SportType
		 LEFT JOIN VRCustSetting vr WITH(NOLOCK)
		   ON vr.CustID = vv.CustID
			  AND vr.LevelID = h.LevelID
		 INNER JOIN VRValueMapping vrv WITH(NOLOCK)
		   ON vv.VirtualMultiplier = vrv.Value
	WHERE vv.Islive = 0
		AND (vrv.ValueID <> ISNULL(vr.ValueIDNonLIVE,0)
			 OR (vv.CustId = 0 AND h.LevelID IN (154,1))
		)
		AND vv.SportType = @SportType
)
,TMP1 AS (
	SELECT ISNULL(a1.CustID,a2.CustID) AS CustID
		,ISNULL(a1.LevelID,a2.LevelID) AS LevelID
		,ISNULL(a1.ValueID,0) AS ValueIDLive 
		,ISNULL(a2.ValueID,0) AS ValueIDNonLive
	FROM VRlive a1
		FULL OUTER JOIN VRNonlive a2
			ON a1.CustID = a2.CustID
			AND a1.LevelID = a2.LevelID
)
,TMP AS(
	SELECT CustID,LevelID,ValueIDLive,ValueIDNonLive FROM TMP1 
	UNION ALL
	SELECT vr.CustID,vr.LevelID,vr.ValueIDLive,vr.ValueIDNonLive
	FROM VRCustSetting vr WITH(NOLOCK)
		INNER JOIN VRSettingHierarchy h ON h.LevelID = vr.LevelID AND h.SportType = @SportType
	WHERE EXISTS (SELECT 1 FROM  tmp1 t WHERE t.CustID = vr.CustID)
		AND NOT EXISTS (SELECT 1 FROM  tmp1 t WHERE t.CustID = vr.CustID AND t.LevelID = vr.LevelID)
)
SELECT   CustID
		,CONVERT(VARCHAR(MAX),(SELECT LevelID,ValueIDLive,ValueIDNonLive FROM TMP b WHERE a.CustID = b.CustID FOR XML RAW('Row'), ROOT ('Root')))  AS VirtualMultiplier
		,0 AS IsProcessed
INTO #VRUpdated
FROM TMP a
GROUP BY CustID

DECLARE @CustID INT
	, @VirtualMultiplier VARCHAR(MAX) = ''
	, @UserID INT = 8
	, @IP VARCHAR(15) = '0.0.0.0'
	, @ErrCode INT = 0
	, @ErrMsg NVARCHAR(200) = ''

WHILE 1 = 1
BEGIN
	UPDATE TOP (1) #VRUpdated 
	SET @CustID = custID,
		@VirtualMultiplier = VirtualMultiplier,
		IsProcessed = 1
	WHERE IsProcessed = 0

	IF @@ROWCOUNT = 0
		BREAK;

	EXEC [Acc_CustVirtualMultiplier_Upd]
		  @CustID = @CustID
		, @SportType = @SportType
		, @VirtualMultiplier = @VirtualMultiplier
		, @UserID  = @UserID
		, @IP  = @IP
		, @ErrCode = @ErrCode OUT
		, @ErrMsg = @ErrMsg OUT

	IF @ErrCode <> 0
		--print error
		PRINT 'CustID = ' + CONVERT (VARCHAR(10),@CustID) + ' - ' + @ErrMsg 
	ELSE 
		PRINT 'CustID = ' + CONVERT (VARCHAR(10),@CustID) + ' - SUCCEED'
END
DROP TABLE #VRUpdated
