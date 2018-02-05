/*
    Created: 20180130@Vicky
    Task: Adjust MinBet/MaxBet/MaxPerMatch/MaxPerBall for Sportbook,NumberGame,VirtualSport
    DB: DBCUST/CustDB
*/
---RUN THIS SCRIPT AT DBCUST -----
DECLARE @max_custid INT = xxx


DECLARE @customer_new TABLE (custid INTEGER PRIMARY KEY)
DECLARE @var_newcustomer_total INT = 0
DECLARE @MinBet MONEY       = 1
DECLARE @MaxBet MONEY       = 10
DECLARE @MaxPerMatch MONEY  = 100
DECLARE @MaxPerBall MONEY   = 100

CREATE TABLE #supers (custid INTEGER PRIMARY KEY, isfinished bit DEFAULT(0))

INSERT INTO #supers(custid)
SELECT custid 
FROM dbo.Dep_CustSuper c INNER JOIN DBLIC.bodb_Licensee.dbo.Licensees l ON c.[site] = l.[LicenseeName]
WHERE   l.isActive = 1 
    AND l.[LicenseeName] NOT IN ('haifa','BBin2') 
    AND c.currency = 20


INSERT INTO @customer_new(custid)
SELECT custid
FROM dbo.custinfo c
WHERE c.custid > @max_custid AND c.srecommend IN (SELECT custid FROM #supers)

    
SET @var_newcustomer_total = (SELECT COUNT(*) FROM @customer_new )
RAISERROR ('Total new customer: %d', 0, 1, @var_newcustomer_total) WITH NOWAIT

IF (@var_newcustomer_total = 0) RETURN


--update customer
UPDATE custinfo WITH (ROWLOCK, UPDLOCK)
SET     
    MaxPerMatch     = @MaxPerMatch,
    MaxPerMatch2    = @MaxPerMatch,
    MaxPerMatch3    = @MaxPerMatch,
    MaxPerMatch5    = @MaxPerMatch,
    MaxPerMatch8    = @MaxPerMatch,
    MaxPerMatch10   = @MaxPerMatch,
    MaxPerMatch11   = @MaxPerMatch,
    MaxPerMatch99   = @MaxPerMatch,
    MaxPerMatch99MP = @MaxPerMatch,
    MaxPerMatch1MP  = @MaxPerMatch,
    MaxPerMatch154  = @MaxPerMatch,
    MaxPerMatch161  = @MaxPerMatch,
    MaxPerMatch44   = @MaxPerMatch,
    MaxPerBall161   = @MaxPerBall
WHERE custid IN (SELECT b.custid FROM @customer_new AS b)

--update Dep_CustSetting
UPDATE dc 
SET minbet=@MinBet, maxbet=@MaxBet 
FROM Dep_CustSetting  dc WITH (ROWLOCK, UPDLOCK)
WHERE dc.custid IN (SELECT b.custid FROM @customer_new b) 

      
--for number game
UPDATE dc 
SET minbet=@MinBet, maxbet=@MaxBet 
FROM Dep_CustSetting3rd  dc WITH (ROWLOCK, UPDLOCK)
WHERE custid IN (SELECT b.custid FROM @customer_new AS b)
      AND sporttype = 161
      
      
--update Dep_CustBetSetting_Agent
UPDATE dca 
SET MinBet=@MinBet, MaxBet=@MaxBet, MaxPerMatch=@MaxPerMatch
FROM Dep_CustBetSetting_Agent dca WITH (ROWLOCK, UPDLOCK)
WHERE custid IN (SELECT b.custid FROM @customer_new AS b)
      AND sporttype IN (180,181,182,183,184,185,186,190,191,199)
      
          
--update virtual sport of Member
UPDATE dcm 
SET MinBet=@MinBet, MaxBet=@MaxBet, MaxPerMatch=@MaxPerMatch 
FROM Dep_CustBetSetting_member dcm WITH (ROWLOCK, UPDLOCK)
WHERE custid IN (SELECT b.custid FROM @customer_new AS b)
      AND sporttype IN (180,181,182,183,184,185,186,190,191,199) 
      
