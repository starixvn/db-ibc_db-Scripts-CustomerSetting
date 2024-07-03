/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240604@Johnson
	Task: Scale out dbcust [redmine: #199915]
	DB: DBACC-bodb02,DBTP-bodb02
*/ 
DECLARE @Group INT = 0

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size)
SELECT @Group,'Dep_CustBAActive',0,'repupdatetime',0,'CustId','Repl_GetDep_CustBAActive','Repl_PutDep_CustBAActive',1000,10,60000,0
SELECT @Group,'Dep_CustBetLimit_Special',0,'repupdatetime',0,'Keyid','Repl_GetDep_CustBetLimit_Special','Repl_PutDep_CustBetLimit_Special',1000,10,60000,0
SELECT @Group,'Dep_CustBetSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustBetSetting_Agent','Repl_PutDep_CustBetSetting_Agent',1000,10,60000,0
SELECT @Group,'Dep_CustBetSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustBetSetting_Member_Dist','Repl_PutDep_CustBetSetting_Member',1000,10,60000,0
SELECT @Group,'Dep_CustBetSettingGame_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustBetSettingGame_Agent','Repl_PutDep_CustBetSettingGame_Agent',1000,10,60000,0
SELECT @Group,'Dep_CustBetSettingGame_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustBetSettingGame_Member','Repl_PutDep_CustBetSettingGame_Member',1000,10,60000,0
SELECT @Group,'Dep_CustDiscountSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustDiscountSetting_Agent','Repl_PutDep_CustDiscountSetting_Agent',1000,10,60000,0
SELECT @Group,'Dep_CustDiscountSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustDiscountSetting_Member','Repl_PutDep_CustDiscountSetting_Member',1000,10,60000,0
SELECT @Group,'Dep_Customer_Archived',0,'repupdatetime',0,'CustId','Repl_GetDep_Customer_Archived','Repl_PutDep_Customer_Archived',1000,10,60000,0
SELECT @Group,'Dep_CustomerClass',0,'repupdatetime',0,'CustId','Repl_GetDep_CustomerClass','Repl_PutDep_CustomerClass',1000,10,60000,0
SELECT @Group,'Dep_CustProductSetting',0,'repupdatetime',0,'CustId|ProductId','Repl_GetDep_CustProductSetting','Repl_PutDep_CustProductSetting',1000,10,60000,0
SELECT @Group,'Dep_CustProductStatus',0,'repupdatetime',0,'CustId','Repl_GetDep_CustProductStatus','Repl_PutDep_CustProductStatus',1000,10,60000,0
SELECT @Group,'Dep_CustPTGroupSetting_Member',0,'repupdatetime',0,'AgentID|SportType|BetType|IsLive','Repl_GetDep_CustPTGroupSetting_Member','Repl_PutDep_CustPTGroupSetting_Member',1000,10,60000,0
SELECT @Group,'Dep_CustPTSetting_Agent',0,'repupdatetime',0,'CustID|SportType|BetType|IsLive','Repl_GetDep_CustPTSetting_Agent','Repl_PutDep_CustPTSetting_Agent',1000,10,60000,0
SELECT @Group,'Dep_CustPTSetting_Member',0,'repupdatetime',0,'CustID|SportType|BetType|IsLive','Repl_GetDep_CustPTSetting_Member','Repl_PutDep_CustPTSetting_Member',1000,10,60000,0
SELECT @Group,'Dep_CustSetting_AGCasino',0,'repupdatetime',0,'CustId','Repl_GetDep_CustSetting_AGCasino','Repl_PutDep_CustSetting_AGCasino',1000,10,60000,0
SELECT @Group,'Dep_CustSettingGame',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustSettingGame','Repl_PutDep_CustSettingGame',1000,10,60000,0
SELECT @Group,'Dep_CustSettingMode',0,'repupdatetime',0,'CustId','Repl_GetDep_CustSettingMode','Repl_PutDep_CustSettingMode',1000,10,60000,0
SELECT @Group,'Dep_CustSpecialLevel',0,'repupdatetime',0,'CustId','Repl_GetDep_CustSpecialLevel','Repl_PutDep_CustSpecialLevel',1000,10,60000,0
SELECT @Group,'Dep_CustStakeLevel_Agent',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustStakeLevel_Agent','Repl_PutDep_CustStakeLevel_Agent',1000,10,60000,0
SELECT @Group,'Dep_CustStakeLevel_Member',0,'repupdatetime',0,'CustID|SportType|BetType','Repl_GetDep_CustStakeLevel_Member','Repl_PutDep_CustStakeLevel_Member',1000,10,60000,0
SELECT @Group,'Dep_CustSuper',0,'repupdatetime',0,'CustId','Repl_GetDep_CustSuper','Repl_PutDep_CustSuper',1000,10,60000,0
SELECT @Group,'Dep_CustVIP',0,'repupdatetime',0,'CustId','Repl_GetDep_CustVIP','Repl_PutDep_CustVIP',1000,10,60000,0
SELECT @Group,'Dep_DefaultOddGroup',0,'repupdatetime',0,'AgentID','Repl_GetDep_DefaultOddGroup','Repl_PutDep_DefaultOddGroup',1000,10,60000,0
SELECT @Group,'Dep_LicenseeProductSetting',0,'repupdatetime',0,'CustID|ProductSettingID','Repl_GetDep_LicenseeProductSetting','Repl_PutDep_LicenseeProductSetting',1000,10,60000,0
SELECT @Group,'Dep_ProductBetSetting',0,'repupdatetime',0,'SportType|BetType|Currency','Repl_GetDep_ProductBetSetting','Repl_PutDep_ProductBetSetting',1000,10,60000,0
SELECT @Group,'Dep_ProductSettingDetail',0,'repupdatetime',0,'ProductSettingID|SportType|BetType|IsLive','Repl_GetDep_ProductSettingDetail','Repl_PutDep_ProductSettingDetail',1000,10,60000,0
SELECT @Group,'Dep_ProductStatusProfile',0,'repupdatetime',0,'SportType|BetType','Repl_GetDep_ProductStatusProfile','Repl_PutDep_ProductStatusProfile',1000,10,60000,0
SELECT @Group,'Dep_StakeLevel',0,'repupdatetime',0,'StakeLevelID','Repl_GetDep_StakeLevel','Repl_PutDep_StakeLevel',1000,10,60000,0
SELECT @Group,'Dep_StakeLevelGroupDetail',0,'repupdatetime',0,'StakeLevelID|GameTypeID','Repl_GetDep_StakeLevelGroupDetail','Repl_PutDep_StakeLevelGroupDetail',1000,10,60000,0
SELECT @Group,'Dep_SuperSetting_AGCasino',0,'repupdatetime',0,'CustID','Repl_GetDep_SuperSetting_AGCasino','Repl_PutDep_SuperSetting_AGCasino',1000,10,60000,0
SELECT @Group,'Dep_SupperProductSetting',0,'repupdatetime',0,'CustID|ProductId','Repl_GetDep_SupperProductSetting','Repl_PutDep_SupperProductSetting',1000,10,60000,0

/*
USE bodb02
GO

DELETE
FROM RepInfo WITH (ROWLOCK, UPDLOCK)
WHERE [name] IN ('Dep_CustBAActive','Dep_CustBetLimit_Special','Dep_CustBetSetting_Agent','Dep_CustBetSetting_Member','Dep_CustBetSettingGame_Agent','Dep_CustBetSettingGame_Member','Dep_CustDiscountSetting_Agent','Dep_CustDiscountSetting_Member','Dep_Customer_Archived','Dep_CustomerClass','Dep_CustProductSetting','Dep_CustProductStatus','Dep_CustPTGroupSetting_Member','Dep_CustPTSetting_Agent','Dep_CustPTSetting_Member','Dep_CustSetting_AGCasino','Dep_CustSettingGame','Dep_CustSettingMode','Dep_CustSpecialLevel','Dep_CustStakeLevel_Agent','Dep_CustStakeLevel_Member','Dep_CustSuper','Dep_CustVIP','Dep_DefaultOddGroup','Dep_LicenseeProductSetting','Dep_ProductBetSetting','Dep_ProductSettingDetail','Dep_ProductStatusProfile','Dep_StakeLevel','Dep_StakeLevelGroupDetail','Dep_SuperSetting_AGCasino','Dep_SupperProductSetting')
*/
