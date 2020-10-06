/*
	Created: 20200918@Winfred
	Task : add MsgError  [redmine:#141926]
	
*/
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
	40055
	,5
	,N'The selected group is not allowed for this site.'
	,N'所選之群組無法存取此站。.'
	,N'所选之群组无法存取此站。.'
	,N'The selected group is not allowed for this site.'
	,N'The selected group is not allowed for this site.'
	,N'The selected group is not allowed for this site.'
	,N'The selected group is not allowed for this site.'
	,N'Nhóm đã chọn không được phép tạo cho site này..'
	,1
	,'The selected group is not allowed for this site.'	   