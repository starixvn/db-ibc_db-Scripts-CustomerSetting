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
ALTER PROCEDURE Acc_DynamicCustSetting3rd_09
	@CustId INT,
	@RoleId TINYINT
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('VRSettingManualUpdAcc') = 0 RETURN
	IF dbo.f_CheckRepTable('VRCustSetting') = 0 RETURN

	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY)

	--> Get all downline of direct account
	IF @RoleId = 3
	BEGIN
		INSERT INTO #tmpCust(CustID)
		SELECT ci.custid
		FROM custinfo ci WITH(NOLOCK)
		WHERE ci.roleid IN (1,2)
			AND ci.mrecommend = @CustId
	END
	ELSE IF @RoleId = 2
	BEGIN
		INSERT INTO #tmpCust(CustID)
		SELECT ci.custid
		FROM custinfo ci WITH(NOLOCK)
		WHERE ci.roleid IN (1)
			AND ci.recommend = @CustId
	END
	
	--Set Manual VR for all Supers
	INSERT INTO [VRSettingManualUpdAcc](CustID,SportType)
	SELECT @CustID,2 AS SportType
	WHERE NOT EXISTS (SELECT 1 FROM VRSettingManualUpdAcc WHERE custid = @CustId AND SportType = 2)

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

	DROP TABLE #tmpCust
END
GO

DECLARE @srecommend INT, @index INT = 0, @roleid TINYINT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('611111')

SELECT DISTINCT srecommend INTO #DummyAcc
FROM CustDirectAccount da WITH (NOLOCK)
	INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid
WHERE ci.site IN (SELECT site FROM #OfferedSite)
	AND ci.roleid IN (2, 3, 1)

CREATE TABLE #DirectAcc (CustID INT PRIMARY KEY, roleid TINYINT, IsUpdatedVR BIT DEFAULT 0)
--- get direct account
INSERT INTO #DirectAcc (CustID, roleid)
SELECT ci.custid, ci.roleid
FROM Customer ci with(nolock)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid IN (3,2) AND ci.srecommend IN (SELECT srecommend FROM #DummyAcc)
	AND c.Enabled=1


WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #DirectAcc
	SET IsUpdatedVR = 1
		,@srecommend = custid
		,@roleid = roleid
	WHERE IsUpdatedVR = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustId = @srecommend, @roleid = @roleid
	waitfor delay '00:00:0.200'
END

DROP TABLE #DirectAcc
GO