/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Add column SportBettypeSettingMatrix : SporttypeRefWinlossLimit, BettypeRefWinlossLimit [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
ALTER TABLE SportBettypeSettingMatrix ADD SporttypeRefWinlossLimit SMALLINT NULL, BettypeRefWinlossLimit SMALLINT NULL
