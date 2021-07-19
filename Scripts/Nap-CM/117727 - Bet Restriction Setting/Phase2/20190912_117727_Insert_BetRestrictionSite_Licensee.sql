/*
	Created by: Eden
	Date: 20190912
	Task: All Active licensees will be added into Bet Restriction Site level 
	RM: #117727
	DB: DBCUST/CustDB
*/
--> Clean data of BetRestriction_Site
DELETE FROM BetRestriction_Site WITH(ROWLOCK,UPDLOCK)
GO

DECLARE @LiveBetAccept smallint = -2, 
		@SeizeBetTicket tinyint = 0,
		@FollowAccount int = NULL,
		@SportType smallint = 1

--> Insert Active licensees Site into BetRestriction_Site
INSERT INTO BetRestriction_Site(
	SiteID,
	SportType,
	LiveBetAccept,
	SeizeBetTicket,
	FollowAccount
)
SELECT s.SiteID, 
       @SportType, 
       @LiveBetAccept, 
       @SeizeBetTicket, 
       @FollowAccount
FROM bodb_licensee.dbo.licensees lc WITH(NOLOCK)
	INNER JOIN Site s WITH(NOLOCK) ON lc.LicenseeName = s.site
WHERE lc.IsActive = 1
	AND lc.IsDeposit = 1

GO
