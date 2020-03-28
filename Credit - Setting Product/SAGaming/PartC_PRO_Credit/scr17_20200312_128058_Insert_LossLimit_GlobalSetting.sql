/*
	Created: 20200312@Tiara
	Date: 20200312
	Task: Insert LossLimit_GlobalSetting [Redmine: #128058]
	DB: DBCUST/CustDB
*/

INSERT INTO LossLimit_GlobalSetting (ProductId,ExchangeId,MinLossLimit,DefaultLossLimit)
SELECT 41,72,100,122400