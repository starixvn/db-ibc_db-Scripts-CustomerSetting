/*
	Created by: Eden
	Date: 20190830
	Task: Insert sample Data for Phase 1 , for only SMAs [Redmine:#117727]	
	DB: DBCUST/CustDB
*/

DECLARE @ListAccount TABLE (SMAAccount NVARCHAR(50), [8RMAccount]  NVARCHAR(50), SportType SMALLINT,LiveBetAccept SMALLINT, SeizeBetTicket TINYINT, MaxBet MONEY, MaxPerMatch MONEY)
INSERT INTO @ListAccount (SMAAccount, [8RMAccount],SportType,LiveBetAccept,SeizeBetTicket,MaxBet,MaxPerMatch)
	  SELECT 'FNU', '8RM1-FNU'  , 1, 0, 50, NULL, NULL
UNION SELECT 'S69R', '8RM1-S6EU', 1, 0, 50, NULL, NULL
UNION SELECT 'S69E', '8RM1-S69E', 1, 0, 50, NULL, NULL

INSERT INTO BetRestriction_Customer(
	CustID, 
	SportType, 
	LiveBetAccept, 
	SeizeBetTicket, 
	MaxBet, 
	MaxPerMatch, 
	FollowAccount
	)
SELECT c.custid,
	lc.SportType, 
	lc.LiveBetAccept, 
	lc.SeizeBetTicket, 
	lc.MaxBet, 
	lc.MaxPerMatch, 
	rm.[8RMAccID]
FROM @ListAccount lc
	 JOIN custinfo c WITH(NOLOCK) 
		ON lc.SMAAccount = c.username
	 OUTER APPLY(	SELECT c1.custid AS [8RMAccID]
					FROM Custinfo c1 WITH(NOLOCK) 
						JOIN Custinfo rm WITH(NOLOCK)  
							ON c1.recommend = rm.custid 
							AND rm.username = '8RM'
					WHERE c1.username = lc.[8RMAccount]
				 ) rm

GO
