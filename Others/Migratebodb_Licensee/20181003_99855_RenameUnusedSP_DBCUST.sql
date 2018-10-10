/*
	Created: 20181003@Elodie
	Task: Rename unused SP
	DB: DBCUST/CustDB
*/

IF @@SERVERNAME NOT IN ('DBCUST','DB233','DB230\SQLSERVER2008R2') RETURN

USE CustDB
GO

EXEC sp_rename 'DBA_Lrf_ChangeLicenseeName_bk20160329','DEL_DBA_Lrf_ChangeLicenseeName_bk20160329'
EXEC sp_rename 'Dot_Dep_CustomerInsMember_Ag_Cust_backup','DEL_Dot_Dep_CustomerInsMember_Ag_Cust_backup'
EXEC sp_rename 'NAP_SpecialCustSettingAgent_SelByCurrencyAndLicensee','DEL_NAP_SpecialCustSettingAgent_SelByCurrencyAndLicensee'
EXEC sp_rename 'NAP_WinLimit_CustNotConfigProductSel','DEL_NAP_WinLimit_CustNotConfigProductSel'
EXEC sp_rename 'NAP_WinLimit_SiteLicenseeByProductSel','DEL_NAP_WinLimit_SiteLicenseeByProductSel'
EXEC sp_rename 'NAP_SpecialCustSetting_LicenseeList','DEL_NAP_SpecialCustSetting_LicenseeList'


USE SiteConfig
GO

EXEC sp_rename 'Portal_Import_AFF_Permission_bk', 'DEL_Portal_Import_AFF_Permission_bk'