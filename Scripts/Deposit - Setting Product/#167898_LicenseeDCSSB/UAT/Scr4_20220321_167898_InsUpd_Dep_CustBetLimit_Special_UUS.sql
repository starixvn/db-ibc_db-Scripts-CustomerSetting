/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220321
	Task:	- Update MaxPayoutPerMatch = MaxPerMatch * 8 IF MaxPerMatch > 1 ELSE MaxPayoutPerMatch = MaxPerMatch by default for Sportbook Sporttypes - UUS
			- Insert data for sporttype 9901,9902( Saba soccer,saba basketball) clone from sporttype IN (1,2) ( soccer,basketball) --UUS
			- Migrate Data from Dep_CustBetLimitGameType_Special to Dep_CustBetLimit_Special for Keno - UUS [Redmine:#167898]	
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
USE CustDB
GO
--Delete redudant data
DELETE c
FROM Dep_CustBetLimit_Special c WITH(ROWLOCK,UPDLOCK)
WHERE sporttype IN(9901,9902,202)

--For SB
UPDATE c
SET c.MaxPayoutPerMatch =CASE WHEN MaxPerMatch >= 1 THEN  MaxPerMatch * 8 ELSE MaxPerMatch END
FROM Dep_CustBetLimit_Special c WITH(ROWLOCK,UPDLOCK)
WHERE c.CurrencyID = 20
	AND c.sporttype IN(1,2,3,5,8,10,11,43,99)

--Insert data for saba soccer, saba basketball
INSERT INTO Dep_CustBetLimit_Special(
	 Site
	,CurrencyID
	,SportType
	,MaxBet
	,MaxPerMatch
	,Bettype
	,AgentID
	,MaxPayoutPerMatch
)
SELECT  Site
	,CurrencyID
	,SportType = SportType + 9900 
	,MaxBet
	,MaxPerMatch
	,Bettype
	,AgentID
	,MaxPayoutPerMatch
FROM Dep_CustBetLimit_Special WITH(NOLOCK)
WHERE SportType IN(1,2) AND bettype = 1
	AND CurrencyID = 20

--For Keno
INSERT INTO Dep_CustBetLimit_Special(
	 Site
	,CurrencyID
	,SportType
	,MaxBet
	,MaxPerMatch
	,Bettype
)
SELECT site
	,currencyid
	,202 AS SportType
	,maxbet
	,maxpergametype
	,1501 AS Bettype
FROM Dep_CustBetLimitGameType_Special WITH(NOLOCK)
WHERE gametypeid = 1
 AND currencyid = 20

/*
SELECT *
FROM Dep_CustBetLimit_Special c WITH(NOLOCK)
WHERE c.CurrencyID = 20
	AND c.sporttype IN(1,2,3,5,8,10,11,43,99,9901,9902)

SELECT *
FROM Dep_CustBetLimit_Special c WITH(NOLOCK)
WHERE c.CurrencyID = 20
	AND Sporttype = 202

*/