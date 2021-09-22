/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210802
	Task: add setting for bet restriction for basketball
	DB: DBCust/CustDB
*/
INSERT INTO [dbo].[BetRestriction_Setting]
           ([SportType]
           ,[RestrictionLevel]
           ,[IsLicensee]
           ,[BackEndStatus]
           ,[LiveBetAcceptStatus]
           ,[SeizeBetTicketStatus]
           ,[BetLimitStatus])
SELECT 2, 'BetRestriction_Customer', 0, 1, 1, 1, 0
UNION SELECT 2, 'BetRestriction_Customer', 1, 1, 1, 1, 0