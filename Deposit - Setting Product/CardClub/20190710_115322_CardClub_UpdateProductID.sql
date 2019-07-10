/*
	Created: 20190710@Winnie
	Task: DCS Deposit for CardClub. Update ProductID - [Redmine:#115322]
		Insert Master Data:
	DB: Run at DBCust.CustDB
*/  
UPDATE Dep_ProductSetting WITH(ROWLOCK,UPDLOCK)
	SET ProductID=34 
WHERE ProductID=33 AND ProductSettingID IN(26,27,28)