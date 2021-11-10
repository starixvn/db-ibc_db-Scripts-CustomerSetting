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
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after {0} 12:00 PM GMT +8.' AS [MsgNameEN]
		,N'您已達到每日更新佔成的最高次數（2 次）。請在 {0} 下午 12:00 GMT +8 之後重試。' AS [MsgNameCT]
		,N'您已达到每日更新占成的最高次数（2 次）。请在 {0} 下午 12:00 GMT +8 之后重试。' AS [MsgNameCS]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after {0} 12:00 PM GMT +8.' AS [MsgNameJP]
		,N'การอัปเดตการตั้งค่าความเสี่ยงของคุณถึงขีดจำกัดสูงสุดต่อวันแล้ว (2 ครั้ง ) โปรดลองอีกครั้งหลังจาก {0} 12:00 PM GMT +8' AS [MsgNameTH]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after {0} 12:00 PM GMT +8.' AS [MsgNameKO]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after {0} 12:00 PM GMT +8.' AS [MsgNameES]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after {0} 12:00 PM GMT +8.' AS [MsgNameVI]
		,1 AS [IsActive]
		,N' You have reached the maximum 2 times of daily allowed times of updating position taking. Please try again after {0} 12:00 PM GMT +8.' AS [MsgNameCN] 
	