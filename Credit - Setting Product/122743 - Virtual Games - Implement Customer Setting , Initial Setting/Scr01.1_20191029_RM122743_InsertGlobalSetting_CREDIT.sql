/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game CREDIT
	DB: DBCust/CustDB
*/
/*
DELETE  
FROM ProductSettingDetail WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 245

DELETE  
FROM ProductStatusProfile WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 245


*/
--> ProductSettingDetail
INSERT INTO ProductSettingDetail(
	 SettingType
	,SportType
	,BetType
	,IsLive
	,ProductID
	,MaxPT
	,MaxDiscount
	,IsSync
	,IsHidden
	,IsDisabled
	,SettingLevel
	,DisplayOrder
	,SettingStatus
	,IntervalValue
	)
		  SELECT 13, 245, 4601, 0, 38, NULL, NULL,    1,    0,    0, 1, 1, 1, NULL --Product Status
UNION ALL SELECT 1 , 245, 4601, 0, 38, 90  , NULL, NULL, NULL, NULL, 1, 2, 1, NULL --PT
UNION ALL SELECT 6 , 245, 4601, 0, 38, NULL, NULL, NULL, NULL, NULL, 1, 3, 1, NULL --SMA Win/Loss Limit
UNION ALL SELECT 7 , 245, 4601, 0, 38, NULL, NULL, NULL, NULL, NULL, 3, 4, 1, NULL --Bet Setting

--> ProductStatusProfile
INSERT INTO ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT 245,4601,19

