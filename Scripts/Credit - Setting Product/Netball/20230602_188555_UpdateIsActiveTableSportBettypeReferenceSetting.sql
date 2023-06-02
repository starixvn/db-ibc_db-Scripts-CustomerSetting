/*<info serverAlias="DBTXN-bodb02"></info>*/  
/*	
	Created: 20230602@Luke
	Task: Update isActive for table Sport_Bettype_Reference_Setting [RedmineID: #188555]
	DB: DBTXN-bodb02
*/
USE bodb02
GO

DECLARE @SportType SMALLINT = 32,
		@BetType INT = 20

UPDATE s WITH (ROWLOCK, UPDLOCK)
SET s.isActive = 1
FROM Sport_Bettype_Reference_Setting s 
WHERE s.SportType = @SportType AND s.BetType = @BetType