/*
	Created: Winfred
	Date: 20200805
	Task: Update Product Setting Detail (DISABLED) Deposit [Redmine: 137763]
	DB: DBCUST/CustDB
*/

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=232
