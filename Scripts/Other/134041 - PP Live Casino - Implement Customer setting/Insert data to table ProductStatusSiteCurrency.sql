/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20210330@Tina
	Task: Support QC test - Non offer PP Live Casino for 733333
	DB: DBCUST/CustDB
*/

USE CustDB
GO


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced)
SELECT 170 SportType, 3701 BetType, 20 Currency, 21 SiteID, 1 IsHidden, 1 IsDisabled, 1 HasSynced --21: 733333

