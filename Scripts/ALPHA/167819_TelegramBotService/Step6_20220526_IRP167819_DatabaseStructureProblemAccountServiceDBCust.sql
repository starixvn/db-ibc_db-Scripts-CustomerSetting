/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220526@Johnson
	Task: Database structure change for Problem Account notification service [#RedmineID:#167819]
	DB: DBCUST/CustDB
*/

ALTER TABLE CustCategoryHistory ADD OldCustomerClass SMALLINT
