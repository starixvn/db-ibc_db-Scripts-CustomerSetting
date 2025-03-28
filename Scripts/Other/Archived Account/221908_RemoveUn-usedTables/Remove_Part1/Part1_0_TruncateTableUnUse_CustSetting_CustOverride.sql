/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - TRUNCATE TABLE Un Use [#224528] 
	DB: DBCust/CustDB
*/

IF OBJECT_ID('custOverride', 'U')				IS NOT NULL TRUNCATE TABLE custOverride;
IF OBJECT_ID('CustSetting', 'U')				IS NOT NULL TRUNCATE TABLE CustSetting;