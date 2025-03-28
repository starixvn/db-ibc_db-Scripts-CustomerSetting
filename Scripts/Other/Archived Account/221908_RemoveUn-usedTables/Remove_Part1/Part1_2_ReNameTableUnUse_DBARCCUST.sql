/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - ReName table Un Use [#221908]  
	DB: DBARCCUST/bodb_Customer
*/

IF OBJECT_ID('CustBetSetting3rd_Agent_old',       'U') IS NOT NULL EXEC sp_rename 'CustBetSetting3rd_Agent_old',       'CustBetSetting3rd_Agent_old_DEL';
IF OBJECT_ID('CustBetSetting3rd_Member_old',      'U') IS NOT NULL EXEC sp_rename 'CustBetSetting3rd_Member_old',      'CustBetSetting3rd_Member_old_DEL';
IF OBJECT_ID('AgentCommRate_old',                 'U') IS NOT NULL EXEC sp_rename 'AgentCommRate_old',                 'AgentCommRate_old_DEL';
IF OBJECT_ID('custOverride_old',                  'U') IS NOT NULL EXEC sp_rename 'custOverride_old',                  'custOverride_old_DEL';
IF OBJECT_ID('CustSetting_old',                   'U') IS NOT NULL EXEC sp_rename 'CustSetting_old',                   'CustSetting_old_DEL';
IF OBJECT_ID('CustCommRate_old',                  'U') IS NOT NULL EXEC sp_rename 'CustCommRate_old',                  'CustCommRate_old_DEL';
IF OBJECT_ID('CustBetSetting_Agent_old',          'U') IS NOT NULL EXEC sp_rename 'CustBetSetting_Agent_old',          'CustBetSetting_Agent_old_DEL';
IF OBJECT_ID('CustBetSetting_Member_old',         'U') IS NOT NULL EXEC sp_rename 'CustBetSetting_Member_old',         'CustBetSetting_Member_old_DEL';
IF OBJECT_ID('custOverride3rd_old',               'U') IS NOT NULL EXEC sp_rename 'custOverride3rd_old',               'custOverride3rd_old_DEL';
IF OBJECT_ID('CustOverrideGame_old',              'U') IS NOT NULL EXEC sp_rename 'CustOverrideGame_old',              'CustOverrideGame_old_DEL';
IF OBJECT_ID('CustSetting3rd_old',                'U') IS NOT NULL EXEC sp_rename 'CustSetting3rd_old',                'CustSetting3rd_old_DEL';
IF OBJECT_ID('CustSettingGame_old',               'U') IS NOT NULL EXEC sp_rename 'CustSettingGame_old',               'CustSettingGame_old_DEL';
