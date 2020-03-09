/*
	Created: 20200303@Tiara
	Date: 20200303
	Task: Update NAP UserControl - SIT [Redmine: 128058]
	DB: DBCUST/NAP_UserControl
*/  
USE [NAP_UserControl]
Go

UPDATE [NAP_UserControl].[dbo].[eaFunction] WITH (ROWLOCK,UPDLOCK)
SET FuncName = 'Edit LiveCasino Setting', FuncDesc = 'Edit LiveCasino Setting', FuncKey = 'LiveCasinoSetting'
WHERE FuncID = 93

UPDATE [NAP_UserControl].[dbo].[eaFunction] WITH (ROWLOCK,UPDLOCK)
SET FuncName = 'Edit LiveCasino Betting Limit', FuncDesc = 'Edit LiveCasino Betting Limit', FuncKey = 'LiveCasinoBetting'
WHERE FuncID = 94
