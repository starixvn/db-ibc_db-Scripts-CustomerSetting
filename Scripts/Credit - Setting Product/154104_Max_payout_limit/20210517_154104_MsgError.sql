/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210524@Winfred
	Task: add MsgError of Parlay Max Payout [#RM:154104]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE FROM MsgError WHERE MsgID BETWEEN 10055 AND 10058
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
		10055 AS MsgID
		,5 AS MsgGroupID
		,N'The value must be a positive amount.' AS [MsgNameEN]
		,N'該數額必須為正數' AS [MsgNameCT]
		,N'该数额必须为正数' AS [MsgNameCS]
		,N'The value must be a positive amount.' AS [MsgNameJP]
		,N'ค่าต้องเป็นจำนวนบวก' AS [MsgNameTH]
		,N'The value must be a positive amount.' AS [MsgNameKO]
		,N'The value must be a positive amount.' AS [MsgNameES]
		,N'The value must be a positive amount.' AS [MsgNameVI]
		,1 AS [IsActive]
		,N'The value must be a positive amount.' AS [MsgNameCN] 
	UNION ALL
	SELECT 	
		10056 AS MsgID
		,5 AS MsgGroupID
		,N'<BetType>: The setting of <Column> is higher than the upline''s.''' AS [MsgNameEN]
		,N'<BetType>: 該設置 <Column>高於上線。' AS [MsgNameCT]
		,N'(BetType): 该设置 (Column)高于上线。' AS [MsgNameCS]
		,N'<BetType>: The setting of <Column> is higher than the upline''s.''' AS [MsgNameJP]
		,N'<BetType>: การตั้งค่า <Column> สูงกว่าของอัพไลน์' AS [MsgNameTH]
		,N'<BetType>: The setting of <Column> is higher than the upline''s.''' AS [MsgNameKO]
		,N'<BetType>: The setting of <Column> is higher than the upline''s.''' AS [MsgNameES]
		,N'<BetType>: The setting of <Column> is higher than the upline''s.''' AS [MsgNameVI]
		,1 AS [IsActive]
		,N'<BetType>: The setting of <Column> is higher than the upline''s.''' AS [MsgNameCN] 	
	UNION ALL
	SELECT 	
		10057 AS MsgID
		,5 AS MsgGroupID
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameEN]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameCT]
		,N'(BetType): The setting of <Column> is higher than the company setting' AS [MsgNameCS]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameJP]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameTH]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameKO]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameES]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameVI]
		,1 AS [IsActive]
		,N'<BetType>: The setting of <Column> is higher than the company setting' AS [MsgNameCN] 	
	UNION ALL
	SELECT 	
		10058 AS MsgID
		,5 AS MsgGroupID
		,N'Applying this setting will override some downlines'' setting value which are currently higher than this new value. Are you sure you want to proceed?' AS [MsgNameEN]
		,N'應用此設置將覆蓋一些下線設定值高於目前的新值，您確定要進行嗎？' AS [MsgNameCT]
		,N'应用此设置将覆盖一些下线设定值高于目前的新值，您确定要进行吗？' AS [MsgNameCS]
		,N'Applying this setting will override some downlines'' setting value which are currently higher than this new value. Are you sure you want to proceed?' AS [MsgNameJP]
		,N'การใช้การตั้งค่านี้จะแทนที่การตั้งค่าของดาวน์ไลน์บางราย ซึ่งปัจจุบันสูงกว่าการตั้งค่าใหม่ คุณแน่ใจหรือไม่ว่าต้องการดำเนินการต่อ' AS [MsgNameTH]
		,N'Applying this setting will override some downlines'' setting value which are currently higher than this new value. Are you sure you want to proceed?' AS [MsgNameKO]
		,N'Applying this setting will override some downlines'' setting value which are currently higher than this new value. Are you sure you want to proceed?' AS [MsgNameES]
		,N'Applying this setting will override some downlines'' setting value which are currently higher than this new value. Are you sure you want to proceed?' AS [MsgNameVI]
		,1 AS [IsActive]
		,N'Applying this setting will override some downlines'' setting value which are currently higher than this new value. Are you sure you want to proceed?' AS [MsgNameCN] 							
