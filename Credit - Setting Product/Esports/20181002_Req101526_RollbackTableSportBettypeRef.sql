/*
	Created: Winnie
	Date: 20181211
	Task: Rollback Esport table Sport_Bettype_Reference Redmine:#101526
	DB: DBTXN/bodb02
*/
USE [bodb02]
GO

INSERT INTO Sport_Bettype_Reference
           ([Bettype]
           ,[Sporttype]
           ,[isLicensee]
           ,[BettypeRef]
           ,[SporttypeRef]
           ,[isActive]
           ,[Site]
           ,[RefTableName])
SELECT [Bettype]
           ,[Sporttype]
           ,[isLicensee]
           ,[BettypeRef]
           ,[SporttypeRef]
           ,[isActive]
           ,[Site]
           ,[RefTableName]
FROM Sport_Bettype_Reference_BKEsport
WHERE  Sporttype=43

