/*
	Created: 20210322@Winfred
	Task : add MsgError  [redmine:#151526]
	
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
	40056
	,5
	,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
	,N'.'
	,N'.'
	,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
	,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
	,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
	,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
	,N'Xin lỗi, bạn không thể tạo thêm tài khoản. Số tài khoản tối đa được tạo mỗi ngày là 300.'
	,1
	,'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'	   