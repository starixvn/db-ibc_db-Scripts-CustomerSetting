/*
	Created: Johnson
	Date: 2018/11/30
	Task: insert missing keno setting for KeenOceanSuperUUS
	DB:DBCUST/CustDB
*/
USE CUSTDB
GO

INSERT INTO [dbo].[CustSettingGame]
           ([CustID]
           ,[Bettype]
           ,[Sporttype]
           ,[apositiontaking]
           ,[mpositiontaking]
           ,[spositiontaking]
           ,[playerdiscount]
           ,[discount]
           ,[adiscount]
           ,[sdiscount]
           ,[autopositiontaking]
           ,[isautopositiontaking]
           ,[autompositiontaking]
           ,[isautompositiontaking])
SELECT 14373714 [CustID]
    ,1501 [Bettype]
    ,202 [Sporttype]
    ,0.9 [apositiontaking]
    ,0.9 [mpositiontaking]
    ,0.9 [spositiontaking]
    ,0 [playerdiscount]
    ,0 [discount]
    ,0 [adiscount]
    ,0 [sdiscount]
    ,0 [autopositiontaking]
    ,0 [isautopositiontaking]
    ,0 [autompositiontaking]
    ,0 [isautompositiontaking]
 --	KeenOceanSuperUUS
UNION SELECT 	14373715,1501,202,0,0.9,0,0,0,0,0,0,0,0,0	--	KeenOceanUUS
UNION SELECT 	14373717,1501,202,0,0.9,0,0,0,0,0,0,0,0,0	--	KeenOceanACCUUS
UNION SELECT 	14373718,1501,202,0,0,0.9,0,0,0,0,0,0,0,0	--	KeenOceanACCUUS01
UNION SELECT 	14373716,1501,202,0,0,0.9,0,0,0,0,0,0,0,0	--	KeenOceanUUS01 