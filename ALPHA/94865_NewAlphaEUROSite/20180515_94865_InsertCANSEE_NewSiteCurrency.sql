/*
	Created: 20180515@Elodie
	Task: Insert data into ProductLaunchedSiteCurrency table when inserting new site/currency
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT, @site INT, @currency INT, @IsTest BIT

SELECT @site = 294, @currency = 78
SELECT @IsTest = 0

DELETE ProductLaunchedSiteCurrency WHERE SiteID = @site

SELECT @Sporttype = 44 --Muay Thai
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

--Not launched yet
--SELECT @Sporttype = 160 --Lucky 3
--INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
--SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 180 --Virtual Soccer
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 190 --Virtual Soccer League
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 192 --Virtual Soccer World Cup
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 193 --Virtual Basketball
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

----Not launched yet
--SELECT @Sporttype = 207 --Bullfighting
--INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
--SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 211 --Allbet
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 219 --Fishing World
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 220 --Lottery
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest
