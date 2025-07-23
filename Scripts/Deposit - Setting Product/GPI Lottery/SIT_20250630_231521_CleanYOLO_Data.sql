/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250627
	Task: SIT - Clean old data - YOLO [Redmine: #231521] 
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--Delete setting:
DELETE d
OUTPUT deleted.Sporttype, deleted.Bettype, dbo.f_GetDateTime2()
INTO Dep_ProductStatusProfile_Del_InHouse (Sporttype, Bettype, RepUpdateTime)
FROM Dep_ProductStatusProfile d WITH (ROWLOCK)
WHERE Sporttype=189

DELETE d
OUTPUT deleted.ProductSettingID, dbo.f_GetDateTime2()
INTO Dep_ProductSetting_Del_InHouse (ProductSettingID, RepUpdateTime)
FROM [Dep_ProductSetting] d WITH (ROWLOCK)
WHERE ProductSettingID in (191,192)

DELETE d
OUTPUT deleted.ProductSettingID, deleted.Sporttype, deleted.Bettype, deleted.IsLive, dbo.f_GetDateTime2()
INTO Dep_ProductSettingDetail_Del_InHouse (ProductSettingID,Sporttype, Bettype, IsLive, RepUpdateTime)
FROM Dep_ProductSettingDetail d WITH (ROWLOCK)
WHERE ProductSettingID in (191,192) 

-------------------------------------------------------------
-- ProductStakeLevelGroup
UPDATE ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET isDeleted=1
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE Sporttype=189
GO

-- Dep_ProductStakeLevelGroup
UPDATE Dep_ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET isDeleted=1
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE Sporttype=189
GO

-- SportBettypeSettingMatrix
UPDATE SportBettypeSettingMatrix WITH (ROWLOCK, UPDLOCK)
SET isDeleted=1
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE Sporttype=189
GO