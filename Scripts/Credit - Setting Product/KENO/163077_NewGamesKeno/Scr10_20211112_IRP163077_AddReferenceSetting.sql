/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20211111@Johnson
	Task: add global settings for new games keno for real currencies
	DB: DBTXN/bodb02
*/

USE [bodb02]
GO

INSERT INTO [dbo].[Sport_Bettype_Reference_Setting]
           ([SportType]
           ,[BetType]
           ,[isLicensee]
           ,[isLive]
           ,[Site]
           ,[isActive]
           ,[SportTypeRefPT]
           ,[BetTypeRefPT]
           ,[isLivePT]
           ,[TablePT]
           ,[StructureVerPT]
           ,[SportTypeRefComm]
           ,[BetTypeRefComm]
           ,[TableComm]
           ,[StructureVerComm]
           ,[SportTypeRefBetSetting]
           ,[BetTypeRefBetSetting]
           ,[TableBetSetting]
           ,[StructureVerBetSetting]
           ,[IsLiveComm]
           ,[IsLiveBetSetting])
SELECT [SportType]
           ,t.[BetType]
           ,[isLicensee]
           ,[isLive]
           ,[Site]
           ,[isActive]
           ,[SportTypeRefPT]
           ,[BetTypeRefPT]
           ,[isLivePT]
           ,[TablePT]
           ,[StructureVerPT]
           ,[SportTypeRefComm]
           ,[BetTypeRefComm]
           ,[TableComm]
           ,[StructureVerComm]
           ,[SportTypeRefBetSetting]
           ,[BetTypeRefBetSetting]
           ,[TableBetSetting]
           ,[StructureVerBetSetting]
           ,[IsLiveComm]
           ,[IsLiveBetSetting]
FROM  Sport_Bettype_Reference_Setting s (NOLOCK)
	CROSS APPLY (SELECT 1530 as bettype UNION SELECT 1531) t
WHERE SportType = 202
	AND s.BetType = 1515
	AND site <> 'CN88'  
	
	  