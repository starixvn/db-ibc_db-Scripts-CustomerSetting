/*
	Created: 20200303@Tiara
	Date: 20200303
	Task: Update NAP UserControl - PRO [Redmine: 128058]
	DB: DBCUST/NAP_UserControl
*/  
USE [NAP_UserControl]
Go

UPDATE [NAP_UserControl].[dbo].[eaFunction] WITH (ROWLOCK,UPDLOCK)
SET FuncName = 'Edit LiveCasino Setting', FuncDesc = 'Edit LiveCasino Setting', FuncKey = 'LiveCasino'
WHERE FuncID = 96

UPDATE [NAP_UserControl].[dbo].[eaFunction] WITH (ROWLOCK,UPDLOCK)
SET FuncName = 'Enable LiveCasino Status', FuncDesc = 'Enable LiveCasino Status', FuncKey = 'EnableLiveCasino'
WHERE FuncID = 97

UPDATE [NAP_UserControl].[dbo].[eaFunction] WITH (ROWLOCK,UPDLOCK)
SET FuncName = 'Edit LiveCasino Betting Limit', FuncDesc = 'Edit LiveCasino Betting Limit', FuncKey = 'LiveCasino'
WHERE FuncID = 98