/*
	Created: Eden
	Date: 20200507
	Task: INSERT Global setting for Virtual game CREDIT -XocDia
	DB: DBCust/CustDB
*/
/*
DELETE  
--SELECT *
FROM ProductSettingDetail WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 245 AND bettype = 4602 AND Settingtype = 7

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
	,RealProductId
	)
SELECT 7 , 245, 4602, 0, 38, NULL, NULL, NULL, NULL, NULL, 4, 4, 1, NULL,38 --Bet Setting

