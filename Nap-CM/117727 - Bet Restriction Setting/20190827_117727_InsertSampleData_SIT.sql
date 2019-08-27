/*
	Created by: Eden
	Date: 20190827
	Task: Insert sample Data on SIT [Redmine:#117727]	
	DB: DBCUST/CustDB
*/
-->BetRestriction_Customer
DECLARE @supertestlive         INT, 
        @supertestlive01       INT, 
        @supertestlive0101     INT, 
        @supertestlive0101001  INT, 
        @supertestlive30101001 INT,
        ------------------------------- 
        @8RMUUS001             INT, 
        @8RMUUS002             INT, 
        @8RMUUS003             INT, 
        @8RMUUS004             INT, 
        @8RMUUS005             INT

SELECT	@supertestlive = CASE WHEN c.username  = 'supertestlive' THEN c.custid ELSE @supertestlive END,
		@supertestlive01 = CASE WHEN c.username  = 'supertestlive01' THEN c.custid ELSE @supertestlive01 END,
		@supertestlive0101 = CASE WHEN c.username  = 'supertestlive0101' THEN c.custid ELSE @supertestlive0101 END,
		@supertestlive0101001 = CASE WHEN c.username  = 'supertestlive0101001' THEN c.custid ELSE @supertestlive0101001 END,
		@supertestlive30101001 = CASE WHEN c.username  = 'supertestlive30101001' THEN c.custid ELSE @supertestlive30101001 END,
		----
		@8RMUUS001	= CASE WHEN c.username  = '8RMUUS001' THEN c.custid ELSE @8RMUUS001 END,
		@8RMUUS002	= CASE WHEN c.username  = '8RMUUS002' THEN c.custid ELSE @8RMUUS002 END,
		@8RMUUS003	= CASE WHEN c.username  = '8RMUUS003' THEN c.custid ELSE @8RMUUS003 END,
		@8RMUUS004	= CASE WHEN c.username  = '8RMUUS004' THEN c.custid ELSE @8RMUUS004 END,
		@8RMUUS005	= CASE WHEN c.username  = '8RMUUS005' THEN c.custid ELSE @8RMUUS005 END
FROM custinfo c WITH(NOLOCK) 
WHERE c.username IN (
						 'supertestlive'
						,'supertestlive01'
						,'supertestlive0101'
						,'supertestlive0101001'
						,'supertestlive30101001'
						-------------
						,'8RMUUS001'
						,'8RMUUS002'
						,'8RMUUS003'
						,'8RMUUS004'
						,'8RMUUS005'
					)

INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@supertestlive,1,10,20,1000.00,10000.00,@8RMUUS001)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@supertestlive01,1,20,50,2000.00,20000.00,@8RMUUS002)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@supertestlive0101,1,5,10,100.00,30000.00,@8RMUUS003)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@supertestlive0101001,1,-5,25,500.00,5000.00,@8RMUUS004)
INSERT INTO BetRestriction_Customer(CustID, SportType, LiveBetAccept, SeizeBetTicket, MaxBet, MaxPerMatch, FollowAccount) VALUES(@supertestlive30101001,1,3,80,1000.00,10000.00,@8RMUUS005)


