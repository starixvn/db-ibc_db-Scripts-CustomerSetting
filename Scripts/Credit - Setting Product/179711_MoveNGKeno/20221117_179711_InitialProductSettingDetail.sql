/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 20221117
	Task: Alter column SubType
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @SettingStatus TINYINT = 1

UPDATE ps
SET ps.SettingType = 23, 
	SettingLevel = 2,
	SubType = 1
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType = 2

DELETE FROM ProductSettingDetail WHERE ProductID = 44 AND SettingType IN (23,18) AND SportType = 220 AND BetType <> 1024
DELETE FROM ProductSettingDetail WHERE ProductID = 44 AND SettingStatus = 2

INSERT INTO ProductSettingDetail ([SettingType], [SportType], [BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden], [IsDisabled], [SettingLevel], [DisplayOrder], [SettingStatus], [IntervalValue], [RealProductId], [MaxChoice], [ProductSettingID], [Parent_ProductSettingID], [Child_DisplayOrder], [SubType])
SELECT 23,202,1501,0,44,NULL,NULL,NULL,NULL,NULL,2,2,@SettingStatus, NULL, 8, NULL,238, NULL,4,1
UNION ALL
SELECT 23,161,81,0,44,NULL,NULL,NULL,NULL,NULL,2,2,@SettingStatus, NULL, 3, NULL,239, NULL,5,2
UNION ALL
SELECT 23,164,8101,0,44,NULL,NULL,NULL,NULL,NULL,2,2,@SettingStatus, NULL, 3, NULL,240, NULL,6,2
UNION ALL
SELECT 13,161,81,0,3,NULL,NULL,1,0,0,2,1,@SettingStatus, NULL, 3, NULL,236, NULL,NULL,NULL
UNION ALL
SELECT 18,161,81,0,44,90,NULL,NULL,NULL,NULL,2,3,@SettingStatus, NULL, 3, NULL,242, NULL,6,NULL
UNION ALL
SELECT 18,202,1501,0,44,85,NULL,NULL,NULL,NULL,2,3,@SettingStatus, NULL, 8, NULL,241, NULL,5,NULL

UPDATE ps
SET SettingLevel = 2
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType = 18

UPDATE ps
SET Child_DisplayOrder =  CASE WHEN SportType = 169 THEN 1 
								WHEN SportType = 220 THEN 2
								WHEN SportType = 222 THEN 3
								WHEN SportType = 224 THEN 4
								END 
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 44 AND SettingType IN (18,23,13)


SELECT *
FROM ProductSettingDetail ps WITH (ROWLOCK)
WHERE ProductID = 44 --AND SettingType = 23

INSERT INTO ProductSettingDetail ([SettingType], [SportType], [BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden], [IsDisabled], [SettingLevel], [DisplayOrder], [SettingStatus], [IntervalValue], [RealProductId], [MaxChoice], [ProductSettingID], [Parent_ProductSettingID], [Child_DisplayOrder], [SubType])
SELECT 23, [SportType], [BetType], [IsLive], [ProductID], NULL, NULL, [IsSync], [IsHidden], [IsDisabled], [SettingLevel], [DisplayOrder], 1, [IntervalValue], [RealProductId], [MaxChoice], 
CASE WHEN ProductSettingID = 43 THEN 237
	WHEN ProductSettingID = 59 THEN 238
	WHEN ProductSettingID = 60 THEN 239
	END, 
[Parent_ProductSettingID], 
CASE WHEN ProductSettingID = 43 THEN 1
	WHEN ProductSettingID = 59 THEN 2
	WHEN ProductSettingID = 60 THEN 3
	END, 
CASE WHEN ProductSettingID = 43 THEN 1
	WHEN ProductSettingID = 59 THEN 1
	WHEN ProductSettingID = 60 THEN 1
	END 
FROM ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = 44 AND SettingType = 2 AND SettingStatus = 0
	AND ((SportType = 220 AND BetType = 1024) OR SportType <> 220)

SELECT MAX(ProductSEttingId) FROM ProductSettingDetail