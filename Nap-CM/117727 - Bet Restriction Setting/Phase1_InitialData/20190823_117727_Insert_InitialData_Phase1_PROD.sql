/*
	Created by: Eden
	Date: 20190830
	Task: Insert sample Data for Phase 1 , for only SMAs [Redmine:#117727]	
	DB: DBCUST/CustDB
*/
DECLARE @IsCheck8RMLine BIT = 1
/* 
	@IsCheck8RMLine = 1 : check 8RM Account must be member of '8RM' agent 
	@IsCheck8RMLine = 0 : don't need to check 8RM Account must be member of '8RM' agent ( use for UAT test account)
*/ 

DECLARE @ListAccount TABLE (SMAAccount NVARCHAR(50), [8RMAccount]  NVARCHAR(50), SportType SMALLINT,LiveBetAccept SMALLINT, SeizeBetTicket TINYINT, MaxBet MONEY, MaxPerMatch MONEY)
INSERT INTO @ListAccount (SMAAccount, [8RMAccount],SportType,LiveBetAccept,SeizeBetTicket,MaxBet,MaxPerMatch)
	  SELECT 'FNU', '8RM1-FNU'  , 1, 0, 50, NULL, NULL
UNION SELECT 'S69R', '8RM1-S6EU', 1, 0, 50, NULL, NULL
UNION SELECT 'S69E', '8RM1-S69E', 1, 0, 50, NULL, NULL

SELECT ErrorMessage = 'SMAAccount ''' + lc.SMAAccount + ''' is invalid' 
FROM  @ListAccount lc
	LEFT JOIN Custinfo c1 WITH(NOLOCK) ON lc.SMAAccount = c1.username
WHERE c1.custid IS NULL
UNION ALL
SELECT ErrorMessage = '8RMAccount ''' + lc.[8RMAccount] + ''' is invalid' 
FROM  @ListAccount lc
	LEFT JOIN Custinfo c1 WITH(NOLOCK) ON lc.[8RMAccount] = c1.username
WHERE c1.custid IS NULL
UNION ALL
SELECT ErrorMessage =  '8RMAccount ''' + lc.[8RMAccount] + ''' is not a member of 8RM Agent'	
FROM  @ListAccount lc
	INNER JOIN Custinfo c1 WITH(NOLOCK) ON lc.[8RMAccount] = c1.username
	LEFT JOIN Custinfo rm WITH(NOLOCK)  
			ON c1.recommend = rm.custid 
			AND rm.username = '8RM'
WHERE rm.custid IS NULL AND @IsCheck8RMLine = 1 

IF @@ROWCOUNT <> 0
	RETURN

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
	c1.custID
FROM @ListAccount lc
	 INNER JOIN custinfo c WITH(NOLOCK) 
		ON lc.SMAAccount = c.username
	 INNER JOIN Custinfo c1 WITH(NOLOCK) 
		ON c1.username = lc.[8RMAccount]
GO
