/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20220406@Eden    
    Task : Turn off  VR for Basketball for Selected Supers: 
		OkadaSuperWon
		BPLESuperWon
		liv66SWSuperUSDT
		US8YAYOUSuperUSDT
		HaifaSuperRMB 

		All Step: 
			1. Update Super VR (Basket ball level = 0, Other level follow upline)
			2. Add all SMA Member to VRSettingManualUpdAcc table
			3. Remove all private VR setin of Master/Agent/Member level
    DB: DBCUST/CustDB
*/
CREATE TABLE #Super (CustID INT, IsUpdatedVR BIT DEFAULT 0)
CREATE TABLE #tmpCust (CustID INT PRIMARY KEY)

INSERT INTO #Super(CustID)
SELECT custid
FROM dep_custsuper WITH(NOLOCK)
WHERE username IN('OkadaSuperWon', 'BPLESuperWon', 'liv66SWSuperUSDT', 'US8YAYOUSuperUSDT', 'HaifaSuperRMB')

DECLARE @ValueID_0 INT
DECLARE @BasketBallLevelID INT

--Update VR = 0 for Basket Ball (using VR2)
SELECT @BasketBallLevelID = levelID
FROM VRSettingHierarchy  WITH(NOLOCK)
WHERE SportType = 2
	AND VRLeagueGroupID = -1
	AND BetType = -1 

SELECT @ValueID_0 = ValueID
FROM VRValueMapping WITH(NOLOCK)
WHERE Value = 1.00

--> XML to update Basket ball level VR = 0
DECLARE @VirtualMultiplier VARCHAR(MAX) = '<Root><Row LevelID="'+ CONVERT(VARCHAR,@BasketBallLevelID)  +'" ValueIDLive="'+ CONVERT(VARCHAR,@ValueID_0) +'" ValueIDNonLive="'+ CONVERT(VARCHAR,@ValueID_0) +'" /> </Root>'	
DECLARE @ErrCode INT, @ErrMsg NVARCHAR(200), @CustID INT

WHILE 1 = 1
BEGIN
	SELECT  @ErrCode = 0, @ErrMsg = ''

	UPDATE TOP(1) t
	SET IsUpdatedVR = 1,
		@CustID = t.CustID
	FROM #Super t
	WHERE IsUpdatedVR = 0

	IF @@ROWCOUNT = 0
		BREAK;

	EXEC [Acc_CustVirtualMultiplier_Upd]
			  @CustID = @CustID
			, @SportType = 2
			, @VirtualMultiplier = @VirtualMultiplier
			, @UserID  = 10278938 --starixIT
			, @IP  = ''
			, @ErrCode = @ErrCode OUT
			, @ErrMsg = @ErrMsg OUT

	IF @ErrCode <> 0
	BEGIN
		SELECT @CustID, @ErrCode, @ErrMsg
	END
END

--> Get all Master/Agent/Member of those Supers
INSERT INTO #tmpCust(CustID)
SELECT ci.custid
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN #Super sp  ON ci.srecommend = sp.CustID
WHERE ci.roleid IN (1,2,3)

--Set Manual VR for all Supers
INSERT INTO [VRSettingManualUpdAcc](CustID,SportType)
SELECT t.CustID,2 AS SportType
FROM #Super t
	LEFT JOIN [VRSettingManualUpdAcc] v WITH(NOLOCK)
		ON t.CustID = v.CustID 
		AND v.SportType = 2
WHERE v.CustID IS NULL

--Set Manual VR for all Master/Agent/Member
WHILE 1 = 1
BEGIN
	INSERT INTO [VRSettingManualUpdAcc](CustID,SportType)
	SELECT TOP (5000) t.CustID, 2 AS SportType
	FROM #tmpCust t
		LEFT JOIN [VRSettingManualUpdAcc] v WITH(NOLOCK)
			ON t.CustID = v.CustID 
			AND v.SportType = 2
	WHERE v.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK;

	WAITFOR DELAY '00:00:00.010'
END

DECLARE @VRCustSetting TABLE (CustID int, LevelID int)
DECLARE @VRCustSettingBatch TABLE (CustID int, LevelID int)

DeletePrivateVR: --Step Delete all private VR of Master/Agent/Member

INSERT INTO @VRCustSetting(CustID,LevelID)
SELECT vr.CustID,vr.LevelID
FROM VRCustSetting vr WITH(NOLOCK)
	INNER JOIN VRSettingHierarchy h WITH(NOLOCK) ON vr.LevelID = h.LevelID
	INNER JOIN #tmpCust t ON vr.CustID = t.CustID
WHERE h.SportType = 2
ORDER by vr.CustID,VR.LevelID

--Delete all private VR of Master/Agent/Member( VR will follow  their Super)
WHILE 1 = 1
BEGIN
	DELETE FROM @VRCustSettingBatch

	DELETE TOP(5000) t
	OUTPUT deleted.CustID,deleted.LevelID INTO @VRCustSettingBatch(CustID,LevelID)
	FROM @VRCustSetting t

	IF @@ROWCOUNT = 0
		BREAK;

	DELETE vr
	FROM VRCustSetting vr WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @VRCustSettingBatch t 
			ON vr.CustID = t.CustID
			AND vr.LevelID = t.LevelID

	WAITFOR DELAY '00:00:00.010'
END

IF EXISTS(
	SELECT TOP 1 1
	FROM VRCustSetting vr WITH(NOLOCK)
		INNER JOIN VRSettingHierarchy h WITH(NOLOCK) ON vr.LevelID = h.LevelID
		INNER JOIN #tmpCust t ON vr.CustID = t.CustID
	WHERE h.SportType = 2
)
BEGIN
	PRINT 'Delete Again'
	GOTO DeletePrivateVR --Delete Again
END

DROP TABLE #Super
DROP TABLE #tmpCust