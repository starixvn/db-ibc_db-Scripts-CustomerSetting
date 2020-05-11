/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game CREDIT ( Loss Limit Real Currency)
	DB: DBCust/CustDB
*/
/*
DELETE  
FROM LossLimit_GlobalSetting WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 38
	AND exchangeID <> 20

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
	  AND exchangeID <> 20


