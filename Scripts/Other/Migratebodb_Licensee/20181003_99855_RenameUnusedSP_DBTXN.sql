/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DBTXN/CustDB
*/

IF @@SERVERNAME NOT IN ('DBTRANS','DB206','DB230') RETURN

USE CustDB
GO

EXEC sp_rename 'Dot_Dep_CustomerInsMember_Ag_Cust','DEL_Dot_Dep_CustomerInsMember_Ag_Cust'
EXEC sp_rename 'Dot_Dep_CustomerInsMember_Ag_Cust_lukas','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_lukas'

USE bodb02
GO

EXEC sp_rename 'Acc_Rpt_NumberGame','DEL_Acc_Rpt_NumberGame'
EXEC sp_rename 'Dot_Dep_CustomerInsMember_Ag_20121216','DEL_Dot_Dep_CustomerInsMember_Ag_20121216'
EXEC sp_rename 'Dot_Dep_CustomerInsMember_Ag_20130806','DEL_Dot_Dep_CustomerInsMember_Ag_20130806'
EXEC sp_rename 'Task_BalanceNegativeDel_CustCredit','DEL_Task_BalanceNegativeDel_CustCredit'
EXEC sp_rename 'Task_BalanceNegativeHistoryIns_Cust','DEL_Task_BalanceNegativeHistoryIns_Cust'
EXEC sp_rename 'Task_BATransaction_Check','DEL_Task_BATransaction_Check'
