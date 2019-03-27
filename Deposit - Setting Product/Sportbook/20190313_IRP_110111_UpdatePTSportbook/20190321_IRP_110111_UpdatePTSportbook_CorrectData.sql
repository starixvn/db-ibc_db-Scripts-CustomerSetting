/*
	Created: Elodie
	Task: Correct PT settings of SB for licensees [RedmineID: #110111]
	DB: DBCUST/CustDB
	Date: 20190321
*/ 

USE CustDB
GO

--Roleid = 3
--44 affected rows
UPDATE cs
SET cs.apositiontaking = 0
FROM dbo.Dep_CustSetting cs WITH (ROWLOCK)
WHERE custid = 836207

--Roleid = 2
--352 affected rows
UPDATE cs
SET cs.mpositiontaking = 0
FROM dbo.Dep_CustSetting cs WITH (ROWLOCK)
WHERE custid IN (857559,858136,1256667,1317816,1415683,1418545,1418702,1431082)

--Roleid = 1
--1320 affected rows
UPDATE cs
SET cs.mpositiontaking = 0
FROM dbo.Dep_CustSetting cs WITH (ROWLOCK)
WHERE custid IN (	11225052, 11225608, 11225611, 11225613, 11225614, 11239574, 11239579, 11239582, 11878224, 11878229, 11878251, 11878784, 11878810, 11879079, 
					18522296, 18522297, 18522307, 18522308, 18522309, 18522310, 18522311, 18522312, 26431615, 26431616, 26431628, 26431629, 26431630, 26431631, 
					26431632, 26431633)

--44 affected rows
UPDATE cs
SET cs.apositiontaking = 0
FROM dbo.Dep_CustSetting cs WITH (ROWLOCK)
WHERE custid = 4227538
