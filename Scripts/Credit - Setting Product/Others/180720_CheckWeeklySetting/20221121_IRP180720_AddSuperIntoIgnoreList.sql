/*<info serverAlias="DBSPARE-CheckResultDB"></info>*/
/*
	Date: 20221121
	Created: Johnson 
	Task: add super into ignore list [redmine : #180720]
	DB: DBSPARE/CheckResultDB
*/

USE [CheckResultDB]
GO

INSERT INTO [dbo].[IgnoredCust]
           ([CustID]
           ,[RoleID]
           ,[RuleID]
           ,[Sporttype]
           ,[Bettype]
           ,[AllLine]
           ,[ModifiedDate]
           ,[Remark])
SELECT 71921319, 4, 0, 0, 0, 1, GETDATE(), 'internal use (phone betting)'

