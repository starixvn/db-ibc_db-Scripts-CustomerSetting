/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Credit Customer in GlobCustDB - Truncate table Tmp [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/


TRUNCATE TABLE CustInfoMini_tmp
TRUNCATE TABLE CustSubMini_tmp