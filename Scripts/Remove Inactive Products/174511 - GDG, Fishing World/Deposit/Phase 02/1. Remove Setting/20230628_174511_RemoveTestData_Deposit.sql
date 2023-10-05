/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230628
	Task: Deposit - Delete settings for test data
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 

DELETE FROM Dep_CustStakeLevel_Member WITH (ROWLOCK)
WHERE SportType IN (219,236)

DELETE FROM Dep_CustPTSetting_Agent WITH (ROWLOCK)
WHERE SportType IN (219,236)

DELETE FROM Dep_CustDiscountSetting_Member WITH (ROWLOCK)
WHERE SportType IN (219,236)