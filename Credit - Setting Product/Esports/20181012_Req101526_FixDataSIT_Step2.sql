USE [CustDB]
GO
/*
	Created: Winnie
	Task: Fix Data SIT  RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181012
*/ 

INSERT INTO [CustDB].[dbo].[custOverride]
           ([custid]
           ,[bettype]
           ,[sporttype]
           ,[minpositiontaking]
           ,[maxpositiontaking]
           ,[minlivepositiontaking]
           ,[maxlivepositiontaking])
SELECT
			[custid]
           ,[bettype]
           ,[sporttype]
           ,0
           ,spositiontaking
           ,0
           ,slivepositiontaking
FROM CustSetting WITH(NOLOCK)
WHERE custid=613094 AND sporttype=99

INSERT INTO [CustDB].[dbo].[custOverride]
           ([custid]
           ,[bettype]
           ,[sporttype]
           ,[minpositiontaking]
           ,[maxpositiontaking]
           ,[minlivepositiontaking]
           ,[maxlivepositiontaking])
SELECT
			[custid]
           ,[bettype]
           ,[sporttype]
           ,0
           ,spositiontaking
           ,0
           ,slivepositiontaking
FROM CustSetting WITH(NOLOCK)
WHERE custid=951650 AND sporttype=99

INSERT INTO [CustDB].[dbo].[custOverride]
           ([custid]
           ,[bettype]
           ,[sporttype]
           ,[minpositiontaking]
           ,[maxpositiontaking]
           ,[minlivepositiontaking]
           ,[maxlivepositiontaking])
SELECT
			[custid]
           ,[bettype]
           ,[sporttype]
           ,0
           ,spositiontaking
           ,0
           ,slivepositiontaking
FROM CustSetting WITH(NOLOCK)
WHERE custid=356945 AND sporttype=99



