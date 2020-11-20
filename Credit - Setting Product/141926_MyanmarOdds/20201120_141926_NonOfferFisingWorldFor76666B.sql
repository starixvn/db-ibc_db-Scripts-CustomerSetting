/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201120
	Task: non offer product Fishing World for new site 76666B currency MMK RedmineID:#141926
	DB: DBCust/CustDB
*/

USE CustDB
GO

DECLARE @SportType SMALLINT,@BetType INT,@SiteID INT,@Currency INT

SELECT @SportType = 219, @BetType = 1011, @SiteID = 547,@Currency = 69 -- MMK
--Hidden when add new customer

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @SportType AS Sporttype, @BetType AS Bettype, @SiteID AS SiteID, @Currency AS Currency, 1, 1, 1  

--Hiden Cansee
DELETE ProductLaunchedSiteCurrency WHERE SiteID   = @SiteID and SportType = @SportType

DELETE WinLimit_ProductSettingDetail WHERE SiteID   = @SiteID and ProductID = 24 AND ExchangeID  in (@Currency)