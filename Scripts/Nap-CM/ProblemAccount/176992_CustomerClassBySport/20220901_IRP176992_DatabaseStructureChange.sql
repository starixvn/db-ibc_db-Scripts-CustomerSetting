/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: 20220901@Johnson
	Task: Data structure change for new columns customerclass by sports [#RedmineID:#176992]
	DB: DBTP/bodb_CustHistory
*/

ALTER TABLE CustInfo_History ADD CCSoccer SMALLINT, CCBasketball SMALLINT, CCEsports SMALLINT, CCOtherSports SMALLINT
