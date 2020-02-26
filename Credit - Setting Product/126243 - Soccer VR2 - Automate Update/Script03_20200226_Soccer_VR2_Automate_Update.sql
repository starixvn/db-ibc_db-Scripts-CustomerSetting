/*
	Created: Eden
	Date: 20200226
	Task: Soccer VR2 - Automate update from VRSetting_AutoUpdate_VirtualRate [Redmine:#126243]	
	DB: DBCust/CustDB
*/
USE CustDB
GO
SET NOCOUNT ON
;WITH VRlive AS(
	SELECT vv.CustID, 
		   vv.VRLeagueGroupID, 
		   vv.VRBetTypeGroupID, 
		   vv.BetType, 
		   vv.SportType, 
		   vv.VirtualMultiplier, 
		   h.LevelID, 
		   vrv.ValueID,
		   vr.ValueIDLIVE as OldValueID
	FROM VRSettingHierarchy h WITH(NOLOCK)
		 INNER JOIN VRSetting_AutoUpdate_VirtualRate vv WITH(NOLOCK)
		   ON h.VRLeagueGroupID = vv.VRLeagueGroupID
			  AND h.VRBetTypeGroupID = vv.VRBetTypeGroupID
			  AND h.BetType = vv.BetType
			  AND h.SportType = vv.SportType
		 LEFT JOIN VRCustSetting vr WITH(NOLOCK)
		   ON vr.CustID = vv.CustID
			  AND vr.LevelID = h.LevelID
		 LEFT JOIN VRValueMapping vrv WITH(NOLOCK)
		   ON vv.VirtualMultiplier = vrv.Value
	WHERE vv.Islive = 1
)
,VRNonlive AS
(
	SELECT vv.CustID, 
		   vv.VRLeagueGroupID, 
		   vv.VRBetTypeGroupID, 
		   vv.BetType, 
		   vv.SportType, 
		   vv.VirtualMultiplier, 
		   h.LevelID, 
		   vrv.ValueID,
		   vr.ValueIDNonLIVE as OldValueID
	FROM VRSettingHierarchy h WITH(NOLOCK)
		 INNER JOIN VRSetting_AutoUpdate_VirtualRate vv WITH(NOLOCK)
		   ON h.VRLeagueGroupID = vv.VRLeagueGroupID
			  AND h.VRBetTypeGroupID = vv.VRBetTypeGroupID
			  AND h.BetType = vv.BetType
			  AND h.SportType = vv.SportType
		 LEFT JOIN VRCustSetting vr WITH(NOLOCK)
		   ON vr.CustID = vv.CustID
			  AND vr.LevelID = h.LevelID
		 LEFT JOIN VRValueMapping vrv WITH(NOLOCK)
		   ON vv.VirtualMultiplier = vrv.Value
	WHERE vv.Islive = 0
)
,TMP AS (
	SELECT ISNULL(a1.SportType,a2.SportType) AS SportType
		,ISNULL(a1.CustID,a2.CustID) AS CustID
		,ISNULL(a1.LevelID,a2.LevelID) AS LevelID
		,ISNULL(a1.ValueID,0) AS ValueIDLive 
		,ISNULL(a2.ValueID,0) AS ValueIDNonLive
	FROM VRlive a1
		FULL OUTER JOIN VRNonlive a2
			ON a1.CustID = a2.CustID
			AND a1.VRLeagueGroupID = a2.VRLeagueGroupID 
			AND a1.VRBetTypeGroupID = a2.VRBetTypeGroupID
			AND a1.BetType = a2.BetType
			AND a1.SportType = a2.SportType
	WHERE ISNULL(a1.ValueID,0) <> ISNULL(a1.OldValueID,0)
		  OR ISNULL(a2.ValueID,0) <> ISNULL(a2.OldValueID,0)
)
SELECT  SportType
		,CustID
		,CONVERT(VARCHAR(MAX),(SELECT LevelID,ValueIDLive,ValueIDNonLive FROM TMP b WHERE a.CustID = b.CustID FOR XML RAW('Row'), ROOT ('Root')))  AS VirtualMultiplier
		,0 AS IsProcessed
INTO #VRUpdated
FROM TMP a
GROUP BY SportType,CustID

DECLARE @CustID INT
	, @SportType INT 
	, @VirtualMultiplier VARCHAR(MAX) = ''
	, @UserID INT = 8
	, @IP VARCHAR(15) = '0.0.0.0'
	, @ErrCode INT = 0
	, @ErrMsg NVARCHAR(200) = ''

WHILE 1 = 1
BEGIN
	UPDATE TOP (1) #VRUpdated 
	SET @CustID = custID,
		@SportType = SportType,
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
		PRINT 'CustID = ' + CONVERT (VARCHAR(10),@CustID) + ' - ' + ' - SUCCEED'
END
DROP TABLE #VRUpdated
