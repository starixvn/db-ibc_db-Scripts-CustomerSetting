/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20220824
	Task: insert data [Dep_ProductSettingType] table [Redmine: #169648]   
	DB: DBCUST/CUSTDB
*/
USE [CustDB]
GO
INSERT INTO [dbo].[Dep_ProductSettingType](SettingType,SettingName,SettingNameDetail)
SELECT 1,'Position Taking','PositionTaking' UNION ALL
SELECT 2,'Bet Setting','BetLimit' UNION ALL
SELECT 4,'Product Status','ProductStatus' UNION ALL
SELECT 5,'Commission','ChargeCommission' UNION ALL
SELECT 7,'Stake Level','SingleStakeLevel' UNION ALL
SELECT 8,'Stake Level','GroupStakeLevel' UNION ALL
SELECT 9,'Commission','PlayerCommission' UNION ALL
SELECT 10,'Bet Setting','GameBetSetting' UNION ALL
SELECT 11,'Bet Setting','NewBetSetting' UNION ALL
SELECT 12,'Bet Setting','GameBetSetting' 