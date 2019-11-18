/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game CREDIT ( Loss Limit , StakeLevel UUS)
	DB: DBCust/CustDB
*/
/*
DELETE  
FROM LossLimit_GlobalSetting WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 38
	AND exchangeID = 20

DELETE  
FROM StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4601
	  AND exchangeid = 20


*/
--> LossLimit_GlobalSetting
INSERT INTO LossLimit_GlobalSetting 
(
	 ProductId
	,ExchangeId
	,MinLossLimit
	,DefaultLossLimit
)
SELECT 38
	,ExchangeId
	,MinLossLimit
	,DefaultLossLimit
FROM LossLimit_GlobalSetting WITH(NOLOCK) 
WHERE ProductId = 22
	  AND exchangeID = 20

GO

--> Stake level
INSERT INTO StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT GameTypeID = 4601
	,ExchangeId = e.exchangeid
	,ResourceId = NULL
	,GameGroupID = gg.GameGroupID --Cred
FROM exchange e WITH(NOLOCK) 
	CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 0) gg
	LEFT JOIN StakeLevel s WITH(NOLOCK) ON e.exchangeid = s.ExchangeId AND s.GameTypeID = 4601
WHERE e.ExchangeId = 20 --UUS
	AND s.ExchangeId IS NULL

GO
