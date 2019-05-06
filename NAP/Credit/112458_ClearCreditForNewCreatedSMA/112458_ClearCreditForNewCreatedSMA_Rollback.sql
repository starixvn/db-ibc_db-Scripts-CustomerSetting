/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Rollback credit for customer who cleared credit by system
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, Credit MONEY, srecommend INT, mrecommend INT)
CREATE TABLE #MasterList (custid INT PRIMARY KEY, credit MONEY, srecommend INT, mrecommend INT)
CREATE TABLE #AgentList (custid INT PRIMARY KEY, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)
DECLARE @Log XML = '', @SB_Error BIT = 0, @LogData VARCHAR(1000), @ActionId INT = 1221
DECLARE @UserId INT = 10278938, @ITName VARCHAR(50) = 'starixIT'

------------------------------STEP 1: Get Customer list--------------------------------------------------------------
--Get masters don't have downlines
INSERT INTO #MasterList (custid, credit, srecommend, mrecommend)
SELECT custid, OldCredit, srecommend, mrecommend
FROM CustomerClearCredit cr WITH (NOLOCK)
WHERE roleid = 3

--Get agents don't have downlines
INSERT INTO #AgentList (custid, credit, srecommend, mrecommend)
SELECT custid, OldCredit, srecommend, mrecommend
FROM CustomerClearCredit cr WITH (NOLOCK)
WHERE roleid = 2

------------------------------STEP 2: Clear credit and write log--------------------------------------------------------------
SELECT @LogData = 'Rollback the unused account''s credit by IT Admin'

--Clear credit for master
WHILE(1=1)
BEGIN
	DELETE TOP (3000) t
	OUTPUT DELETED.custid, DELETED.credit, DELETED.srecommend, DELETED.mrecommend
	INTO @tmpCust 
	FROM #MasterList t
		
	IF @@rowcount = 0 
		BREAK;
			
	UPDATE	ci 
	SET	ci.credit = c.Credit
	FROM dbo.custInfo AS ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust c ON c.custid = ci.custid		
		
	SELECT @log = (
						SELECT @UserID as UserID, t.CustID, 0 as OldValue, credit as NewValue, '' as IP, @LogData as Doing, @ActionId as ActionID, getdate() as LogDate
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
			SELECT	@UserID, custid, 0, credit, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END TRY
		BEGIN CATCH
			SELECT @LogData = @LogData + ' ErrMsg=' + ERROR_MESSAGE()
		
			INSERT INTO bodb_CustomerLog.dbo.userlog_Credit(userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, 0, credit, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END CATCH						
	END	

	DELETE @tmpCust

	WAITFOR DELAY '00:00:02'

END

--Clear credit for agent
WHILE(1=1)
BEGIN
	DELETE TOP (3000) t
	OUTPUT DELETED.custid, DELETED.credit, DELETED.srecommend, DELETED.mrecommend
	INTO @tmpCust 
	FROM #AgentList t
		
	IF @@rowcount = 0 
		BREAK;
			
	UPDATE	ci 
	SET	ci.credit = c.Credit
	FROM dbo.custInfo AS ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust c ON c.custid = ci.custid		
		
	SELECT @log = (
						SELECT @UserID as UserID, t.CustID, 0 as OldValue, credit as NewValue, '' as IP, @LogData as Doing, @ActionId as ActionID, getdate() as LogDate
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
			SELECT	@UserID, custid, 0, credit, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END TRY
		BEGIN CATCH
			SELECT @LogData = @LogData + ' ErrMsg=' + ERROR_MESSAGE()
		
			INSERT INTO bodb_CustomerLog.dbo.userlog_Credit(userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, 0, credit, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END CATCH						
	END		

	DELETE @tmpCust

	WAITFOR DELAY '00:00:02'

END
