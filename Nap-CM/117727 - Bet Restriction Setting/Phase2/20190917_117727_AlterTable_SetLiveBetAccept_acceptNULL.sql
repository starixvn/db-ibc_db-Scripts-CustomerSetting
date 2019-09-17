/*
	Created by: Eden
	Date: 20190917
	Task: alter table set LiveBetAccept accept NULL values
	RM: #117727
	DB: DBCUST/CustDB,DBACC/bodb02(replication)
*/
ALTER TABLE BetRestriction_Customer ALTER COLUMN LiveBetAccept SMALLINT NOT NULL
GO
ALTER TABLE BetRestriction_Site ALTER COLUMN LiveBetAccept SMALLINT NOT NULL
GO
ALTER TABLE BetRestriction_Currency ALTER COLUMN LiveBetAccept SMALLINT NOT NULL
GO