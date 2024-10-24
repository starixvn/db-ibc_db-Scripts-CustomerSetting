/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-10-25
	Task: Rename SP Un Use [Redmine: #212624]
	DB: DBCUST-CustDB
*/

EXEC sp_rename  'Acc_Dep_CustomerInsUserInfo_Rollback_12bet_xtest','DEL_Acc_Dep_CustomerInsUserInfo_Rollback_12bet_xtest_DEL' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_xtest','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_xtest_DEL' 
EXEC sp_rename  'Dot_Dep_CustomerInsUserInfo_12bet_xtest','DEL_Dot_Dep_CustomerInsUserInfo_12bet_xtest_DEL' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_xtest','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_xtest_DEL'  

