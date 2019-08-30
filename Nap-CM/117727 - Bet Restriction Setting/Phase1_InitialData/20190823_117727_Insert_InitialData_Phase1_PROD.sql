/*
	Created by: Eden
	Date: 20190830
	Task: Insert sample Data for Phase 1 , for only SMAs [Redmine:#117727]	
	DB: DBCUST/CustDB
*/

DECLARE @8RMAccount1 INT,
		@8RMAccount2 INT,
		@8RMAccount3 INT

SELECT	@8RMAccount1 = CASE WHEN c.username  = '8RM1-FNU'  THEN c.custid ELSE @8RMAccount1 END,
		@8RMAccount2 = CASE WHEN c.username  = '8RM1-S6EU' THEN c.custid ELSE @8RMAccount2 END,
		@8RMAccount3 = CASE WHEN c.username  = '8RM1-S69E' THEN c.custid ELSE @8RMAccount3 END
FROM custinfo c WITH(NOLOCK) 
	 JOIN Custinfo rm WITH(NOLOCK)  
		ON c.recommend = rm.custid 
		AND rm.username = '8RM'
WHERE c.username IN ('8RM1-FNU', '8RM1-S6EU', '8RM1-S69E')

-->BetRestriction_Customer
DECLARE	 @SMAAccount1	INT
		,@SMAAccount2	INT
		,@SMAAccount3	INT

SELECT	@SMAAccount1 = CASE WHEN c.username  = 'FNU'  THEN c.custid ELSE @SMAAccount1 END,
		@SMAAccount2 = CASE WHEN c.username  = 'S69R' THEN c.custid ELSE @SMAAccount2 END,
		@SMAAccount3 = CASE WHEN c.username  = 'S69E' THEN c.custid ELSE @SMAAccount3 END
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN ('FNU', 'S69R', 'S69E')

INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SMAAccount1, 1, 0, 50, NULL, NULL, @8RMAccount1)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SMAAccount2, 1, 0, 50, NULL, NULL, @8RMAccount2)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SMAAccount3, 1, 0, 50, NULL, NULL, @8RMAccount3)
GO
