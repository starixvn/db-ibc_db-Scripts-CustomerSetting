/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210812@Elodie
	Task : add MsgError [redmine:#159628]
	
*/
--Step 1: add MsgError @DBCUST/CustDB
USE CustDB
GO

DECLARE @MsgName NVARCHAR(500) = N'Update Security Code Option unsuccesful. Please try again.'

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN])
SELECT 	40058,5, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, 1, @MsgName

