/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Rename unused SP [Redmine: #154048]   
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
EXEC sp_rename 'Acc_CustomerUpdSuper_MinMaxBet', 'DEL_Acc_CustomerUpdSuper_MinMaxBet'
EXEC sp_rename 'Acc_CustomerUpdMaster_MinMaxBet', 'DEL_Acc_CustomerUpdMaster_MinMaxBet'
EXEC sp_rename 'Acc_CustomerUpdAgent_MinMaxBet', 'DEL_Acc_CustomerUpdAgent_MinMaxBet'
EXEC sp_rename 'Acc_CustomerUpdMember_MinMaxBet', 'DEL_Acc_CustomerUpdMember_MinMaxBet'
EXEC sp_rename 'Acc_CustomerSelSAgentInfo_Multiple ', 'DEL_Acc_CustomerSelSAgentInfo_Multiple '
EXEC sp_rename 'Acc_CustomerUpdNGEnableBetSetting', 'DEL_Acc_CustomerUpdNGEnableBetSetting'
EXEC sp_rename 'Acc_CustomerSelNGUpline', 'DEL_Acc_CustomerSelNGUpline'
EXEC sp_rename 'Acc_CustomerUpdMaxPerMatch', 'DEL_Acc_CustomerUpdMaxPerMatch'
