/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: DROP unused SP [Redmine: #154048]   
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
DROP PROCEDURE DEL_Acc_CustomerUpdSuper_MinMaxBet
DROP PROCEDURE DEL_Acc_CustomerUpdMaster_MinMaxBet
DROP PROCEDURE DEL_Acc_CustomerUpdAgent_MinMaxBet
DROP PROCEDURE DEL_Acc_CustomerUpdMember_MinMaxBet
DROP PROCEDURE DEL_Acc_CustomerSelSAgentInfo_Multiple 
DROP PROCEDURE DEL_Acc_CustomerUpdNGEnableBetSetting
DROP PROCEDURE DEL_Acc_CustomerSelNGUpline
DROP PROCEDURE DEL_Acc_CustomerUpdMaxPerMatch