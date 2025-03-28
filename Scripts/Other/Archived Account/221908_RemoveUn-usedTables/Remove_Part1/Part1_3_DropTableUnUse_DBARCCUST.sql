/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Drop table Un Use [#221908] 
	DB: DBARCCUST/bodb_Customer
*/

IF OBJECT_ID('CustBetSetting3rd_Agent_old',       'U') IS NOT NULL DROP TABLE CustBetSetting3rd_Agent_old;
IF OBJECT_ID('CustBetSetting3rd_Member_old',      'U') IS NOT NULL DROP TABLE CustBetSetting3rd_Member_old;
IF OBJECT_ID('AgentCommRate_old',                 'U') IS NOT NULL DROP TABLE AgentCommRate_old;
IF OBJECT_ID('custOverride_old',                  'U') IS NOT NULL DROP TABLE custOverride_old;
IF OBJECT_ID('CustSetting_old',                   'U') IS NOT NULL DROP TABLE CustSetting_old;
IF OBJECT_ID('CustCommRate_old',                  'U') IS NOT NULL DROP TABLE CustCommRate_old;
IF OBJECT_ID('CustBetSetting_Agent_old',          'U') IS NOT NULL DROP TABLE CustBetSetting_Agent_old;
IF OBJECT_ID('CustBetSetting_Member_old',         'U') IS NOT NULL DROP TABLE CustBetSetting_Member_old;
IF OBJECT_ID('custOverride3rd_old',               'U') IS NOT NULL DROP TABLE custOverride3rd_old;
IF OBJECT_ID('CustOverrideGame_old',              'U') IS NOT NULL DROP TABLE CustOverrideGame_old;
IF OBJECT_ID('CustSetting3rd_old',                'U') IS NOT NULL DROP TABLE CustSetting3rd_old;
IF OBJECT_ID('CustSettingGame_old',               'U') IS NOT NULL DROP TABLE CustSettingGame_old;
