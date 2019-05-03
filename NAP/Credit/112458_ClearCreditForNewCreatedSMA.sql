/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Clear given credit for new created SMAs
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
CREATE TABLE #MasterList (custid INT PRIMARY KEY)
CREATE TABLE #AgentList (custid INT PRIMARY KEY)
CREATE TABLE #MemberList (custid INT PRIMARY KEY, username NVARCHAR(50), credit MONEY, srecommend INT, mrecommend INT, recommend INT)
DECLARE @Log XML = '', @SB_Error BIT = 0, @LogData VARCHAR(1000), @UserId INT = 10278938, @ITName VARCHAR(50) = 'starixIT', @ActionId INT = 1221

--Get masters don't have downlines
INSERT INTO #MasterList (custid)
SELECT c.mrecommend
FROM dbo.Custinfo c WITH (NOLOCK) 
WHERE NOT EXISTS (SELECT 1 FROM dbo.Dep_CustSuper s WITH (NOLOCK) WHERE s.custid = c.srecommend)
	AND c.roleid IN (2,3)
GROUP BY c.mrecommend 
HAVING COUNT(1) = 1

--Get agents don't have downlines
INSERT INTO #AgentList (custid)
SELECT c.recommend
FROM dbo.Custinfo c WITH (NOLOCK) 
WHERE NOT EXISTS (SELECT 1 FROM dbo.Dep_CustSuper s WITH (NOLOCK) WHERE s.custid = c.srecommend)
	AND c.roleid IN (1,2)
GROUP BY c.recommend 
HAVING COUNT(1) = 1

--Get member list
INSERT INTO #MemberList (custid, username, credit, srecommend, mrecommend, recommend)
SELECT c.custid, c.username, credit, c.srecommend, c.mrecommend, c.recommend
FROM dbo.vw_Customer c WITH (NOLOCK)	
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON c.custid = ci.custid
WHERE ci.roleid = 1
	AND ci.credit > 0
	AND c.recommend = c.creator	
	AND c.lastlogged IS NULL
	AND c.creatdate <= DATEADD(dd,-7, '20190503')

--exclude masters/agents whose creator is upline
--exclude masters/agents who created before xx days and don't login yet
DELETE m 
FROM #MasterList m 
	INNER JOIN vw_Customer c WITH (NOLOCK) ON c.CustID = m.custid
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = m.custid
	INNER JOIN dbo.CustLoginInfo li WITH (NOLOCK) ON c.CustID = li.custid
WHERE c.creator <> c.srecommend
	OR c.creatdate > DATEADD(dd,-7, '20190503') 
	OR li.isFirstLogin = 0
	OR ci.credit = 0

DELETE a 
FROM #AgentList a 
	INNER JOIN vw_Customer c WITH (NOLOCK) ON c.CustID = a.custid
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = a.custid
	INNER JOIN dbo.CustLoginInfo li WITH (NOLOCK) ON c.CustID = li.custid
WHERE c.creator <> c.mrecommend
	OR c.creatdate > DATEADD(dd,-7, '20190503') 
	OR li.isFirstLogin = 0
	OR ci.credit = 0

--exclude direct accounts
DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = m.custid

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = a.custid

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = a.custid
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = ci.mrecommend

DELETE m 
FROM #MemberList m 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = m.custid

DELETE m 
FROM #MemberList m 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = m.recommend

DELETE m 
FROM #MemberList m 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = m.mrecommend

--exclude exception list used by OPS/Finance (bodb_report.dbo.Task_Cust_ArchiveAcc_Exception)
DELETE m 
FROM #MasterList m 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = m.custid

DELETE a 
FROM #AgentList a 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = a.custid

DELETE m 
FROM #MemberList m 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = m.custid


--exclude internal accounts
DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = m.custid
WHERE cm.IsInternal = 1

DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = m.custid
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = ci.srecommend
WHERE cs.IsInternal = 1

DELETE a 
FROM #AgentList a
	INNER JOIN dbo.CustAgent ca WITH (NOLOCK) ON ca.custid = a.custid
WHERE ca.IsInternal = 1

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = a.custid
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = ci.srecommend
WHERE cs.IsInternal = 1

DELETE a 
FROM #AgentList a 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = a.custid
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = ci.mrecommend
WHERE cm.IsInternal = 1

DELETE m 
FROM #MemberList m 
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = m.srecommend
WHERE cs.IsInternal = 1

DELETE m 
FROM #MemberList m 
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = m.mrecommend
WHERE cm.IsInternal = 1

DELETE m 
FROM #MemberList m 
	INNER JOIN dbo.CustAgent ca WITH (NOLOCK) ON ca.custid = m.mrecommend
WHERE ca.IsInternal = 1

SELECT COUNT(1) FROM #MasterList
SELECT COUNT(1) FROM #AgentList
SELECT COUNT(1) FROM #MemberList

--DROP TABLE #MasterList
--DROP TABLE #AgentList
--DROP TABLE #MemberList

SELECT @LogData = 'System automate Clear Credit'

WHILE(1=1)
BEGIN
	DELETE @tmpCust
		
	DELETE TOP (5000) t
	OUTPUT DELETED.custid
	INTO @tmpCust 
	FROM #MasterList t
		
	IF @@rowcount = 0 
		BREAK;
			
	UPDATE	ci 
	SET	ci.credit = 0
	FROM dbo.custInfo AS ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust c ON c.custid = ci.custid		
		
	SELECT @log = (
						SELECT @UserID as UserID, ci.CustID, ci.credit as OldValue, 0 as NewValue, '' as IP, @LogData as Doing, @ActionId as ActionID, getdate() as LogDate
						FROM @tmpCust t
							INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = t.custid
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
			SELECT	@UserID, custid, oldCredit, 0, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END TRY
		BEGIN CATCH
			SELECT @LogData = @LogData + ' ErrMsg=' + ERROR_MESSAGE()
		
			INSERT INTO bodb_CustomerLog.dbo.userlog_Credit(userid, custid, OldValue, NewValue, ip, doing, ActionID)
			SELECT	@UserID, custid, oldCredit, 0, '', @LogData, @ActionId 
			FROM	@tmpCust 
		END CATCH						
	END	

	DELETE @tmpCust

	WAITFOR DELAY '00:00:00.01'

END
--DROP TABLE #MasterList
--DROP TABLE #AgentList
--DROP TABLE #MemberList