/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240409@Tacy
	Task: Drop unused SP [Redmine: #201432]
		change: [EAS_CustomerBetSettingMultipleCheck] 
			--> [EAS_CustomerInfo_MultiCheck]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck_xpre')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck_xpre 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck_xtest')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck_xtest 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck_UAT1')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck_UAT1 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck_UAT2')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck_UAT2 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck_UAT3')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck_UAT3 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'EAS_CustomerBetSettingMultipleCheck_UAT4')
	DROP PROCEDURE EAS_CustomerBetSettingMultipleCheck_UAT4 
