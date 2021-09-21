/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210830
	Task: Rename unused SP [Redmine: #154048]   
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
EXEC sp_rename 'deleted_Acc_CustomerUpdSuper_MinMaxBet', 'Acc_CustomerUpdSuper_MinMaxBet'
EXEC sp_rename 'deleted_Acc_CustomerUpdMaster_MinMaxBet', 'Acc_CustomerUpdMaster_MinMaxBet'
EXEC sp_rename 'deleted_Acc_CustomerUpdAgent_MinMaxBet', 'Acc_CustomerUpdAgent_MinMaxBet'
EXEC sp_rename 'deleted_Acc_CustomerUpdMember_MinMaxBet', 'Acc_CustomerUpdMember_MinMaxBet'
EXEC sp_rename 'deleted_Acc_CustomerSelSAgentInfo_Multiple ', 'Acc_CustomerSelSAgentInfo_Multiple '
EXEC sp_rename 'deleted_Acc_CustomerUpdNGEnableBetSetting', 'Acc_CustomerUpdNGEnableBetSetting'
EXEC sp_rename 'deleted_Acc_CustomerSelNGUpline', 'Acc_CustomerSelNGUpline'
EXEC sp_rename 'deleted_Acc_CustomerUpdMaxPerMatch', 'Acc_CustomerUpdMaxPerMatch'
