/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Clear given credit for new created SMAs
	DB: DBMSG/bodb_Message
*/

------------------------------STEP 3: Send personal message--------------------------------------------------------------
DECLARE @Content_en NVARCHAR(4000), @Content_vn NVARCHAR(4000), @Content_ch NVARCHAR(4000), @Content_cs NVARCHAR(4000), @Content_th NVARCHAR(4000)
DECLARE @MessageID INT, @MessageID1 INT, @MessageID2 INT, @Creator INT = 10278938, @CreatorName VARCHAR(50) = 'starixIT', @Max INT, @i INT, @CustID INT, @UserName VARCHAR(30)
DECLARE @PostTime DATETIME = GETDATE()
CREATE TABLE #UplineList (ID INT IDENTITY(1,1), CustId INT, username VARCHAR(30), MsgId INT)

--Send personal message for super
-- English
SET @Content_en = 'Dear valued agents, some of your Masters did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- VietNamese
SET @Content_vn = N'Dear valued agents, some of your Masters did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'

-- Chinese Traditional
SET @Content_ch = N'Dear valued agents, some of your Masters did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'
	
-- Chinese Simplified
SET @Content_cs = N'Dear valued agents, some of your Masters did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'
	
-- Thai
SET @Content_th = N'Dear valued agents, some of your Masters did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- Insert message
EXEC dbo.Dot_Msg_SetMessage2 
	@MessageId	= @MessageID1 OUTPUT,
	@Content_en = @Content_en,
	@Content_ch = @Content_ch,
	@Content_cs = @Content_cs,
	@Content_th = @Content_th,
	@Content_vn = @Content_vn,
	@MsgType	= 1,			 -- message to customer (personal)
	@IsSticky	= 0,			 -- Is special Message or not 
	@Creator	= @Creator,
	@CreatorName = @CreatorName,
	@IsTest		= 0,			 -- Is test or not 
	@IsBatch	= 0			 -- normal message (no need to replace the symbol @@ by transid when display)
	
-- Insert Message Target	
INSERT INTO #UplineList( CustId, username, MsgId)
SELECT DISTINCT m.srecommend, c.username, @MessageID1
FROM DBCUST.CustDB.dbo.CustomerClearCredit m
	INNER JOIN bodb02.dbo.customer c WITH (NOLOCK) ON m.srecommend = c.custid
WHERE m.roleid = 3 AND m.Batch = 1

--Send personal message for master
-- English
SET @Content_en = 'Dear valued agents, some of your Agents did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- VietNamese
SET @Content_vn = N'Dear valued agents, some of your Agents did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- Chinese Traditional
SET @Content_ch = N'Dear valued agents, some of your Agents did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	
	
-- Chinese Simplified
SET @Content_cs = N'Dear valued agents, some of your Agents did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	
	
-- Thai
SET @Content_th = N'Dear valued agents, some of your Agents did not login to agency site within 7 days after creation. System will remove the unused account''s credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- Insert message
EXEC dbo.Dot_Msg_SetMessage2 
	@MessageId	= @MessageID2 OUTPUT,
	@Content_en = @Content_en,
	@Content_ch = @Content_ch,
	@Content_cs = @Content_cs,
	@Content_th = @Content_th,
	@Content_vn = @Content_vn,
	@MsgType	= 1,			 -- message to customer (personal)
	@IsSticky	= 0,			 -- Is special Message or not 
	@Creator	= @Creator,
	@CreatorName = @CreatorName,
	@IsTest		= 0,			 -- Is test or not 
	@IsBatch	= 0			 -- normal message (no need to replace the symbol @@ by transid when display)
	
-- Insert Message Target	
INSERT INTO #UplineList (CustId, username, MsgId)
SELECT DISTINCT a.mrecommend, c.username, @MessageID2
FROM DBCUST.CustDB.dbo.CustomerClearCredit a
	INNER JOIN bodb02.dbo.customer c WITH (NOLOCK) ON a.mrecommend = c.custid
WHERE a.roleid = 2 AND a.Batch = 1

--Send message for user
SET @i = 1
SELECT @Max = COUNT(ID) FROM #UplineList

WHILE @i <= @Max
BEGIN
	SELECT @CustID = custid, @UserName = username, @MessageId = MsgId FROM #UplineList WHERE ID = @i

	EXEC dbo.Dot_Msg_SetUsrMessage
	@MessageId	= @MessageId,
	@TargetId	= @CustID,
	@TargetName = @UserName,
	@PostTime	= @PostTime,
	@isRead		= 0		
		
	SELECT @i = @i + 1
END
