/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Clear given credit for new created SMAs
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

CREATE TABLE CustomerClearCredit (custid INT PRIMARY KEY, roleid TINYINT, Oldcredit MONEY, srecommend INT, mrecommend INT, recommend INT, LogDate DATETIME, Batch TINYINT)
CREATE TABLE #CustomerList (custid INT PRIMARY KEY, roleid TINYINT, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)
CREATE TABLE #MasterList (custid INT PRIMARY KEY, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)
CREATE TABLE #AgentList (custid INT PRIMARY KEY, username VARCHAR(30), credit MONEY, srecommend INT, mrecommend INT)

------------------------------STEP 0: Clear data in CustomerClearCredit table--------------------------------------------------------------
DELETE FROM CustomerClearCredit

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

INSERT INTO #CustomerList (custid, roleid, username, credit, srecommend, mrecommend)
SELECT custid, roleid, username, credit, srecommend, mrecommend
FROM dbo.custInfo c WITH (NOLOCK)
WHERE c.custid IN (	25082127,25598774,25727113,26298042,29158600,29171426,29741071,30017954,
					31900365,31964230,32052462,32068708,32437385,32533955,32822710,33090574,
					33234156,33329131,33476035,33583839,35165423,35573783,35714246,35814514,35973900)
AND c.roleid = 3


INSERT INTO #CustomerList (custid, roleid, username, credit, srecommend, mrecommend)
SELECT custid, roleid, username, credit, srecommend, mrecommend
FROM dbo.custInfo c WITH (NOLOCK)
WHERE c.custid IN (	30112640,26182354,30222107,25203218,32452951,36129784,26027620,32243076,33834903,27677436,32492053,30144021,24957503,
					27100060,24944138,36074206,32769946,30688134,24246051,27024108,33610887,25939676,25236778,29565218,27462834,28127458,
					23923629,35472985,34253050,30310592,30878890,25788518,29987309,27919976,26191765,24455600,24768221,29596012,25221846,
					27912662,24714794,28808829,26304375,30079427,33085776,24780133,24004318,24061331,24395604,25239908,25015103,24699857,
					26603179,25134050,28122344,24947897,25057520,30002090,25641173,26185213,25978390,25655569,26237801,32533683,26284208,
					26164901,26372379,26646004,26735345,28144348,26919071,27222760,26875868,30091715,27753271,32317775,33774156,27368273,
					28930476,27340261,35864208,28530188,33524796,27541685,27934359,32822729,33235107,28683178,33120121,28092037,28581560,
					28023775,27979582,32924052,32329235,28181764,28250062,29595623,28409599,34123786,28507777,34250227,32989919,28608013,
					28775311,29641775,28743765,28947933,28938520,33297760,35378669,29248037,29293167,35203019,32315544,32908075,33830792,
					31391220,31570482,33298377,32863605,32318495,29766426,29850832,29821946,29899738,29915093,31547815,30841101,
					33389147,28774422,28429169,28943132,26390338,25941024,27705049,24519892,26445704,24181494,36120279,36075734,32504935,
					32314890,30327189,33491178,30063488,30019831,31545177,33160498,31949627,32462500,32011004,33825591,35487718,34177434,
					35637084,31589214,35068019,35170973,31674230,31798324,34068052,33702970,33142937,32650628,31809059,32304339,33385390,
					34149663,33852398,31916964,31919565,32915877,32768002,32238487,32242757,32343071,32408290,33426456,33426514,36106635,
					32365422,32371402,33392030,32553899,33586966,32624300,33547870,33009055,32824126,34086927,32927417,34079140,33186051,
					36164507,33000767,33181048,33403886,33771975,33168535,33319791,33557711,33707525,35810899,33534982,33545980,
					33554560,33660135,35318227,36179651,34535098,34126057,34907983,35340140,33920748,35953573,33948960,33954040,33962683,
					35547246,34018283,35811914,36088237,36034294,35169288,35148290,36022829,35158737,35169599,35695862,35649299,35678648,
					35815243,36069799,36087323,36187100)
AND c.roleid = 2

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
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, Credit MONEY, srecommend INT, mrecommend INT)
DECLARE @Log XML = '', @SB_Error BIT = 0, @LogData VARCHAR(1000), @ActionId INT = 1221
DECLARE @UserId INT = 10278938, @ITName VARCHAR(50) = 'starixIT'

SELECT @LogData = 'Remove the unused account''s credit by IT Admin'

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
	SET	ci.credit = 0
	FROM dbo.custInfo AS ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust c ON c.custid = ci.custid		
		
	SELECT @log = (
						SELECT @UserID as UserID, t.CustID, t.credit as OldValue, 0 as NewValue, '' as IP, @LogData as Doing, @ActionId as ActionID, GETDATE() as LogDate
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

	INSERT INTO dbo.CustomerClearCredit (custid, roleid, Oldcredit, srecommend, mrecommend, recommend, LogDate, Batch)
	SELECT custid, 3, credit, srecommend, mrecommend, 0, GETDATE(), 1
	FROM @tmpCust

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

	INSERT INTO dbo.CustomerClearCredit (custid, roleid, Oldcredit, srecommend, mrecommend, recommend, LogDate, Batch)
	SELECT custid, 2, credit, srecommend, mrecommend, custid, GETDATE(), 1
	FROM @tmpCust

	DELETE @tmpCust

	WAITFOR DELAY '00:00:02'

END

--DROP TABLE #MasterList
--DROP TABLE #AgentList