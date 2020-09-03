/*
	Created: Winfred
	Date: 20200805
	Task: Update Product Setting Detail (UAT)  Deposit [Redmine: 137763]
	DB: DBCUST/CustDB
*/

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=1
WHERE SportType=232
