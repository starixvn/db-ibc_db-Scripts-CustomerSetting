/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20220418@Elodie
    Task : Turn off  VR for Basketball for 611111 site
	All Step: 
		1. Update Super VR (Basket ball level = 0, Other level follow upline)
		2. Add all SMA Member to VRSettingManualUpdAcc table
		3. Remove all private VR setting of Master/Agent/Member level
	DB: DBCUST/CustDB
*/

CREATE TABLE #Super (CustID INT, IsUpdatedVR BIT DEFAULT 0)
INSERT INTO #Super(CustID)
SELECT custid
FROM Customer c WITH(NOLOCK)
WHERE site IN ('611111') AND roleid = 4

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


