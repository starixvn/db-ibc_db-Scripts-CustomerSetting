/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - ReName table Un Use [#221908]  
	DB: DBCust/CustDB
*/

IF OBJECT_ID('CustBetSetting3rd_Agent',       'U') IS NOT NULL EXEC sp_rename 'CustBetSetting3rd_Agent',       'CustBetSetting3rd_Agent_DEL';
IF OBJECT_ID('CustBetSetting3rd_Member',      'U') IS NOT NULL EXEC sp_rename 'CustBetSetting3rd_Member',      'CustBetSetting3rd_Member_DEL';
IF OBJECT_ID('AgentCommRate',                 'U') IS NOT NULL EXEC sp_rename 'AgentCommRate',                 'AgentCommRate_DEL';
IF OBJECT_ID('custOverride',                  'U') IS NOT NULL EXEC sp_rename 'custOverride',                  'custOverride_DEL';
IF OBJECT_ID('CustSetting',                   'U') IS NOT NULL EXEC sp_rename 'CustSetting',                   'CustSetting_DEL';
IF OBJECT_ID('CustCommRate',                  'U') IS NOT NULL EXEC sp_rename 'CustCommRate',                  'CustCommRate_DEL';
IF OBJECT_ID('CustBetSetting_Agent',          'U') IS NOT NULL EXEC sp_rename 'CustBetSetting_Agent',          'CustBetSetting_Agent_DEL';
IF OBJECT_ID('CustBetSetting_Member',         'U') IS NOT NULL EXEC sp_rename 'CustBetSetting_Member',         'CustBetSetting_Member_DEL';
IF OBJECT_ID('custOverride3rd',               'U') IS NOT NULL EXEC sp_rename 'custOverride3rd',               'custOverride3rd_DEL';
IF OBJECT_ID('CustOverrideGame',              'U') IS NOT NULL EXEC sp_rename 'CustOverrideGame',              'CustOverrideGame_DEL';
IF OBJECT_ID('CustSetting3rd',                'U') IS NOT NULL EXEC sp_rename 'CustSetting3rd',                'CustSetting3rd_DEL';
IF OBJECT_ID('CustSettingGame',               'U') IS NOT NULL EXEC sp_rename 'CustSettingGame',               'CustSettingGame_DEL';
