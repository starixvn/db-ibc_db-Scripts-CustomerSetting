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


-- CN88
EXEC sp_rename  'CS_Acc_CustomerUpdPwdReset','DEL_CS_Acc_CustomerUpdPwdReset' 
EXEC sp_rename  'CS_AdminLoginVerifyBefore','DEL_CS_AdminLoginVerifyBefore' 
EXEC sp_rename  'CS_Age_CustomerUpdPwd','DEL_CS_Age_CustomerUpdPwd' 
EXEC sp_rename  'CS_Customer_Status_Upd','DEL_CS_Customer_Status_Upd' 
EXEC sp_rename  'CS_CustomerIns_Headline','DEL_CS_CustomerIns_Headline' 
EXEC sp_rename  'CS_CustomerInsNickName','DEL_CS_CustomerInsNickName' 
EXEC sp_rename  'CS_CustomerInsUserInfo','DEL_CS_CustomerInsUserInfo' 
EXEC sp_rename  'CS_CustomerInsUserInfo_Rollback','DEL_CS_CustomerInsUserInfo_Rollback' 
EXEC sp_rename  'CS_CustomerPwdUpd2','DEL_CS_CustomerPwdUpd2' 
EXEC sp_rename  'CS_CustomerUpdSecurityCodeStatus_Sub','DEL_CS_CustomerUpdSecurityCodeStatus_Sub' 
EXEC sp_rename  'CS_CustomerUserGroup_Upd','DEL_CS_CustomerUserGroup_Upd' 
EXEC sp_rename  'CS_CustSetting_GeneralInfo_Upd','DEL_CS_CustSetting_GeneralInfo_Upd' 
EXEC sp_rename  'CS_CustSubDel','DEL_CS_CustSubDel' 
EXEC sp_rename  'CS_CustSubIns','DEL_CS_CustSubIns' 
EXEC sp_rename  'CS_CustSubInsNickname','DEL_CS_CustSubInsNickname' 
EXEC sp_rename  'CS_CustSubPwdUpd2','DEL_CS_CustSubPwdUpd2' 
EXEC sp_rename  'CS_CustSubUnlock','DEL_CS_CustSubUnlock' 
EXEC sp_rename  'CS_CustSubUpd','DEL_CS_CustSubUpd' 
EXEC sp_rename  'CS_DBA_Customer_HeadlineIns','DEL_CS_DBA_Customer_HeadlineIns' 
EXEC sp_rename  'CS_LoginVerifyDownline','DEL_CS_LoginVerifyDownline' 
EXEC sp_rename  'CS_SubAccManagementUpd','DEL_CS_SubAccManagementUpd' 