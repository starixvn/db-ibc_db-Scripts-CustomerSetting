/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211126@Winfred
	Task : Limit to update PT one time per day [Redmine: #165249]
	DB:  DBCUST/CustDB 
*/
USE CustDB
GO

UPDATE LimitPTDailySetting  WITH (ROWLOCK, UPDLOCK)  SET MaxCount = 1