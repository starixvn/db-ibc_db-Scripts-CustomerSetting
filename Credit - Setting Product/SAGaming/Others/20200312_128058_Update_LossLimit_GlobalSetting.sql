/*
	Created: 20200312@Tiara
	Date: 20200312
	Task: Update LossLimit_GlobalSetting [Redmine: #128058]
	DB: DBCUST/CustDB
*/


UPDATE L
SET L.ProductId = 41
FROM LossLimit_GlobalSetting L WITH (ROWLOCK,UPDLOCK)
WHERE L.ProductId = 21