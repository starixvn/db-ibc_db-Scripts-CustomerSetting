/*
	Created by: Eden
	Date: 20190816
	Task: Insert sample Data [Redmine:#117727]	
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
VALUES (1,1,'BetRestriction_Customer',0,1,0,0,0)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (2,1,'BetRestriction_Customer',1,1,0,0,0)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (3,1,'BetRestriction_Site',0,1,0,0,0)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (4,1,'BetRestriction_Site',1,1,0,0,0)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (5,1,'BetRestriction_Currency',0,1,0,0,0)
INSERT INTO BetRestriction_Setting (SettingID,SportType,RestrictionLevel,IsLicensee,BackEndStatus,LiveBetAcceptStatus,SeizeBetTicketStatus,BetLimitStatus)
VALUES (6,1,'BetRestriction_Currency',1,1,0,0,0)
GO
SET IDENTITY_INSERT BetRestriction_Setting OFF
GO
----------------------------------------------------------
DECLARE @uusseizebet1 INT,
		@uusseizebet2 INT,
		@uusseizebet3 INT,
		@Auusseizebet INT,
		@MAuusseizebet INT,
		-------------------
		@Supertest8UUS0101001 INT,
		@Supertest8UUS0101002 INT,
		@Supertest8UUS0101003 INT,
		@Supertest8UUS0101004 INT,
		@Supertest8UUS0101005 INT,
		@Supertest8UUS0101006 INT,
		@Supertest8UUS0101007 INT,
		@Supertest8UUS0101008 INT,
		@Supertest8UUS0101009 INT,
		@Supertest8UUS0101010 INT,
		@Supertest8UUS0101011 INT

SELECT	@uusseizebet1 = CASE WHEN c.username  = 'uusseizebet1' THEN c.custid ELSE @uusseizebet1 END,
		@uusseizebet2 = CASE WHEN c.username  = 'uusseizebet2' THEN c.custid ELSE @uusseizebet2 END,
		@uusseizebet3 = CASE WHEN c.username  = 'uusseizebet3' THEN c.custid ELSE @uusseizebet3 END,
		@Auusseizebet = CASE WHEN c.username  = 'Auusseizebet' THEN c.custid ELSE @Auusseizebet END,
		@MAuusseizebet = CASE WHEN c.username  = 'MAuusseizebet' THEN c.custid ELSE @MAuusseizebet END,
		----------
		@Supertest8UUS0101001 = CASE WHEN c.username  = 'Supertest8UUS0101001' THEN c.custid ELSE @Supertest8UUS0101001 END,
		@Supertest8UUS0101002 = CASE WHEN c.username  = 'Supertest8UUS0101002' THEN c.custid ELSE @Supertest8UUS0101002 END,
		@Supertest8UUS0101003 = CASE WHEN c.username  = 'Supertest8UUS0101003' THEN c.custid ELSE @Supertest8UUS0101003 END,
		@Supertest8UUS0101004 = CASE WHEN c.username  = 'Supertest8UUS0101004' THEN c.custid ELSE @Supertest8UUS0101004 END,
		@Supertest8UUS0101005 = CASE WHEN c.username  = 'Supertest8UUS0101005' THEN c.custid ELSE @Supertest8UUS0101005 END,
		@Supertest8UUS0101006 = CASE WHEN c.username  = 'Supertest8UUS0101006' THEN c.custid ELSE @Supertest8UUS0101006 END,
		@Supertest8UUS0101007 = CASE WHEN c.username  = 'Supertest8UUS0101007' THEN c.custid ELSE @Supertest8UUS0101007 END,
		@Supertest8UUS0101008 = CASE WHEN c.username  = 'Supertest8UUS0101008' THEN c.custid ELSE @Supertest8UUS0101008 END,
		@Supertest8UUS0101009 = CASE WHEN c.username  = 'Supertest8UUS0101009' THEN c.custid ELSE @Supertest8UUS0101009 END,
		@Supertest8UUS0101010 = CASE WHEN c.username  = 'Supertest8UUS0101010' THEN c.custid ELSE @Supertest8UUS0101010 END,
		@Supertest8UUS0101011 = CASE WHEN c.username  = 'Supertest8UUS0101011' THEN c.custid ELSE @Supertest8UUS0101011 END
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN (    'MAuusseizebet'
						,'Auusseizebet'
						,'uusseizebet1'
						,'uusseizebet2'
						,'uusseizebet3'
						---------------
						,'Supertest8UUS0101001' 
						,'Supertest8UUS0101002'
						,'Supertest8UUS0101003'
						,'Supertest8UUS0101004'
						,'Supertest8UUS0101005'
						,'Supertest8UUS0101006'
						,'Supertest8UUS0101007'
						,'Supertest8UUS0101008'
						,'Supertest8UUS0101009'
						,'Supertest8UUS0101010'
						,'Supertest8UUS0101011'
					)

-->BetRestriction_Currency
DECLARE @UUS INT

SELECT @UUS = CASE WHEN currency = 'UUS' THEN exchangeid ELSE @UUS END
FROM  exchange WITH(NOLOCK) 
WHERE currency IN('UUS')

INSERT INTO BetRestriction_Currency(ExchangeID, SportType,[Type],LiveBetAccept, SeizeBetTicket, FollowAccount)VALUES(@UUS,1,1,34,90,@uusseizebet1)

-->BetRestriction_Site
DECLARE @bestodds_SiteID INT, @789y_SiteID INT, @12bet_SiteID INT, @cn88_SiteID INT

SELECT @bestodds_SiteID = CASE WHEN Site = 'best-odds' THEN siteid ELSE @bestodds_SiteID END,
	   @789y_SiteID = CASE WHEN Site = '789y' THEN siteid ELSE @789y_SiteID END,
	   @12bet_SiteID = CASE WHEN Site = '12bet' THEN siteid ELSE @12bet_SiteID END,
	   @cn88_SiteID = CASE WHEN Site = 'cn88' THEN siteid ELSE @cn88_SiteID END
FROM site WITH(NOLOCK) 
WHERE site IN('best-odds','789y','12bet','cn88')

INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@bestodds_SiteID,1,20,50,@uusseizebet2) -- BEST-ODDS
INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@789y_SiteID,1,21,55,@uusseizebet2) -- 789y
INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@12bet_SiteID,1,22,60,@uusseizebet2) -- 12Bet
INSERT INTO BetRestriction_Site(SiteID, SportType,LiveBetAccept, SeizeBetTicket, FollowAccount) VALUES(@cn88_SiteID,1,23,65,@uusseizebet2) -- CN88

-->BetRestriction_Customer
DECLARE	 @STAFFTW		INT
		,@STAFFTWPG		INT
		,@jackytesta	INT
		,@jackytestb	INT
		,@jackytestc	INT
		-------------------------------
		,@SupertestTE02				INT
		,@SupertestTE0301			INT
		,@SupertestTE030201			INT
		,@SupertestTE030301001		INT
		,@SupertestTE030301002		INT
		,@SupertestTE030401001		INT
		,@SupertestNC41				INT
		,@SupertestTE3201			INT
		,@SupertestTE320201			INT
		,@SupertestTE320301001		INT
		,@SupertestTE100101001		INT

SELECT	@STAFFTW	  = CASE WHEN c.username  = 'STAFFTW'	   THEN c.custid ELSE @STAFFTW END,
		@STAFFTWPG	  = CASE WHEN c.username  = 'STAFFTWPG'   THEN c.custid ELSE @STAFFTWPG END,
		@jackytesta = CASE WHEN c.username  = 'jackytesta' THEN c.custid ELSE @jackytesta END,
		@jackytestb = CASE WHEN c.username  = 'jackytestb' THEN c.custid ELSE @jackytestb END,
		@jackytestc = CASE WHEN c.username  = 'jackytestc' THEN c.custid ELSE @jackytestc END,
		----
		@SupertestTE02 = CASE WHEN c.username  = '@SupertestTE02' THEN c.custid ELSE @SupertestTE02 END,
		@SupertestTE0301 = CASE WHEN c.username  = '@SupertestTE0301' THEN c.custid ELSE @SupertestTE0301 END,
		@SupertestTE030201 = CASE WHEN c.username  = '@SupertestTE030201' THEN c.custid ELSE @SupertestTE030201 END,
		@SupertestTE030301001 = CASE WHEN c.username  = '@SupertestTE030301001' THEN c.custid ELSE @SupertestTE030301001 END,
		@SupertestTE030301002 = CASE WHEN c.username  = '@SupertestTE030301002' THEN c.custid ELSE @SupertestTE030301002 END,
		@SupertestTE030401001 = CASE WHEN c.username  = '@SupertestTE030401001' THEN c.custid ELSE @SupertestTE030401001 END,
		@SupertestNC41 = CASE WHEN c.username  = '@SupertestNC41' THEN c.custid ELSE @SupertestNC41 END,
		@SupertestTE3201 = CASE WHEN c.username  = '@SupertestTE3201' THEN c.custid ELSE @SupertestTE3201 END,
		@SupertestTE320201 = CASE WHEN c.username  = '@SupertestTE320201' THEN c.custid ELSE @SupertestTE320201 END,
		@SupertestTE320301001 = CASE WHEN c.username  = '@SupertestTE320301001' THEN c.custid ELSE @SupertestTE320301001 END,
		@SupertestTE100101001 = CASE WHEN c.username  = '@SupertestTE100101001' THEN c.custid ELSE @SupertestTE100101001 END
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN (
						 'STAFFTW'
						,'STAFFTWPG'
						,'jackytesta'
						,'jackytestb'
						,'jackytestc'
						-------------
						,'SupertestTE02'
						,'SupertestTE0301'
						,'SupertestTE030201'
						,'SupertestTE030301001'
						,'SupertestTE030301002'
						,'SupertestTE030401001'
						,'SupertestNC41'
						,'SupertestTE3201'
						,'SupertestTE320201'
						,'SupertestTE320301001'
						,'SupertestTE100101001'
					)

INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@STAFFTW,1,-5,5,100.00,1000.00,@MAuusseizebet)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@STAFFTWPG,1,-4,10,100.00,1000.00,@Auusseizebet)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@jackytesta,1,-3,15,100.00,1000.00,@uusseizebet1)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@jackytestb,1,-2,20,100.00,1000.00,@uusseizebet2)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@jackytestc,1,-1,25,100.00,1000.00,@uusseizebet3)
---------
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE02,1,-5,5,100.00,1000.00,@Supertest8UUS0101001)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE0301,1,-4,10,100.00,1000.00,@Supertest8UUS0101002)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE030201,1,-3,15,100.00,1000.00,@Supertest8UUS0101003)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE030301001,1,-2,20,100.00,1000.00,@Supertest8UUS0101004)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE030301002,1,-1,25,100.00,1000.00,@Supertest8UUS0101005)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE030401001,1,-5,5,100.00,1000.00,@Supertest8UUS0101006)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestNC41,1,-4,10,100.00,1000.00,@Supertest8UUS0101007)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE3201,1,-3,15,100.00,1000.00,@Supertest8UUS0101008)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE320201,1,-2,20,100.00,1000.00,@Supertest8UUS0101009)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE320301001,1,-1,25,100.00,1000.00,@Supertest8UUS0101010)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@SupertestTE100101001,1,-1,25,100.00,1000.00,@Supertest8UUS0101011)
GO
