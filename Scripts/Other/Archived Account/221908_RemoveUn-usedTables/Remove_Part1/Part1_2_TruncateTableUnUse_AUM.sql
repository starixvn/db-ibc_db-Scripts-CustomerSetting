/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - TRUNCATE TABLE Un Use [#221908]   
	DB: DBCust/CustDB
*/

IF OBJECT_ID('CustBetSetting3rd_Agent', 'U')		IS NOT NULL TRUNCATE TABLE CustBetSetting3rd_Agent;
IF OBJECT_ID('CustBetSetting3rd_Member', 'U')		IS NOT NULL TRUNCATE TABLE CustBetSetting3rd_Member;
IF OBJECT_ID('CustBetSetting_Agent', 'U')			IS NOT NULL TRUNCATE TABLE CustBetSetting_Agent;
IF OBJECT_ID('CustBetSetting_Member', 'U')		IS NOT NULL TRUNCATE TABLE CustBetSetting_Member;

