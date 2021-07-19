/*
	Created by: Eden
	Date: 20190924
	Task: Add BEST-ODDS site to BetRestriction_Site, FollowAccount is test account ( for UAT testing )
	RM: #117727
	DB: DBCUST/CustDB
*/
DECLARE @LiveBetAccept smallint = 0, 
		@SeizeBetTicket tinyint = 90,
		@FollowAccount nvarchar(50) = 'uusseizebet4',
		@SiteID int = 1, --BEST-ODDS
		@SportType smallint = 1

--> Insert into BetRestriction_Site
INSERT INTO BetRestriction_Site(
	SiteID,
	SportType,
	LiveBetAccept,
	SeizeBetTicket,
	FollowAccount
)
SELECT @SiteID, 
       @SportType, 
       @LiveBetAccept, 
       @SeizeBetTicket, 
       ci.custid
FROM  custinfo ci WITH(NOLOCK) 
WHERE username =  @FollowAccount

GO