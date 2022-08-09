/*<info serverAlias="DBTXN-custDB"></info>*/
/*
	Created: Elodie
	Date: 20220706
	Task: Drop unused table
	DB: DBTXN/CustDB
*/
USE CustDB

EXEC sp_rename '__Temp_customer_syncUpd_xtest_20191042', 'DEL___Temp_customer_syncUpd_xtest_20191042'
EXEC sp_rename '__Temp_ExchangeDailyOanda_syncUpd_xtest_20191041', 'DEL___Temp_ExchangeDailyOanda_syncUpd_xtest_20191041'
EXEC sp_rename 'Acc_ClearBalanceList', 'DEL_Acc_ClearBalanceList'
EXEC sp_rename 'cust_followBet_bk', 'DEL_cust_followBet_bk'
EXEC sp_rename 'Cust_FollowBet_xtest', 'DEL_Cust_FollowBet_xtest'
EXEC sp_rename 'Cust12Bet', 'DEL_Cust12Bet'
EXEC sp_rename 'custsettingGame_AccYen668', 'DEL_custsettingGame_AccYen668'
EXEC sp_rename 'ExchangeDailyOanda_xtest', 'DEL_ExchangeDailyOanda_xtest'
EXEC sp_rename 'tmp_binary3', 'DEL_tmp_binary3'
EXEC sp_rename 'tmpConstraint', 'DEL_tmpConstraint'
EXEC sp_rename 'tmpCust_BUHead_test_20210407', 'DEL_tmpCust_BUHead_test_20210407'
EXEC sp_rename 'tmpCustArchived_DisabledAgents_NoBal_xtest', 'DEL_tmpCustArchived_DisabledAgents_NoBal_xtest'
EXEC sp_rename '__Temp_custinfo_syncUpd_xtest', 'DEL___Temp_custinfo_syncUpd_xtest'
EXEC sp_rename 'Cache_DummyAccount3rd_Joe_Test', 'DEL_Cache_DummyAccount3rd_Joe_Test'


