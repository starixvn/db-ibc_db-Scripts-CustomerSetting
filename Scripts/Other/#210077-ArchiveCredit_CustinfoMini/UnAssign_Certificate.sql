/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
/*
	Created: 20241008@Helios
	Task: Scale out DBCUST - Credit - Implement Code of stage 4 archiving process for Scale Out DBCust [Redmine: #210077]    
	Database: DBCUST-GlobCustDB
*/

USE GlobCustDB
GO

DROP SIGNATURE FROM OBJECT::dbo.Acc_CustomerIns_Register_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Acc_CustomerIns_Rollback_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Age_CustomerInsNickName_Register_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Age_CustomerInsNickName_Rollback_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Age_CustSubIns_Register_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.API_CustomerIns_Generate_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.API_CustomerIns_Register_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Dot_Admin_CreateCustInfoMiniAccount_Test BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Dot_Member_CheckNickname_Cust_Mini_test BY CERTIFICATE cert_scaleout_dbcust_UAT
DROP SIGNATURE FROM OBJECT::dbo.Dot_Member_UpdateNickname_Cust_Mini_test BY CERTIFICATE cert_scaleout_dbcust_UAT

GO
DROP CERTIFICATE cert_scaleout_dbcust_UAT