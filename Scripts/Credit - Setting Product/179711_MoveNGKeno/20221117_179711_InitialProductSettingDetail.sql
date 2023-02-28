/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 20221117
	Task: Init global setting for UAT table [#179711]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @SettingStatus TINYINT = 0

UPDATE ps
SET ps.SettingType = 23, 
	--SettingLevel = 2,
	SubType = 1
FROM ProductSettingDetail_UAT ps WITH (ROWLOCK)
WHERE ProductID = 44 
	AND SettingType = 2
	AND SportType NOT IN(164,161)

DELETE FROM ProductSettingDetail_UAT WHERE ProductID = 44 AND SportType IN (161,164,202)

INSERT INTO ProductSettingDetail_UAT ([SettingType], [SportType], [BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden], [IsDisabled], [SettingLevel], [DisplayOrder], [SettingStatus], [IntervalValue], [RealProductId], [MaxChoice], [ProductSettingID], [Parent_ProductSettingID], [Child_DisplayOrder], [SubType])
--Status
SELECT 13,161,81,0,44,NULL,NULL,1,0,0,2,1,@SettingStatus, NULL, 3, NULL,236, NULL,6,NULL
UNION ALL
SELECT 13,202,1501,0,44,NULL,NULL,1,0,0,2,1,@SettingStatus, NULL, 8, NULL,237, NULL,5,NULL
UNION ALL
--Bet Setting
SELECT 23,202,1501,0,44,NULL,NULL,NULL,NULL,NULL,2,2,@SettingStatus, NULL, 8, NULL,238, NULL,4,1
UNION ALL
SELECT 23,161,81,0,44,NULL,NULL,NULL,NULL,NULL,2,2,@SettingStatus, NULL, 3, NULL,239, NULL,5,2
UNION ALL
SELECT 23,164,8101,0,44,NULL,NULL,NULL,NULL,NULL,2,2,@SettingStatus, NULL, 3, NULL,240, NULL,6,2
UNION ALL
-- PT
SELECT 18,202,1501,0,44,85,NULL,NULL,NULL,NULL,2,3,@SettingStatus, NULL, 8, NULL,241, NULL,5,NULL
UNION ALL
SELECT 18,161,81,0,44,90,NULL,NULL,NULL,NULL,2,3,@SettingStatus, NULL, 3, NULL,242, NULL,6,NULL

UPDATE ps
SET Child_DisplayOrder =  CASE WHEN SportType = 169 THEN 1 
								WHEN SportType = 220 THEN 2
								WHEN SportType = 222 THEN 3
								WHEN SportType = 224 THEN 4
								ELSE Child_DisplayOrder
								END 
FROM ProductSettingDetail_UAT ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType IN (18,23,13)

DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE [bitmapOrder] IN (40,41)

INSERT INTO ProductStatusProfile ([Sporttype], [Bettype], [bitmapOrder])
SELECT 161, 81, 41 UNION ALL
SELECT 202, 1501, 40

/* Testting
SELECT *
FROM ProductSettingDetail_UAT ps WITH (ROWLOCK)
WHERE ProductID = 44 

SELECT * FROM ProductStatusProfile (NOLOCK) WHERE [bitmapOrder] IN(40,41)
*/