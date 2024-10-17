/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-10-17
	Task: Rename unUsed SP [Redmine: #206823]   
	DB: DBCUST-CustDB
*/

USE CustDB
GO
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT1','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT1' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT2','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT2' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT3','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT3' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT4','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_UAT4' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_xpre','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_xpre' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Main_xtest','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Main_xtest' 

EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT1','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT1' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT2','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT2' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT3','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT3' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT4','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch_UAT4' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch_xpre','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch_xpre' 
EXEC sp_rename  'Dot_Dep_CustomerInsMember_Ag_Cust_Switch_xtest','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_Switch_xtest' 
