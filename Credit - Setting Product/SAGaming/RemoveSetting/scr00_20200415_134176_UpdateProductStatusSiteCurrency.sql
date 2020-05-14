/*
	Created: 20200514@Tiara
	Date: 20200514
	Task: Update ProductStatusSiteCurrency for SAGaming  [Redmine: #134176]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001
	
DELETE P
FROM ProductStatusSiteCurrency P WITH (ROWLOCK)
WHERE P.SportType=@Sporttype
	AND P.Currency IN (13,5,67)

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, @Bettype, 0, 13, 1, 1, 1  --Do not offer RMB
UNION ALL
SELECT @Sporttype, @Bettype, 0, 5, 1, 1, 1 --Do not offer HK$
UNION ALL
SELECT @Sporttype, @Bettype, 0, 67, 1, 1, 1 --Do not offer HKK


