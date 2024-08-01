/*<info serverAlias=DBTP-bodb02></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Add IsDeleted  on DBTP [RedmineID:#206738]
	DB: DBTP/bodb02
*/
USE bodb02
GO

ALTER TABLE Acc_CustAllowList ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_CustDirect ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_CustGroup ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_CustType ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_DWLList ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_DWLList_ExtraPT ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_DWLList_ExtraPT_xtest ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_DWLList_xtest ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_FinancePermission ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_GroupExtraCommRateSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_GroupExtraPT_Product ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_GroupExtraPT2_Product ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_GroupExtraPT2Setting ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_GroupExtraPTSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Acc_SuperPrefix ADD IsDeleted BIT NULL
GO
ALTER TABLE Age_CustDateLimit ADD IsDeleted BIT NULL
GO
ALTER TABLE Age_CustProfilePicture ADD IsDeleted BIT NULL
GO
ALTER TABLE Age_CustSeq ADD IsDeleted BIT NULL
GO
ALTER TABLE Age_ProfilePicture ADD IsDeleted BIT NULL
GO
ALTER TABLE APIInfo ADD IsDeleted BIT NULL
GO
ALTER TABLE BetLimitControlCustSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE BetLimitControlDefaultSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE BetLimitControlProduct ADD  IsDeleted BIT NULL
GO
ALTER TABLE BetLimitControlType ADD  IsDeleted BIT NULL
GO
ALTER TABLE BetLimitControlTypeDetail ADD  IsDeleted BIT NULL
GO
ALTER TABLE BetRestriction_Currency ADD IsDeleted BIT NULL
GO
ALTER TABLE BetRestriction_Customer ADD  IsDeleted BIT NULL
GO
ALTER TABLE BetRestriction_Setting ADD IsDeleted BIT NULL
GO
ALTER TABLE BetRestriction_Site ADD IsDeleted BIT NULL
GO
ALTER TABLE CategoryConfig ADD IsDeleted BIT NULL
GO
ALTER TABLE custAccount ADD IsDeleted BIT NULL
GO
ALTER TABLE CustAgent ADD IsDeleted BIT NULL
Go
ALTER TABLE CustBetSetting3rd_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE CustBetSetting3rd_Member ADD IsDeleted BIT NULL
GO

ALTER TABLE CustDirectAccount ADD IsDeleted BIT NULL
GO
ALTER TABLE CustDiscount3rd_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE CustDiscount3rd_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustGroupHeadline ADD IsDeleted BIT NULL
GO
ALTER TABLE CustInDirectLogin ADD IsDeleted BIT NULL
GO
ALTER TABLE custInfo ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustLimitPTSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE CustLoginInfo ADD IsDeleted BIT NULL
GO
ALTER TABLE CustLoginInfo_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustLoginInfoSub ADD IsDeleted BIT NULL
GO
ALTER TABLE CustMaster ADD IsDeleted BIT NULL
GO
ALTER TABLE CustMaxPayoutSetting_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE CustMaxPayoutSetting_Member ADD IsDeleted BIT NULL
GO
ALTER TABLE CustNoComm ADD IsDeleted BIT NULL
GO
ALTER TABLE Customer ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassPolicy ADD IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassPolicyManagement ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassPolicyRule ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassRule ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassRuleLeagueGroup ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassSiteManagement ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassSpread ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassSpreadClass ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassSpreadDetail ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustomerClassSpreadDetail_UAT ADD IsDeleted BIT NULL
GO
ALTER TABLE CustOTP ADD IsDeleted BIT NULL
GO
ALTER TABLE CustOTPDetail ADD IsDeleted BIT NULL
GO
ALTER TABLE CustProductStatus ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustPTGroupSetting3rd_Member ADD IsDeleted BIT NULL
GO
ALTER TABLE CustPTSetting3rd_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE CustPTSetting3rd_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustPTTemplate ADD IsDeleted BIT NULL
GO
ALTER TABLE CustPTTemplateDetail ADD IsDeleted BIT NULL
GO
ALTER TABLE CustQRCode ADD IsDeleted BIT NULL
GO
ALTER TABLE custSearch ADD IsDeleted BIT NULL
GO
ALTER TABLE CustSettingAutoSuspend ADD IsDeleted BIT NULL
GO
ALTER TABLE CustSettingMode3rd ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustStakeLevel_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE CustStakeLevel_Member ADD IsDeleted BIT NULL
GO
ALTER TABLE custSub ADD IsDeleted BIT NULL
GO
ALTER TABLE CustSuper ADD IsDeleted BIT NULL
GO
ALTER TABLE CustSuperProfile ADD IsDeleted BIT NULL
GO
ALTER TABLE CustSuspendLockUpd ADD IsDeleted BIT NULL
GO
ALTER TABLE CustVirtualSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE CustWinLossLimit_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE CustWinLossLimit_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBAActive ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBetLimit_Special ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBetSetting_Agent ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBetSetting_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBetSettingGame_Agent ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBetSettingGame_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustBetSettingGameGroup_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustCategoryHistory ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustDiscountGroupSetting_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustDiscountSetting_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustDiscountSetting_Member ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_Customer_Archived ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustomerClass ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustProductSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustProductStatus ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustPTGroupSetting_Member ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustPTSetting_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustPTSetting_Member ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustSetting_AGCasino ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustSettingGame ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustSettingMode ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustSpecialLevel ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustStakeLevel_Agent ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustStakeLevel_Member ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustSuper ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_CustVIP ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_DefaultOddGroup ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_LicenseeProductSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_ProductBetSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_ProductSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_ProductSettingDetail ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_ProductStatusProfile ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dep_StakeLevel ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_StakeLevelGroupDetail ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_SuperSetting_AGCasino ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_SupperProductSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE Dot_StreamingVIP ADD IsDeleted BIT NULL
GO
ALTER TABLE EASCustOTP ADD IsDeleted BIT NULL
GO
ALTER TABLE EmailNotification ADD IsDeleted BIT NULL
GO
ALTER TABLE ExchangeDaily_Crypto ADD IsDeleted BIT NULL
GO
ALTER TABLE ExchangeDailyOanda ADD IsDeleted BIT NULL
GO
ALTER TABLE GameGroup ADD IsDeleted BIT NULL
GO
ALTER TABLE GameLaunchPerCurrency ADD IsDeleted BIT NULL
GO
ALTER TABLE GameLaunchPerSite ADD IsDeleted BIT NULL
GO
ALTER TABLE GameRoundBetLimitSettings ADD IsDeleted BIT NULL
GO
ALTER TABLE LimitPTDailySetting ADD IsDeleted BIT NULL
GO
ALTER TABLE LossLimit_GlobalSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE MaxPayoutGlobalSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Member_LoginVerify ADD IsDeleted BIT NULL
GO
ALTER TABLE MsgError ADD IsDeleted BIT NULL
GO
ALTER TABLE MsgErrorGroup ADD IsDeleted BIT NULL
GO
ALTER TABLE PhoneBettingCustomerList ADD IsDeleted BIT NULL
GO
ALTER TABLE PlayCurrencySetting ADD IsDeleted BIT NULL
GO
ALTER TABLE ProblemAccount ADD IsDeleted BIT NULL
GO
ALTER TABLE ProblemAccountAction ADD IsDeleted BIT NULL
GO
ALTER TABLE ProblemAccountClassification ADD IsDeleted BIT NULL
GO
ALTER TABLE ProblemAccountLimitDownline ADD IsDeleted BIT NULL
GO
ALTER TABLE ProblemAccountReason ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductBetSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductGlobalSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductLaunchedSiteCurrency ADD  IsDeleted BIT NULL
GO
ALTER TABLE ProductProfileSiteCurrency ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductProfileSiteCurrency_UAT ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductSettingDetail ADD  IsDeleted BIT NULL
GO
ALTER TABLE ProductSettingDetail_UAT ADD  IsDeleted BIT NULL
GO
ALTER TABLE ProductSettingProfile ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductSettingProfile_UAT ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductSettingSystemDisplay ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductSettingUpdateRestriction ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductSiteConfig ADD IsDeleted BIT NULL
GO
ALTER TABLE ProductStatusProfile ADD  IsDeleted BIT NULL
GO
ALTER TABLE ProductStatusSiteCurrency ADD IsDeleted BIT NULL
GO
ALTER TABLE ProfileVirtualSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE RobotList ADD  IsDeleted BIT NULL
GO
ALTER TABLE SiteDBConfig ADD  IsDeleted BIT NULL
GO
ALTER TABLE smartPunterList ADD IsDeleted BIT NULL
GO
ALTER TABLE SportNonOfferedSiteCurrency ADD IsDeleted BIT NULL
GO
ALTER TABLE StakeLevel ADD IsDeleted BIT NULL
GO
ALTER TABLE StakeLevelGroupDetail ADD IsDeleted BIT NULL
GO
ALTER TABLE SuspiciousCust ADD IsDeleted BIT NULL
GO
ALTER TABLE TOControl_GlobalSetting ADD  IsDeleted BIT NULL
GO
ALTER TABLE TradeComm ADD IsDeleted BIT NULL
GO
ALTER TABLE TradeCust ADD IsDeleted BIT NULL
GO
ALTER TABLE VendorGlobalSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE VRAgentAutoAdjustment ADD IsDeleted BIT NULL
GO
ALTER TABLE VRAgentProfile ADD IsDeleted BIT NULL
GO
ALTER TABLE VRBettypeGroup ADD IsDeleted BIT NULL
GO
ALTER TABLE VRCustAutoAdjustment ADD IsDeleted BIT NULL
GO
ALTER TABLE VRCustLockStatus ADD IsDeleted BIT NULL
GO
ALTER TABLE VRCustSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE VRLeagueGroup ADD IsDeleted BIT NULL
GO
ALTER TABLE VRLeagueGroupMapping ADD IsDeleted BIT NULL
GO
ALTER TABLE VRSettingHierarchy ADD IsDeleted BIT NULL
GO
ALTER TABLE VRSettingManualUpdAcc ADD IsDeleted BIT NULL
GO
ALTER TABLE VRSettingReference ADD IsDeleted BIT NULL
GO
ALTER TABLE VRValueMapping ADD IsDeleted BIT NULL
GO
ALTER TABLE Winlimit_ActionSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_CustGameMonitoring ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_CustGameMonitoring_History ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_CustGameSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_CustGameStatus ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_CustSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_CustWinlostGame ADD IsDeleted BIT NULL
GO
ALTER TABLE Winlimit_GameGroupSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Winlimit_LevelSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE Winlimit_ProductSetting ADD IsDeleted BIT NULL
GO
ALTER TABLE WinLimit_ProductSettingDetail ADD IsDeleted BIT NULL
GO
ALTER TABLE CustDBSiteConfig ADD IsDeleted BIT NULL
GO
--ALTER TABLE VRSettingRule ADD IsDeleted BIT NULL
--GO
--ALTER TABLE VRSettingRuleDetail ADD IsDeleted BIT NULL
--GO
--ALTER TABLE VRSettingRuleDetail_NotApply ADD IsDeleted BIT NULL
GO
ALTER TABLE WLMonitored_PersonalPreset ADD IsDeleted BIT NULL
GO
ALTER TABLE Dep_WLMonitored_Player ADD IsDeleted BIT NULL
GO