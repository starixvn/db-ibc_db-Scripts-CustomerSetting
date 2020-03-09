/*
	Created: 20200220@Tiara
	Date: 20200220
	Task: Update ProductStatusSiteCurrency for SAGaming  [Redmine: #128128]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001
	
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, @Bettype, 0, 13, 1, 1, 1  --Do not offer RMB
UNION ALL
SELECT @Sporttype, @Bettype, 0, 45, 1, 1, 1 --Do not offer Won (KRW)


