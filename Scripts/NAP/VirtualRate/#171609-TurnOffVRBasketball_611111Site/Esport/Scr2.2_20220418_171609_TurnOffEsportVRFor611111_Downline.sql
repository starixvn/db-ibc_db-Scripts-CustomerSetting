/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20220418@Elodie
    Task : Turn off  VR for Esport for 611111 site
	All Step: 
		2. Add all SMA Member to VRSettingManualUpdAcc table
		3. Remove all private VR setting of Master/Agent/Member level
		4. Set OverrideAS = 1 ( Esport Level) for all members
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE Acc_DynamicCustSetting3rd_09
	@CustId INT,
	@RoleId TINYINT,
	@Sporttype SMALLINT = 43
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('VRSettingManualUpdAcc') = 0 RETURN
	IF dbo.f_CheckRepTable('VRCustSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingAutoSuspend') = 0 RETURN

	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY,RoleID TINYINT)

	--> Get all downline of direct account
	IF @RoleId = 4
	BEGIN
		INSERT INTO #tmpCust(CustID,roleid)
		SELECT ci.custid,ci.roleid
		FROM custinfo ci WITH(NOLOCK)
		WHERE ci.roleid IN (1,2,3)
			AND ci.srecommend = @CustId
			AND ci.enabled = 1
	END
	ELSE IF @RoleId = 3
	BEGIN
		INSERT INTO #tmpCust(CustID,roleid)
		SELECT ci.custid,ci.roleid
		FROM custinfo ci WITH(NOLOCK)
		WHERE ci.roleid IN (1,2)
			AND ci.mrecommend = @CustId
			AND ci.enabled = 1
	END
	ELSE IF @RoleId = 2
	BEGIN
		INSERT INTO #tmpCust(CustID,roleid)
		SELECT ci.custid,ci.roleid
		FROM custinfo ci WITH(NOLOCK)
		WHERE ci.roleid IN (1)
			AND ci.recommend = @CustId
			AND ci.enabled = 1
	END
	
	--Set Manual VR for all Supers
	INSERT INTO [VRSettingManualUpdAcc](CustID,SportType)
	SELECT @CustID,@Sporttype AS SportType
	WHERE NOT EXISTS (SELECT 1 FROM VRSettingManualUpdAcc WHERE custid = @CustId AND SportType = @Sporttype)

	--Set Manual VR for all Master/Agent/Member
	WHILE 1 = 1
	BEGIN
		INSERT INTO [VRSettingManualUpdAcc](CustID,SportType)
		SELECT TOP (5000) t.CustID, @Sporttype AS SportType
		FROM #tmpCust t
			LEFT JOIN [VRSettingManualUpdAcc] v WITH(NOLOCK)
				ON t.CustID = v.CustID 
				AND v.SportType = @Sporttype
		WHERE v.CustID IS NULL

		IF @@ROWCOUNT = 0
			BREAK;
	END

	DECLARE @VRCustSetting TABLE (CustID int, LevelID int)
	DECLARE @VRCustSettingBatch TABLE (CustID int, LevelID int)

	DeletePrivateVR: --Step Delete all private VR of Master/Agent/Member

	INSERT INTO @VRCustSetting(CustID,LevelID)
	SELECT vr.CustID,vr.LevelID
	FROM VRCustSetting vr WITH(NOLOCK)
		INNER JOIN VRSettingHierarchy h WITH(NOLOCK) ON vr.LevelID = h.LevelID
		INNER JOIN #tmpCust t ON vr.CustID = t.CustID
	WHERE h.SportType = @Sporttype
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
	END

	IF EXISTS(
		SELECT TOP 1 1
		FROM VRCustSetting vr WITH(NOLOCK)
			INNER JOIN VRSettingHierarchy h WITH(NOLOCK) ON vr.LevelID = h.LevelID
			INNER JOIN #tmpCust t ON vr.CustID = t.CustID
		WHERE h.SportType = @Sporttype
	)
	BEGIN
		PRINT 'Delete Again'
		GOTO DeletePrivateVR --Delete Again
	END

	IF @Sporttype = 43 --Set OverrideAS = 1 ( Esport Level) for all members
	BEGIN
		IF @roleid = 1
		BEGIN
			INSERT INTO #tmpCust(CustID,roleid)
			SELECT @custid, 1
		END

		DECLARE @OverrideAS_True varbinary(30)  = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

		WHILE 1 = 1
		BEGIN
			UPDATE TOP (5000) v
			SET OverrideASLive = @OverrideAS_True
				,OverrideASNonLive = @OverrideAS_True
			FROM #tmpCust t
				INNER JOIN CustSettingAutoSuspend v WITH(NOLOCK)
					ON t.CustID = v.CustID 
					AND v.SportType = @Sporttype
			WHERE t.roleid = 1
			AND NOT(  
					OverrideASLive = @OverrideAS_True
					AND OverrideASNonLive = @OverrideAS_True
				)

			IF @@ROWCOUNT = 0
				BREAK;
		END

		WHILE 1 = 1
		BEGIN
			INSERT INTO CustSettingAutoSuspend(CustID,SportType,AutoSuspendLive,AutoSuspendNonLive,OverrideASLive,OverrideASNonLive)
			SELECT TOP (5000) t.CustID, @Sporttype AS SportType, @OverrideAS_True, @OverrideAS_True, @OverrideAS_True, @OverrideAS_True
			FROM #tmpCust t
				LEFT JOIN CustSettingAutoSuspend v WITH(NOLOCK)
					ON t.CustID = v.CustID 
					AND v.SportType = @Sporttype
			WHERE v.CustID IS NULL
				AND t.roleid = 1

			IF @@ROWCOUNT = 0
				BREAK;
		END
	END

	DROP TABLE #tmpCust
END
GO

DECLARE @DirectCustID INT, @index INT = 0, @roleid TINYINT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, DirectCustID: %d, Sporttype: %d.'

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('611111')

CREATE TABLE #DirectAcc (CustID INT PRIMARY KEY,roleid TINYINT,IsUpdatedVR BIT DEFAULT 0)
--- get direct account
INSERT INTO #DirectAcc (CustID,roleid)
SELECT ci.custid,ci.roleid
FROM Customer ci with(nolock)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid IN (4,3,2,1)
	AND c.Enabled=1

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #DirectAcc
	SET IsUpdatedVR = 1
		,@DirectCustID = custid
		,@roleid = roleid
	WHERE IsUpdatedVR = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @DirectCustID, 43) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustId = @DirectCustID, @roleid = @roleid,@sporttype = 43 -- Esport
	waitfor delay '00:00:0.200'

	RAISERROR (@msg, 0, 1, @index, @DirectCustID, 2) WITH NOWAIT
	EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustId = @DirectCustID, @roleid = @roleid,@sporttype = 2 -- BasketBall
	waitfor delay '00:00:0.200'
END

DROP TABLE #DirectAcc
DROP TABLE #OfferedSite
GO