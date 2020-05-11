/*
	Created: Eden
	Date: 20200507
	Task: INSERT Global setting for Virtual game DEPOSIT -XocDia
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
--Cleanup Data
DELETE  
FROM Dep_ProductSettingDetail WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 245 AND bettype = 4602

--> Insert new data
-->Dep_ProductSettingDetail
INSERT INTO Dep_ProductSettingDetail(
	 ProductSettingID
	,SportType
	,BetType
	,IsLive
	,MaxDefaultValue
	,SettingStatus
	,MinDefaultValue
	,IsApplyBA
	)
SELECT 34, 245, 4602, 0, 0, 1, NULL, 0

