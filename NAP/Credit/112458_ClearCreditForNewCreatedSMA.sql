/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Clear given credit for new created SMAs
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, Credit MONEY)
CREATE TABLE #CustomerList (custid INT PRIMARY KEY, roleid TINYINT, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)
CREATE TABLE #MasterList (custid INT PRIMARY KEY, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)
CREATE TABLE #AgentList (custid INT PRIMARY KEY, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)
DECLARE @Log XML = '', @SB_Error BIT = 0, @LogData VARCHAR(1000), @ActionId INT = 1221
DECLARE @UserId INT = 10278938, @ITName VARCHAR(50) = 'starixIT'

------------------------------STEP 1: Get Customer list--------------------------------------------------------------
--Get customer list
INSERT INTO #CustomerList (custid, roleid, username, credit, srecommend, mrecommend)
SELECT c.custid, ci.roleid, c.username, ci.credit, c.srecommend, c.mrecommend
FROM vw_Customer c WITH (NOLOCK) 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = c.custid
	INNER JOIN dbo.CustLoginInfo li WITH (NOLOCK) ON c.CustID = li.custid
WHERE NOT EXISTS (SELECT 1 FROM dbo.Dep_CustSuper s WITH (NOLOCK) WHERE s.custid = c.srecommend)
	AND c.currency <> 20
	AND c.site <> 'CN88'
	AND c.creator = CASE WHEN c.roleid = 3 THEN c.srecommend ELSE c.mrecommend END
	AND c.roleid IN (2, 3)
	AND ci.credit > 0
	AND c.creatdate < DATEADD(dd,-7, '20190507') 
	AND li.isFirstLogin = 1

--Get masters don't have downlines
INSERT INTO #MasterList (custid)
SELECT c.mrecommend 
FROM dbo.Custinfo c WITH (NOLOCK) 
	INNER JOIn #CustomerList m WITH (NOLOCK) ON c.mrecommend = m.custid
WHERE c.roleid IN (2,3) AND m.roleid = 3
GROUP BY c.mrecommend 
HAVING COUNT(1) = 1

--Get agents don't have downlines
INSERT INTO #AgentList (custid)
SELECT c.recommend 
FROM dbo.Custinfo c WITH (NOLOCK) 
	INNER JOIn #CustomerList m WITH (NOLOCK) ON c.recommend = m.custid
WHERE c.roleid IN (1,2) AND m.roleid = 2
GROUP BY c.recommend 
HAVING COUNT(1) = 1

----------------
UPDATE m 
SET m.username = c.username,
	m.credit = c.credit,
	m.srecommend = c.srecommend,
	m.mrecommend = c.mrecommend
FROM #MasterList m 
	INNER JOIN #CustomerList c ON c.custid = m.custid

UPDATE a 
SET a.username = c.username,
	a.credit = c.credit,
	a.srecommend = c.srecommend,
	a.mrecommend = c.mrecommend
FROM #AgentList a 
	INNER JOIN #CustomerList c ON c.custid = a.custid

--exclude direct accounts
DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = m.custid

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = a.custid

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = a.mrecommend

--exclude exception list used by OPS/Finance (bodb_report.dbo.Task_Cust_ArchiveAcc_Exception)
DELETE m 
FROM #MasterList m 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = m.custid

DELETE a 
FROM #AgentList a 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = a.custid

--exclude internal accounts
DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = m.custid
WHERE cm.IsInternal = 1

DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = m.srecommend
WHERE cs.IsInternal = 1

DELETE a 
FROM #AgentList a
	INNER JOIN dbo.CustAgent ca WITH (NOLOCK) ON ca.custid = a.custid
WHERE ca.IsInternal = 1

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = a.srecommend
WHERE cs.IsInternal = 1

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = a.mrecommend
WHERE cm.IsInternal = 1

SELECT COUNT(1) FROM #MasterList
SELECT COUNT(1) FROM #AgentList

--DROP TABLE #MasterList
--DROP TABLE #AgentList
--DROP TABLE #CustomerList

------------------------------STEP 2: Clear credit and write log--------------------------------------------------------------
SELECT @LogData = 'System automate Clear Credit'

--Clear credit for master
WHILE(1=1)
BEGIN
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, Deleted.credit
	INTO @tmpCust 
	FROM #MasterList t
		
	IF @@rowcount = 0 
		BREAK;
			
	UPDATE	ci 
	SET	ci.credit = 0
	FROM dbo.custInfo AS ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust c ON c.custid = ci.custid		
		
	SELECT @log = (
						SELECT @UserID as UserID, t.CustID, t.credit as OldValue, 0 as NewValue, '' as IP, @LogData as Doing, @ActionId as ActionID, getdate() as LogDate
						FROM @tmpCust t
						FOR XML RAW('Row')
					)

	EXEC bodb_CustomerLog.sb.CustomerLog_SendMessage @xml = @log, 
													@MessageType='MessageType_CustomerLog_UserLog_Credit', 
													@functionName = 'UserLog_Others',
													@SB_Error = @SB_Error out

	--if ssb error
	IF @SB_Error = 1
	BEGIN
		-- Write log
		BEGIN TRY
			INSERT INTO DBLOG.bodb_CustomerLog.dbo.Userlog_Credit (userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, credit, 0, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END TRY
		BEGIN CATCH
			SELECT @LogData = @LogData + ' ErrMsg=' + ERROR_MESSAGE()
		
			INSERT INTO bodb_CustomerLog.dbo.userlog_Credit(userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, credit, 0, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END CATCH						
	END	

	DELETE @tmpCust

	WAITFOR DELAY '00:00:00.01'

END

--Clear credit for agent
WHILE(1=1)
BEGIN
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, Deleted.credit
	INTO @tmpCust 
	FROM #AgentList t
		
	IF @@rowcount = 0 
		BREAK;
			
	UPDATE	ci 
	SET	ci.credit = 0
	FROM dbo.custInfo AS ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust c ON c.custid = ci.custid		
		
	SELECT @log = (
						SELECT @UserID as UserID, t.CustID, t.credit as OldValue, 0 as NewValue, '' as IP, @LogData as Doing, @ActionId as ActionID, getdate() as LogDate
						FROM @tmpCust t
						FOR XML RAW('Row')
					)

	EXEC bodb_CustomerLog.sb.CustomerLog_SendMessage @xml = @log, 
													@MessageType='MessageType_CustomerLog_UserLog_Credit', 
													@functionName = 'UserLog_Others',
													@SB_Error = @SB_Error out

	--if ssb error
	IF @SB_Error = 1
	BEGIN
		-- Write log
		BEGIN TRY
			INSERT INTO DBLOG.bodb_CustomerLog.dbo.Userlog_Credit (userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, credit, 0, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END TRY
		BEGIN CATCH
			SELECT @LogData = @LogData + ' ErrMsg=' + ERROR_MESSAGE()
		
			INSERT INTO bodb_CustomerLog.dbo.userlog_Credit(userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, credit, 0, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END CATCH						
	END	

	DELETE @tmpCust

	WAITFOR DELAY '00:00:00.01'

END

------------------------------STEP 3: Send personal message--------------------------------------------------------------
--Send personal message
DECLARE @Content_en NVARCHAR(4000), @Content_vn NVARCHAR(4000), @Content_ch NVARCHAR(4000), @Content_cs NVARCHAR(4000), @Content_th NVARCHAR(4000)
DECLARE @MessageID INT, @Creator INT = 10278938, @CreatorName VARCHAR(50) = 'starixIT', @Max INT, @i INT, @CustID INT, @UserName VARCHAR(30)
DECLARE @PostTime DATETIME = GETDATE()
CREATE TABLE #UplineList (ID INT IDENTITY(1,1), CustId INT, username VARCHAR(30))

-- English
SET @Content_en = 'Dear valued agents, '
					+ '<br />' + 'Some of your agents were closed because their members have had No Activity in the last 3 months. You can re-open them if you wish to keep their businesses. '
					+ '<br />' + 'Please be informed that the account will be disabled after being closed for 1 month, and you cannot recover a disabled account. '
					+ '<br />' + 'Thank you. '	

-- VietNamese
SET @Content_vn = N'Kính gửi quý khách hàng, '
					+ N'<br />' + N'Một số đại lý của bạn đã bị đóng vì các thành viên của họ đã Không Có Hoạt Động Nào trong 3 tháng qua. Bạn có thể mở lại nếu bạn muốn giữ những đại lý này. '
					+ N'<br />' + N'Xin lưu ý rằng tài khoản sẽ bị vô hiệu sau khi đóng trong 1 tháng và bạn không thể khôi phục tài khoản bị vô hiệu. '
					+ N'<br />' + N'Trân Trọng. '

-- Chinese Traditional
SET @Content_ch = N'尊敬的代理們，'
					+ N'<br />' + N'由於您代理及其會員賬號已長達近 3 個月無活躍操作因此已關閉。倘若關閉賬號持有者有意繼續進行生意仍可重啟賬號。 '
					+ N'<br />' + N'請知悉，賬號將在關閉後的一個月被禁用。禁用後的賬號將無法重啟。 '
					+ N'<br />' + N'謝謝。'
	
-- Chinese Simplified
SET @Content_cs = N'尊敬的代理们，'
					+ N'<br />' + N'由于您代理及其会员账号已长达近 3 个月无活跃操作因此已关闭。倘若关闭账号持有者有意继续进行生意仍可重启账号。 '
					+ N'<br />' + N'请知悉，账号将在关闭后的一个月被禁用。禁用后的账号将无法重启。 '
					+ N'<br />' + N'谢谢。 '
	
-- Thai
SET @Content_th = N'เรียนเอเจนต์ทุกท่าน '
					+ N'<br />' + N'เอเจนต์ของคุณบางบัญชีถูกปิดเนื่องจากบัญชีสมาชิกไม่มีการใช้งานใดๆ ในช่วง 3เดือนที่ผ่านมา คุณสามารถเปิดกลับอีกครั้งหากต้องการทำธุรกิจต่อและรักษาบัญชีดังกล่าวไว้ '
					+ N'<br />' + N'โปรดทราบว่าบัญชีจะถูกปิดใช้งานหลังจากปิดให้บริการเป็นเวลา 1 เดือนและคุณจะไม่สามารถกู้คืนบัญชีที่ถูกปิดใช้งานได้ '
					+ N'<br />' + N'ขอบคุณค่ะ '	

-- Insert message
EXEC dbo.Dot_Msg_SetMessage2 
	@MessageId	= @MessageId OUTPUT,
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
INSERT INTO #UplineList( CustId, username )
SELECT DISTINCT m.srecommend, c.username
FROM #MasterList m
	INNER JOIN dbo.customer c WITH (NOLOCK) ON m.srecommend = c.custid

INSERT INTO #UplineList( CustId, username )
SELECT DISTINCT a.mrecommend, c.username
FROM #AgentList a
	INNER JOIN dbo.customer c WITH (NOLOCK) ON a.mrecommend = c.custid

SET @i = 1
SELECT @Max = COUNT(ID) FROM #UplineList

WHILE @i <= @Max
BEGIN
	SELECT @CustID = custid, @UserName = username FROM #UplineList WHERE ID = @i

	EXEC dbo.Dot_Msg_SetUsrMessage
	@MessageId	= @MessageId,
	@TargetId	= @CustID,
	@TargetName = @UserName,
	@PostTime	= @PostTime,
	@isRead		= 0		
		
	SELECT @i = @i + 1
END

--DROP TABLE #MasterList
--DROP TABLE #AgentList
