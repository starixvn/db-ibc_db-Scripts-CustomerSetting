/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20220418@Elodie
    Task : Turn off  VR for Esport for 611111 site
	All Step: 
		1. Update Super VR (Esport level = 0, Other level follow upline)
		   Update Super VR (Basket Ball level = 0 if Super/Direct acc created after 2022/04/18)
	DB: DBCUST/CustDB
*/
CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('611111')

CREATE TABLE #DirectAcc (CustID INT PRIMARY KEY,IsUpdatedVR BIT DEFAULT 0, IsNewCust BIT)
--- get direct account
INSERT INTO #DirectAcc (CustID,IsNewCust)
SELECT ci.custid,
	CASE WHEN ci.creatdate >= '2022/04/18' -- the day we run script update VR = 0 for Basket ball
		 THEN 1 ELSE 0 END AS IsNewCust
FROM Customer ci with(nolock)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid IN (4,3,2,1)
	AND c.Enabled=1

--> XML to update Esport level VR = 0
DECLARE @VirtualMultiplier VARCHAR(MAX)
SELECT @VirtualMultiplier = CONVERT(VARCHAR(MAX),(  SELECT b.LevelID,vr.ValueID AS ValueIDLive,vr.ValueID AS ValueIDNonLive 
															FROM VRSettingHierarchy b WITH(NOLOCK) 
																CROSS APPLY VRValueMapping vr (NOLOCK)
															WHERE b.SportType = 43 
																AND b.VRLeagueGroupID = -1 
																AND b.BetType = -1 
																AND vr.Value = 1
															FOR XML RAW('Row'), ROOT ('Root'))
											)

DECLARE @VirtualMultiplier2 VARCHAR(MAX)
SELECT @VirtualMultiplier2 = CONVERT(VARCHAR(MAX),(  SELECT b.LevelID,vr.ValueID AS ValueIDLive,vr.ValueID AS ValueIDNonLive 
															FROM VRSettingHierarchy b WITH(NOLOCK) 
																CROSS APPLY VRValueMapping vr (NOLOCK)
															WHERE b.SportType = 2 
																AND b.VRLeagueGroupID = -1 
																AND b.BetType = -1 
																AND vr.Value = 1
															FOR XML RAW('Row'), ROOT ('Root'))
											)

DECLARE @ErrCode INT, @ErrMsg NVARCHAR(200), @CustID INT, @IsNewCust BIT

WHILE 1 = 1
BEGIN
	SELECT  @ErrCode = 0, @ErrMsg = ''

	UPDATE TOP(1) t
	SET IsUpdatedVR = 1,
		@CustID = t.CustID,
		@IsNewCust = t.CustID
	FROM #DirectAcc t
	WHERE IsUpdatedVR = 0

	IF @@ROWCOUNT = 0
		BREAK;

	EXEC [Acc_CustVirtualMultiplier_Upd]
			  @CustID = @CustID
			, @SportType = 43
			, @VirtualMultiplier = @VirtualMultiplier
			, @UserID  = 10278938 --starixIT
			, @IP  = ''
			, @ErrCode = @ErrCode OUT
			, @ErrMsg = @ErrMsg OUT

	IF @ErrCode <> 0
	BEGIN
		SELECT @CustID AS CustID, @ErrCode ASErrCode, @ErrMsg AS ErrMsg , 43 AS Sporttype
	END

	IF @IsNewCust = 1
	BEGIN 
		EXEC [Acc_CustVirtualMultiplier_Upd]
			  @CustID = @CustID
			, @SportType = 2
			, @VirtualMultiplier = @VirtualMultiplier2
			, @UserID  = 10278938 --starixIT
			, @IP  = ''
			, @ErrCode = @ErrCode OUT
			, @ErrMsg = @ErrMsg OUT

		IF @ErrCode <> 0
		BEGIN
			SELECT @CustID AS CustID, @ErrCode ASErrCode, @ErrMsg AS ErrMsg , 2 AS Sporttype
		END
	END
END


DROP TABLE #OfferedSite
DROP TABLE #DirectAcc