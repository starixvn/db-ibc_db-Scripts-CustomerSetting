/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Rename table in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE CustDB
GO
exec sp_rename 'dbo.Acc_SuperPrefix','Del_Acc_SuperPrefix';
exec sp_rename 'dbo.CategoryConfig','Del_CategoryConfig';
exec sp_rename 'dbo.DangerLevelPolicy','Del_DangerLevelPolicy';
exec sp_rename 'dbo.GameRoundBetLimitSettings','Del_GameRoundBetLimitSettings';
exec sp_rename 'dbo.Initial_ProductConfig','Del_Initial_ProductConfig';
exec sp_rename 'dbo.Initial_ProductConfig_Detail','Del_Initial_ProductConfig_Detail';
exec sp_rename 'dbo.Initial_StepByConfig','Del_Initial_StepByConfig';
exec sp_rename 'dbo.MsgError','Del_MsgError';
exec sp_rename 'dbo.MsgErrorGroup','Del_MsgErrorGroup';
exec sp_rename 'dbo.ProblemAccountReason','Del_ProblemAccountReason';
exec sp_rename 'dbo.ProductGlobalSetting','Del_ProductGlobalSetting';
exec sp_rename 'dbo.ProductLaunchedSiteCurrency','Del_ProductLaunchedSiteCurrency';
exec sp_rename 'dbo.ProductProfileSiteCurrency','Del_ProductProfileSiteCurrency';
exec sp_rename 'dbo.ProductProfileSiteCurrency_UAT','Del_ProductProfileSiteCurrency_UAT';
exec sp_rename 'dbo.ProductSettingProfile','Del_ProductSettingProfile';
exec sp_rename 'dbo.ProductSettingProfile_UAT','Del_ProductSettingProfile_UAT';
exec sp_rename 'dbo.ProductSettingSystemDisplay','Del_ProductSettingSystemDisplay';
exec sp_rename 'dbo.ProductSettingSystemDisplay_UAT','Del_ProductSettingSystemDisplay_UAT';
exec sp_rename 'dbo.ProductSettingType','Del_ProductSettingType';
exec sp_rename 'dbo.ProductSettingUpdateRestriction','Del_ProductSettingUpdateRestriction';
exec sp_rename 'dbo.ProductStatusProfile','Del_ProductStatusProfile';
exec sp_rename 'dbo.ProductStatusSiteCurrency','Del_ProductStatusSiteCurrency';
exec sp_rename 'dbo.ProfilePicture','Del_ProfilePicture';
exec sp_rename 'dbo.SportNonOfferedSiteCurrency','Del_SportNonOfferedSiteCurrency';
exec sp_rename 'dbo.UMConfig','Del_UMConfig';
exec sp_rename 'dbo.Winlimit_ActionSetting','Del_Winlimit_ActionSetting';
exec sp_rename 'dbo.Winlimit_GameGroupSetting','Del_Winlimit_GameGroupSetting';
exec sp_rename 'dbo.Winlimit_Group','Del_Winlimit_Group';
exec sp_rename 'dbo.Winlimit_LevelSetting','Del_Winlimit_LevelSetting';
exec sp_rename 'dbo.Winlimit_ProductGlobalSetting','Del_Winlimit_ProductGlobalSetting';
exec sp_rename 'dbo.Winlimit_ProductSetting','Del_Winlimit_ProductSetting';
exec sp_rename 'dbo.WinLimit_ProductSettingDetail','Del_WinLimit_ProductSettingDetail';






