/*
	Created: 20191101@Eden
	Task: Alter table VRSettingHierarchy
	RM: #121876
	DB: DBCUST/CustDB
*/
USE CustDB
ALTER TABLE VRSettingHierarchy ADD BitmapOrderAutoSuspend SMALLINT
ALTER TABLE VRSettingHierarchy ADD VRAutoSuspendThreshold SMALLMONEY
GO

;WITH temp AS(
	SELECT LevelID,
	ROW_NUMBER() OVER( ORDER BY LevelID ) AS BitmapOrderAutoSuspend
	FROM VRSettingHierarchy WITH(NOLOCK)
	WHERE Bettype <> -1
)
UPDATE vr
SET BitmapOrderAutoSuspend = tmp.BitmapOrderAutoSuspend,
	VRAutoSuspendThreshold = 1.00
FROM VRSettingHierarchy vr WITH(UPDLOCK,ROWLOCK)
	INNER JOIN temp tmp ON tmp.LevelID = vr.LevelID