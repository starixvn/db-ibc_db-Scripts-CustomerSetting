/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20240508@Johnson
	Task: LAP -Migrate data for new structure Player Commission
	DB: DBCUST/CUSTDB
*/

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)

SELECT MAX(ID) FROM bodb_Licensee.dbo.LicenseeGroupComm WITH(NOLOCK)