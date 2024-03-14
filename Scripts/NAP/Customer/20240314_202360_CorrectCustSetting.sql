/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240314
	Task: Correct CustSetting [Redmine: #202360]
	DB: DBCUST/CustDB
*/
USE CustDB 
GO

DECLARE @CustList TABLE(custid INT)
DECLARE @SportBettypeList TABLE(Sporttype SMALLINT, Bettype SMALLINT)

INSERT INTO @custList(custid)
SELECT custid 
FROM custinfo with (NOLOCK)
WHERE srecommend IN (7178181,	-- BS-USD
					7216595,	-- BS-CNY
					10400071,	-- BS-IDR
					7145795		-- EXPENSES
				)	
	AND roleid IN (2,3,4)

INSERT INTO @SportBettypeList(Sporttype, Bettype)
SELECT 2, 10 UNION ALL
SELECT 3, 10 UNION ALL
SELECT 5, 10 UNION ALL
SELECT 8, 10 UNION ALL
SELECT 10, 10 UNION ALL
SELECT 11, 10 UNION ALL
SELECT 99, 10 

INSERT INTO custSetting([custid]
      ,[bettype]
      ,[sporttype]
      ,[apositiontaking]
      ,[mpositiontaking]
      ,[spositiontaking]
      ,[alivepositiontaking]
      ,[mlivepositiontaking]
      ,[slivepositiontaking]
      ,[playerdiscount]
      ,[discount]
      ,[adiscount]
      ,[sdiscount]
      ,[groupa]
      ,[groupb]
      ,[groupc]
      ,[groupd]
      ,[groupe]
      ,[groupf]
	  ,[DEL_minbet]
	  ,[DEL_maxbet]
      ,[autopositiontaking]
      ,[autolivepositiontaking]
      ,[isautopositiontaking]
      ,[isautolivepositiontaking]
      ,[autompositiontaking]
      ,[autolivempositiontaking]
      ,[isautompositiontaking]
      ,[isautolivempositiontaking])
SELECT  [custid]
      ,[bettype]
      ,[sporttype]
      ,[apositiontaking]
      ,[mpositiontaking]
      ,[spositiontaking]
      ,[alivepositiontaking]
      ,[mlivepositiontaking]
      ,[slivepositiontaking]
      ,[playerdiscount]
      ,[discount]
      ,[adiscount]
      ,[sdiscount]
      ,[groupa]
      ,[groupb]
      ,[groupc]
      ,[groupd]
      ,[groupe]
      ,[groupf]
	  ,[DEL_minbet]
	  ,[DEL_maxbet]
      ,[autopositiontaking]
      ,[autolivepositiontaking]
      ,[isautopositiontaking]
      ,[isautolivepositiontaking]
      ,[autompositiontaking]
      ,[autolivempositiontaking]
      ,[isautompositiontaking]
      ,[isautolivempositiontaking]
FROM @CustList 
	CROSS APPLY @SportBettypeList
	CROSS APPLY (
		SELECT 
			   0 AS [apositiontaking]
			  ,0 AS [mpositiontaking]
			  ,0 AS [spositiontaking]
			  ,0 AS [alivepositiontaking]
			  ,0 AS [mlivepositiontaking]
			  ,0 AS [slivepositiontaking]
			  ,0 AS [playerdiscount]
			  ,0 AS [discount]
			  ,0 AS [adiscount]
			  ,0 AS [sdiscount]
			  ,0 AS [groupa]
			  ,0 AS [groupb]
			  ,0 AS [groupc]
			  ,0 AS [groupd]
			  ,0 AS [groupe]
			  ,0 AS [groupf]
			  ,0 AS [DEL_minbet]
			  ,0 AS [DEL_maxbet]
			  ,0 AS [autopositiontaking]
			  ,0 AS [autolivepositiontaking]
			  ,0 AS [isautopositiontaking]
			  ,0 AS [isautolivepositiontaking]
			  ,0 AS [autompositiontaking]
			  ,0 AS [autolivempositiontaking]
			  ,0 AS [isautompositiontaking]
			  ,0 AS [isautolivempositiontaking]
			)t

