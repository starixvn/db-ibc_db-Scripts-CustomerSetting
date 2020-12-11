/*
	Created: 20201211@Winfred
	Task : add MsgError Turn off VIP For BA player   [redmine:#146508]
	
*/
--Step 1: add MsgError @DBCUST/CustDB

DECLARE @MsgName  NVARCHAR(256) = 'This is VIP player. To turn on BA, please turn off VIP for the player first.'

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
	200050
	,5
	,@MsgName
	,N'此玩家是VIP。 如要為玩家開啟BA，請先將玩家移出VIP。'
	,N'此玩家是VIP。如要为玩家开启BA，请先将玩家移出VIP。'
	,@MsgName
	,@MsgName
	,@MsgName
	,@MsgName
	,@MsgName
	,1
	,@MsgName   