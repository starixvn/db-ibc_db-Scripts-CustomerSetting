/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240315@Helios
	Task: Remove & Clean Up Old Structure (CustSetting , CustOverride , CustCommRate , AgentCommRate...) [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB 
*/

	 --Part 1: Clean up - Drop unused tables
	TRUNCATE TABLE CustSetting
	TRUNCATE TABLE CustOverride
	TRUNCATE TABLE CustCommRate
	TRUNCATE TABLE AgentCommRate


	-- Part 2: Clean up - Delete unused data in tables
	DELETE cbsa  FROM CustBetSetting3rd_Agent cbsa WITH (ROWLOCK) WHERE cbsa.SportType IN (43,44)

	DELETE cbsm FROM CustBetSetting3rd_Member cbsm WITH (ROWLOCK) WHERE cbsm.SportType IN (43,44)

	-- Part 3: DB schema changes -> remove unused columns

	-- CustInfo
	ALTER TABLE CustInfo DROP CONSTRAINT DF__custInfo__Disabl__3EA2B786;
	ALTER TABLE CustInfo DROP COLUMN DisableEsports ;

	-- CustSuper
	ALTER TABLE CustSuper DROP CONSTRAINT DF_CustSuper_AutoIBCPositionTaking_Fixed;
	ALTER TABLE CustSuper DROP CONSTRAINT DF_CustSuper_AutoIBCPositionTaking_Tote;
	ALTER TABLE CustSuper DROP COLUMN AutoIBCPositionTaking_Tote  ;
	ALTER TABLE CustSuper DROP COLUMN AutoIBCPositionTaking_Fixed ;