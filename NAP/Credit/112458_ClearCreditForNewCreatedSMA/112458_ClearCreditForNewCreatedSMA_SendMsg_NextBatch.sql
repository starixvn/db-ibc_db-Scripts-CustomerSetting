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

DECLARE @Batch TINYINT = 2
SELECT @MessageID1 = 842518, @MessageID2 = 842519
	
-- Insert Message Target	
INSERT INTO #UplineList( CustId, username, MsgId)
SELECT DISTINCT m.srecommend, c.username, @MessageID1
FROM DBCUST.CustDB.dbo.CustomerClearCredit m
	INNER JOIN bodb02.dbo.customer c WITH (NOLOCK) ON m.srecommend = c.custid
WHERE m.roleid = 3 AND m.Batch = @Batch
	
-- Insert Message Target	
INSERT INTO #UplineList (CustId, username, MsgId)
SELECT DISTINCT a.mrecommend, c.username, @MessageID2
FROM DBCUST.CustDB.dbo.CustomerClearCredit a
	INNER JOIN bodb02.dbo.customer c WITH (NOLOCK) ON a.mrecommend = c.custid
WHERE a.roleid = 2 AND a.Batch = @Batch

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
