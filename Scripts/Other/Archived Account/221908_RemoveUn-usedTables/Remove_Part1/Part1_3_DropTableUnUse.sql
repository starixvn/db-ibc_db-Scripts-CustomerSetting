/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Drop table Un Use [#221908] 
	DB: DBCust/CustDB
*/

IF OBJECT_ID('CustBetSetting3rd_Agent',       'U') IS NOT NULL DROP TABLE CustBetSetting3rd_Agent;
IF OBJECT_ID('CustBetSetting3rd_Member',      'U') IS NOT NULL DROP TABLE CustBetSetting3rd_Member;
IF OBJECT_ID('AgentCommRate',                 'U') IS NOT NULL DROP TABLE AgentCommRate;
IF OBJECT_ID('custOverride',                  'U') IS NOT NULL DROP TABLE custOverride;
IF OBJECT_ID('CustSetting',                   'U') IS NOT NULL DROP TABLE CustSetting;
IF OBJECT_ID('CustCommRate',                  'U') IS NOT NULL DROP TABLE CustCommRate;
IF OBJECT_ID('CustBetSetting_Agent',          'U') IS NOT NULL DROP TABLE CustBetSetting_Agent;
IF OBJECT_ID('CustBetSetting_Member',         'U') IS NOT NULL DROP TABLE CustBetSetting_Member;
IF OBJECT_ID('custOverride3rd',               'U') IS NOT NULL DROP TABLE custOverride3rd;
IF OBJECT_ID('CustOverrideGame',              'U') IS NOT NULL DROP TABLE CustOverrideGame;
IF OBJECT_ID('CustSetting3rd',                'U') IS NOT NULL DROP TABLE CustSetting3rd;
IF OBJECT_ID('CustSettingGame',               'U') IS NOT NULL DROP TABLE CustSettingGame;
