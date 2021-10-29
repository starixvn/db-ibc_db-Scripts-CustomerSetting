/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211027@Winfred
	Task: add MsgError NAP CM -  Limit Daily PT Update [#RM:162476]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE FROM MsgError WHERE MsgID = 10068
--Step 1: add MsgError @DBCUST/CustDB

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
	SELECT 	
		10068 AS MsgID
		,5 AS MsgGroupID
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after <mm/dd/yyyy> 12:00 PM GMT +8.' AS [MsgNameEN]
		,N'' AS [MsgNameCT]
		,N'' AS [MsgNameCS]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after <mm/dd/yyyy> 12:00 PM GMT +8.' AS [MsgNameJP]
		,N'' AS [MsgNameTH]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after <mm/dd/yyyy> 12:00 PM GMT +8.' AS [MsgNameKO]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after <mm/dd/yyyy> 12:00 PM GMT +8.' AS [MsgNameES]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after <mm/dd/yyyy> 12:00 PM GMT +8.' AS [MsgNameVI]
		,1 AS [IsActive]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after <mm/dd/yyyy> 12:00 PM GMT +8.' AS [MsgNameCN] 
	