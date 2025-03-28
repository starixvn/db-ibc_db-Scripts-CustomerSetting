/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - TRUNCATE TABLE Un Use [#221908]   
	DB: DBCust/CustDB
*/
IF OBJECT_ID('AgentCommRate', 'U')				IS NOT NULL TRUNCATE TABLE AgentCommRate;
IF OBJECT_ID('CustCommRate', 'U')				IS NOT NULL TRUNCATE TABLE CustCommRate;
IF OBJECT_ID('custOverride3rd', 'U')			IS NOT NULL TRUNCATE TABLE custOverride3rd;
IF OBJECT_ID('CustOverrideGame', 'U')			IS NOT NULL TRUNCATE TABLE CustOverrideGame; 
IF OBJECT_ID('CustSetting3rd', 'U')				IS NOT NULL TRUNCATE TABLE CustSetting3rd;
IF OBJECT_ID('CustSettingGame', 'U')			IS NOT NULL TRUNCATE TABLE CustSettingGame;