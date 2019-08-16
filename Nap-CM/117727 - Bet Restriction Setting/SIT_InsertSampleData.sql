/*
	Created by: Eden
	Date: 20190816
	Task: Insert sample Data on SIT [Redmine:#117727]	
	DB: DBCUST/CustDB
*/
DELETE FROM BetRestriction_Customer WITH(rowlock)
DELETE FROM BetRestriction_Site WITH(rowlock)
DELETE FROM BetRestriction_Currency WITH(rowlock)
DELETE FROM BetRestriction_Setting WITH(rowlock)
GO

-->BetRestriction_Setting
SET IDENTITY_INSERT BetRestriction_Setting ON
GO
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (1,1,'BetRestriction_Customer',0,0,1,1,1)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (2,1,'BetRestriction_Customer',1,0,1,1,1)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (3,1,'BetRestriction_Site',0,0,1,1,1)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (4,1,'BetRestriction_Site',1,0,1,1,1)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (5,1,'BetRestriction_Currency',0,0,1,1,1)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (6,1,'BetRestriction_Currency',1,0,1,1,1)
GO
SET IDENTITY_INSERT BetRestriction_Setting OFF
GO
----------------------------------------------------------
DECLARE @8rmseizebet1 INT, @8rmseizebet2 INT, @8rmseizebet3 INT, @8rmseizebet4 INT, @8rmseizebet5 INT, @A8rmseizebet INT, @MA8rmseizebet INT

SELECT	@8rmseizebet1 = CASE WHEN c.username  = '8rmseizebet1' THEN c.custid ELSE @8rmseizebet1 END,
		@8rmseizebet2 = CASE WHEN c.username  = '8rmseizebet2' THEN c.custid ELSE @8rmseizebet2 END,
		@8rmseizebet3 = CASE WHEN c.username  = '8rmseizebet3' THEN c.custid ELSE @8rmseizebet3 END,
		@8rmseizebet4 = CASE WHEN c.username  = '8rmseizebet4' THEN c.custid ELSE @8rmseizebet4 END,
		@8rmseizebet5 = CASE WHEN c.username  = '8rmseizebet5' THEN c.custid ELSE @8rmseizebet5 END,
		@A8rmseizebet = CASE WHEN c.username  = 'A8rmseizebet' THEN c.custid ELSE @A8rmseizebet END,
		@MA8rmseizebet = CASE WHEN c.username  = 'MA8rmseizebet' THEN c.custid ELSE @MA8rmseizebet END	
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN ('MA8rmseizebet','A8rmseizebet','8rmseizebet1','8rmseizebet2','8rmseizebet3','8rmseizebet4','8rmseizebet5')

-->BetRestriction_Currency
DECLARE @THB INT, @USD INT, @HK INT, @UUS INT, @IDD INT, @GBP INT

SELECT @THB = CASE WHEN currency = 'THB' THEN exchangeid ELSE @THB END,
	   @USD = CASE WHEN currency = 'US$' THEN exchangeid ELSE @USD END,
	   @HK  = CASE WHEN currency = 'HK$' THEN exchangeid ELSE @HK END,
	   @IDD = CASE WHEN currency = 'IDD' THEN exchangeid ELSE @IDD END,
	   @GBP = CASE WHEN currency = 'GBP' THEN exchangeid ELSE @GBP END,
	   @UUS = CASE WHEN currency = 'UUS' THEN exchangeid ELSE @UUS END
FROM  exchange WITH(NOLOCK) 
WHERE currency IN('THB','US$','HK$','UUS','IDD','GBP')

INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@THB,1,0,30,70,@8rmseizebet1) 
INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@USD,1,1,31,75,@8rmseizebet1)
INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@HK,1,2,32,80,@8rmseizebet1)
INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@IDD,1,0,33,85,@8rmseizebet1)
INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@GBP,1,1,34,90,@8rmseizebet1)
INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@UUS,1,1,34,90,@8rmseizebet1)

-->BetRestriction_Site
DECLARE @bestodds_SiteID INT, @789y_SiteID INT, @12bet_SiteID INT, @cn88_SiteID INT

SELECT @bestodds_SiteID = CASE WHEN Site = 'best-odds' THEN siteid ELSE @bestodds_SiteID END,
	   @789y_SiteID = CASE WHEN Site = '789y' THEN siteid ELSE @789y_SiteID END,
	   @12bet_SiteID = CASE WHEN Site = '12bet' THEN siteid ELSE @12bet_SiteID END,
	   @cn88_SiteID = CASE WHEN Site = 'cn88' THEN siteid ELSE @cn88_SiteID END
FROM site WITH(NOLOCK) 
WHERE site IN('best-odds','789y','12bet','cn88')

INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@bestodds_SiteID,1,20,50,@8rmseizebet2) -- BEST-ODDS
INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@789y_SiteID,1,21,55,@8rmseizebet2) -- 789y
INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@12bet_SiteID,1,22,60,@8rmseizebet2) -- 12Bet
INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@cn88_SiteID,1,23,65,@8rmseizebet2) -- CN88

-->BetRestriction_Customer
DECLARE	 @SupertestPragUSD0201		INT
		,@SupertestPragGBP010101	INT
		,@SupertestPragUSD02010103	INT
		,@SupertestPragGBP01010103	INT
		,@SupertestPragHKD01010103	INT
		,@SupertestPragTHB01010103	INT
		,@SupertestPragIDR02010103	INT

SELECT	@SupertestPragUSD0201	  = CASE WHEN c.username  = 'SupertestPragUSD0201'	   THEN c.custid ELSE @SupertestPragUSD0201 END,
		@SupertestPragGBP010101	  = CASE WHEN c.username  = 'SupertestPragGBP010101'   THEN c.custid ELSE @SupertestPragGBP010101 END,
		@SupertestPragUSD02010103 = CASE WHEN c.username  = 'SupertestPragUSD02010103' THEN c.custid ELSE @SupertestPragUSD02010103 END,
		@SupertestPragGBP01010103 = CASE WHEN c.username  = 'SupertestPragGBP01010103' THEN c.custid ELSE @SupertestPragGBP01010103 END,
		@SupertestPragHKD01010103 = CASE WHEN c.username  = 'SupertestPragHKD01010103' THEN c.custid ELSE @SupertestPragHKD01010103 END,
		@SupertestPragTHB01010103 = CASE WHEN c.username  = 'SupertestPragTHB01010103' THEN c.custid ELSE @SupertestPragTHB01010103 END,
		@SupertestPragIDR02010103 = CASE WHEN c.username  = 'SupertestPragIDR02010103' THEN c.custid ELSE @SupertestPragIDR02010103 END	
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN (
						 'SupertestPragUSD0201'
						,'SupertestPragGBP010101'
						,'SupertestPragUSD02010103'
						,'SupertestPragGBP01010103'
						,'SupertestPragHKD01010103'
						,'SupertestPragTHB01010103'
						,'SupertestPragIDR02010103'
					)

INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragUSD0201,1,-5,5,100.00,1000.00,@MA8rmseizebet)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragGBP010101,1,-4,10,100.00,1000.00,@A8rmseizebet)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragUSD02010103,1,-3,15,100.00,1000.00,@8rmseizebet1)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragGBP01010103,1,-2,20,100.00,1000.00,@8rmseizebet2)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragHKD01010103,1,-3,15,100.00,1000.00,@8rmseizebet3)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragTHB01010103,1,-2,20,100.00,1000.00,@8rmseizebet4)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestPragIDR02010103,1,-3,15,100.00,1000.00,@8rmseizebet5)
GO

