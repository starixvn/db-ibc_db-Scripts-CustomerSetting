/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240508@Johnson
	Task: LAP -Migrate data for new structure Player Commission
	DB: DBCUST/bodb_Licensee
*/

DELETE LicenseeGroupDiscount WITH(ROWLOCK)

DELETE LicenseeGroupDiscountDetail WITH(ROWLOCK)

DELETE LicenseeCustDiscount WITH(ROWLOCK)