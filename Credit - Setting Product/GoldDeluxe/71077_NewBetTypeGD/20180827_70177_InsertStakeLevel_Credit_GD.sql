/*
	Created: Elodie
	Date: 20180827
	Task: Initial data of StakeLevel for Sicbo
*/

USE [CustDB]
GO

DELETE FROM dbo.StakeLevel WHERE GameTypeID = 1704
GO

CREATE TABLE #tmpStakeLevel( GameTypeID INT, MinLabel NVARCHAR(50), MaxLabel NVARCHAR(50), MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8), CurrencyCode VARCHAR(3), BetGroup NVARCHAR(20), CurrencyId INT)

INSERT INTO #tmpStakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, CurrencyCode, BetGroup)
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'SGD' AS CurrencyName, 'GD0001' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'SGD' AS CurrencyName, 'GD0001' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'SGD' AS CurrencyName, 'GD0001' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'SGD' AS CurrencyName, 'GD0001' AS BetGroup UNION ALL
SELECT 1704, '5' AS MinLabel, '1,000' AS MaxLabel, 5 AS MinStake, 1000 AS MaxStake, 'MYR' AS CurrencyName, 'GD0002' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '2,500' AS MaxLabel, 20 AS MinStake, 2500 AS MaxStake, 'MYR' AS CurrencyName, 'GD0002' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'MYR' AS CurrencyName, 'GD0002' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'MYR' AS CurrencyName, 'GD0002' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0003' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0003' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0003' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0003' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '10,000' AS MaxLabel, 50 AS MinStake, 10000 AS MaxStake, 'THB' AS CurrencyName, 'GD0004' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '25,000' AS MaxLabel, 250 AS MinStake, 25000 AS MaxStake, 'THB' AS CurrencyName, 'GD0004' AS BetGroup UNION ALL
SELECT 1704, '1,000' AS MinLabel, '50,000' AS MaxLabel, 1000 AS MinStake, 50000 AS MaxStake, 'THB' AS CurrencyName, 'GD0004' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'THB' AS CurrencyName, 'GD0004' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,500' AS MaxLabel, 10 AS MinStake, 1500 AS MaxStake, 'HKD' AS CurrencyName, 'GD0005' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '5,000' AS MaxLabel, 50 AS MinStake, 5000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0005' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0005' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '20,000' AS MaxLabel, 500 AS MinStake, 20000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0005' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '25,000' AS MaxLabel, 500 AS MinStake, 25000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0005' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'EUR' AS CurrencyName, 'GD0006' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'EUR' AS CurrencyName, 'GD0006' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'EUR' AS CurrencyName, 'GD0006' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'EUR' AS CurrencyName, 'GD0006' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'GBP' AS CurrencyName, 'GD0012' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'GBP' AS CurrencyName, 'GD0012' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'GBP' AS CurrencyName, 'GD0012' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'GBP' AS CurrencyName, 'GD0012' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,500' AS MaxLabel, 10 AS MinStake, 1500 AS MaxStake, 'CNY' AS CurrencyName, 'GD0013' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '5,000' AS MaxLabel, 50 AS MinStake, 5000 AS MaxStake, 'CNY' AS CurrencyName, 'GD0013' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'CNY' AS CurrencyName, 'GD0013' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '20,000' AS MaxLabel, 500 AS MinStake, 20000 AS MaxStake, 'CNY' AS CurrencyName, 'GD0013' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '25,000' AS MaxLabel, 500 AS MinStake, 25000 AS MaxStake, 'CNY' AS CurrencyName, 'GD0013' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0015' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'IDR' AS CurrencyName, 'GD0015' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0015' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0015' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0016' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0016' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0016' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0016' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0017' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0017' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0017' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0017' AS BetGroup UNION ALL
SELECT 1704, '1' AS MinLabel, '100' AS MaxLabel, 1 AS MinStake, 100 AS MaxStake, 'UUS' AS CurrencyName, 'GD0020' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '2,500' AS MaxLabel, 20 AS MinStake, 2500 AS MaxStake, 'UUS' AS CurrencyName, 'GD0020' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '500' AS MaxLabel, 50 AS MinStake, 500 AS MaxStake, 'UUS' AS CurrencyName, 'GD0020' AS BetGroup UNION ALL
SELECT 1704, '1,000' AS MinLabel, '5,000' AS MaxLabel, 1000 AS MinStake, 5000 AS MaxStake, 'UUS' AS CurrencyName, 'GD0020' AS BetGroup UNION ALL
SELECT 1704, '25,000' AS MinLabel, '1,000,000' AS MaxLabel, 25000 AS MinStake, 1000000 AS MaxStake, 'UUS' AS CurrencyName, 'GD0020' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'CAD' AS CurrencyName, 'GD0021' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'CAD' AS CurrencyName, 'GD0021' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'CAD' AS CurrencyName, 'GD0021' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'CAD' AS CurrencyName, 'GD0021' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0022' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'IDR' AS CurrencyName, 'GD0022' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0022' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0022' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '10,000' AS MaxLabel, 50 AS MinStake, 10000 AS MaxStake, 'TWD' AS CurrencyName, 'GD0030' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '25,000' AS MaxLabel, 250 AS MinStake, 25000 AS MaxStake, 'TWD' AS CurrencyName, 'GD0030' AS BetGroup UNION ALL
SELECT 1704, '1,000' AS MinLabel, '50,000' AS MaxLabel, 1000 AS MinStake, 50000 AS MaxStake, 'TWD' AS CurrencyName, 'GD0030' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'TWD' AS CurrencyName, 'GD0030' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '20,000' AS MaxLabel, 100 AS MinStake, 20000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0031' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '50,000' AS MaxLabel, 500 AS MinStake, 50000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0031' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0031' AS BetGroup UNION ALL
SELECT 1704, '5,000' AS MinLabel, '250,000' AS MaxLabel, 5000 AS MinStake, 250000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0031' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '20,000' AS MaxLabel, 100 AS MinStake, 20000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0032' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '50,000' AS MaxLabel, 500 AS MinStake, 50000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0032' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0032' AS BetGroup UNION ALL
SELECT 1704, '5,000' AS MinLabel, '250,000' AS MaxLabel, 5000 AS MinStake, 250000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0032' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0033' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'IDR' AS CurrencyName, 'GD0033' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0033' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0033' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0034' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'IDR' AS CurrencyName, 'GD0034' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0034' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0034' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0035' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0035' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0035' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0035' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0036' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0036' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0036' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0036' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'JPY' AS CurrencyName, 'GD0037' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0037' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'JPY' AS CurrencyName, 'GD0037' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'JPY' AS CurrencyName, 'GD0037' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0040' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0040' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0040' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0040' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'CHF' AS CurrencyName, 'GD0041' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'CHF' AS CurrencyName, 'GD0041' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'CHF' AS CurrencyName, 'GD0041' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'CHF' AS CurrencyName, 'GD0041' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '20,000' AS MaxLabel, 100 AS MinStake, 20000 AS MaxStake, 'PHP' AS CurrencyName, 'GD0042' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '50,000' AS MaxLabel, 500 AS MinStake, 50000 AS MaxStake, 'PHP' AS CurrencyName, 'GD0042' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'PHP' AS CurrencyName, 'GD0042' AS BetGroup UNION ALL
SELECT 1704, '5,000' AS MinLabel, '250,000' AS MaxLabel, 5000 AS MinStake, 250000 AS MaxStake, 'PHP' AS CurrencyName, 'GD0042' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '10,000' AS MaxLabel, 50 AS MinStake, 10000 AS MaxStake, 'THB' AS CurrencyName, 'GD0043' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '25,000' AS MaxLabel, 250 AS MinStake, 25000 AS MaxStake, 'THB' AS CurrencyName, 'GD0043' AS BetGroup UNION ALL
SELECT 1704, '1,000' AS MinLabel, '50,000' AS MaxLabel, 1000 AS MinStake, 50000 AS MaxStake, 'THB' AS CurrencyName, 'GD0043' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'THB' AS CurrencyName, 'GD0043' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'BND' AS CurrencyName, 'GD0046' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'BND' AS CurrencyName, 'GD0046' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'BND' AS CurrencyName, 'GD0046' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'BND' AS CurrencyName, 'GD0046' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'IDR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'IDR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0047' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0048' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0048' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0048' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'ZAR' AS CurrencyName, 'GD0048' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'MXN' AS CurrencyName, 'GD0049' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'MXN' AS CurrencyName, 'GD0049' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'MXN' AS CurrencyName, 'GD0049' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'MXN' AS CurrencyName, 'GD0049' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'CAD' AS CurrencyName, 'GD0050' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'CAD' AS CurrencyName, 'GD0050' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'CAD' AS CurrencyName, 'GD0050' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'CAD' AS CurrencyName, 'GD0050' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '3,000' AS MaxLabel, 20 AS MinStake, 3000 AS MaxStake, 'INH' AS CurrencyName, 'GD0051' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '7,500' AS MaxLabel, 70 AS MinStake, 7500 AS MaxStake, 'INH' AS CurrencyName, 'GD0051' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'INH' AS CurrencyName, 'GD0051' AS BetGroup UNION ALL
SELECT 1704, '750' AS MinLabel, '30,000' AS MaxLabel, 750 AS MinStake, 30000 AS MaxStake, 'INH' AS CurrencyName, 'GD0051' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,500' AS MaxLabel, 10 AS MinStake, 1500 AS MaxStake, 'DKK' AS CurrencyName, 'GD0052' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '5,000' AS MaxLabel, 50 AS MinStake, 5000 AS MaxStake, 'DKK' AS CurrencyName, 'GD0052' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'DKK' AS CurrencyName, 'GD0052' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '25,000' AS MaxLabel, 500 AS MinStake, 25000 AS MaxStake, 'DKK' AS CurrencyName, 'GD0052' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,500' AS MaxLabel, 10 AS MinStake, 1500 AS MaxStake, 'SEK' AS CurrencyName, 'GD0053' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '5,000' AS MaxLabel, 50 AS MinStake, 5000 AS MaxStake, 'SEK' AS CurrencyName, 'GD0053' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'SEK' AS CurrencyName, 'GD0053' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '25,000' AS MaxLabel, 500 AS MinStake, 25000 AS MaxStake, 'SEK' AS CurrencyName, 'GD0053' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,500' AS MaxLabel, 10 AS MinStake, 1500 AS MaxStake, 'NOK' AS CurrencyName, 'GD0054' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '5,000' AS MaxLabel, 50 AS MinStake, 5000 AS MaxStake, 'NOK' AS CurrencyName, 'GD0054' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'NOK' AS CurrencyName, 'GD0054' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '25,000' AS MaxLabel, 500 AS MinStake, 25000 AS MaxStake, 'NOK' AS CurrencyName, 'GD0054' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '10,000' AS MaxLabel, 50 AS MinStake, 10000 AS MaxStake, 'RUB' AS CurrencyName, 'GD0055' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '25,000' AS MaxLabel, 250 AS MinStake, 25000 AS MaxStake, 'RUB' AS CurrencyName, 'GD0055' AS BetGroup UNION ALL
SELECT 1704, '1,000' AS MinLabel, '50,000' AS MaxLabel, 1000 AS MinStake, 50000 AS MaxStake, 'RUB' AS CurrencyName, 'GD0055' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'RUB' AS CurrencyName, 'GD0055' AS BetGroup UNION ALL
SELECT 1704, '5' AS MinLabel, '1,000' AS MaxLabel, 5 AS MinStake, 1000 AS MaxStake, 'PLN' AS CurrencyName, 'GD0056' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '2,500' AS MaxLabel, 20 AS MinStake, 2500 AS MaxStake, 'PLN' AS CurrencyName, 'GD0056' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'PLN' AS CurrencyName, 'GD0056' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'PLN' AS CurrencyName, 'GD0056' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '10,000' AS MaxLabel, 50 AS MinStake, 10000 AS MaxStake, 'CZK' AS CurrencyName, 'GD0057' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '25,000' AS MaxLabel, 250 AS MinStake, 25000 AS MaxStake, 'CZK' AS CurrencyName, 'GD0057' AS BetGroup UNION ALL
SELECT 1704, '1,000' AS MinLabel, '50,000' AS MaxLabel, 1000 AS MinStake, 50000 AS MaxStake, 'CZK' AS CurrencyName, 'GD0057' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'CZK' AS CurrencyName, 'GD0057' AS BetGroup UNION ALL
SELECT 1704, '5' AS MinLabel, '1,000' AS MaxLabel, 5 AS MinStake, 1000 AS MaxStake, 'RON' AS CurrencyName, 'GD0058' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '2,500' AS MaxLabel, 20 AS MinStake, 2500 AS MaxStake, 'RON' AS CurrencyName, 'GD0058' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'RON' AS CurrencyName, 'GD0058' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'RON' AS CurrencyName, 'GD0058' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '20,000' AS MaxLabel, 100 AS MinStake, 20000 AS MaxStake, 'INR' AS CurrencyName, 'GD0061' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '50,000' AS MaxLabel, 500 AS MinStake, 50000 AS MaxStake, 'INR' AS CurrencyName, 'GD0061' AS BetGroup UNION ALL
SELECT 1704, '2,500' AS MinLabel, '100,000' AS MaxLabel, 2500 AS MinStake, 100000 AS MaxStake, 'INR' AS CurrencyName, 'GD0061' AS BetGroup UNION ALL
SELECT 1704, '5,000' AS MinLabel, '250,000' AS MaxLabel, 5000 AS MinStake, 250000 AS MaxStake, 'INR' AS CurrencyName, 'GD0061' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0064' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0064' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0064' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0064' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0065' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0065' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0065' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0065' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,500' AS MaxLabel, 10 AS MinStake, 1500 AS MaxStake, 'HKD' AS CurrencyName, 'GD0067' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '5,000' AS MaxLabel, 50 AS MinStake, 5000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0067' AS BetGroup UNION ALL
SELECT 1704, '250' AS MinLabel, '10,000' AS MaxLabel, 250 AS MinStake, 10000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0067' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '20,000' AS MaxLabel, 500 AS MinStake, 20000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0067' AS BetGroup UNION ALL
SELECT 1704, '500' AS MinLabel, '25,000' AS MaxLabel, 500 AS MinStake, 25000 AS MaxStake, 'HKD' AS CurrencyName, 'GD0067' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0068' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0068' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0068' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0068' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '300' AS MaxLabel, 2 AS MinStake, 300 AS MaxStake, 'MMK' AS CurrencyName, 'GD0069' AS BetGroup UNION ALL
SELECT 1704, '7' AS MinLabel, '750' AS MaxLabel, 7 AS MinStake, 750 AS MaxStake, 'MMK' AS CurrencyName, 'GD0069' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '1,000' AS MaxLabel, 20 AS MinStake, 1000 AS MaxStake, 'MMK' AS CurrencyName, 'GD0069' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '3,000' AS MaxLabel, 70 AS MinStake, 3000 AS MaxStake, 'MMK' AS CurrencyName, 'GD0069' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '300' AS MaxLabel, 2 AS MinStake, 300 AS MaxStake, 'MMK' AS CurrencyName, 'GD0070' AS BetGroup UNION ALL
SELECT 1704, '7' AS MinLabel, '750' AS MaxLabel, 7 AS MinStake, 750 AS MaxStake, 'MMK' AS CurrencyName, 'GD0070' AS BetGroup UNION ALL
SELECT 1704, '20' AS MinLabel, '1,000' AS MaxLabel, 20 AS MinStake, 1000 AS MaxStake, 'MMK' AS CurrencyName, 'GD0070' AS BetGroup UNION ALL
SELECT 1704, '70' AS MinLabel, '3,000' AS MaxLabel, 70 AS MinStake, 3000 AS MaxStake, 'MMK' AS CurrencyName, 'GD0070' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'USD' AS CurrencyName, 'GD0074' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'USD' AS CurrencyName, 'GD0074' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'USD' AS CurrencyName, 'GD0074' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'USD' AS CurrencyName, 'GD0074' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'EUR' AS CurrencyName, 'GD0078' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'EUR' AS CurrencyName, 'GD0078' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'EUR' AS CurrencyName, 'GD0078' AS BetGroup UNION ALL
SELECT 1704, '2' AS MinLabel, '500' AS MaxLabel, 2 AS MinStake, 500 AS MaxStake, 'AUD' AS CurrencyName, 'GD0009' AS BetGroup UNION ALL
SELECT 1704, '10' AS MinLabel, '1,000' AS MaxLabel, 10 AS MinStake, 1000 AS MaxStake, 'AUD' AS CurrencyName, 'GD0009' AS BetGroup UNION ALL
SELECT 1704, '50' AS MinLabel, '2,500' AS MaxLabel, 50 AS MinStake, 2500 AS MaxStake, 'AUD' AS CurrencyName, 'GD0009' AS BetGroup UNION ALL
SELECT 1704, '100' AS MinLabel, '5,000' AS MaxLabel, 100 AS MinStake, 5000 AS MaxStake, 'AUD' AS CurrencyName, 'GD0009' AS BetGroup

UPDATE t
SET t.CurrencyId = CAST(RIGHT(BetGroup,2) AS INT)
FROM #tmpStakeLevel t

--SELECT * FROM #tmpStakeLevel

INSERT INTO [dbo].[StakeLevel]
           ([GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId])
SELECT s.GameTypeID, s.MinLabel, s.MaxLabel, s.MinStake, s.MaxStake, e.exchangeid
FROM #tmpStakeLevel s
	INNER JOIN dbo.exchange e ON e.exchangeid = s.CurrencyId

--SELECT * FROM StakeLevel WHERE GameTypeId = 1704

DROP TABLE #tmpStakeLevel


