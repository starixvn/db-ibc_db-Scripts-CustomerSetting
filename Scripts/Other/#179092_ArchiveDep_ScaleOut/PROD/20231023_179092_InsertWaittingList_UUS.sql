/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20231023
    Task: archive members UUS : [#179092]
		Athena000UUS011937036
		Athena000UUS011937045
		Athena000UUS011905177
		Athena000UUS011905179
		Athena000UUS011905054
		Athena000UUS011905160
    DB: DBCUST/CustDB
*/ 

---------------------------Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------
USE CustDB
GO
--Check LinkedServer
SELECT TOP 1 1 AS CheckLinkedServer FROM _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1 UNION ALL
SELECT TOP 1 1						FROM _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1

IF @@ERROR <> 0
	RETURN

TRUNCATE TABLE Dep_Customer_Archived_Config -- avoid scan current agent on PRODUCTION config

SELECT   c.[CustID]
		,[ArchivedDate] = GETDATE()
		,[Username] =  c.username
		,[Username2] = c.username2
		,[Recommend] = c.recommend
		,[ClosingBalance] = CAST(0 AS MONEY)
		,[CustIDBalanceDummy] = bal.custid
		,[Status] = 'waiting'
		,ag.username AS Agent
		,s.SiteDBGroupID
INTO #Member
FROM Customer c WITH(NOLOCK)
	LEFT JOIN Customer bal WITH(NOLOCK) 
		ON bal.recommend = c.recommend
		AND bal.username like '%ClearBal'
	INNER JOIN Customer ag WITH(NOLOCK) ON c.recommend = ag.custid
	INNER JOIN Site s WITH(NOLOCK) ON s.site = c.site
WHERE c.username IN (
						 'Athena000UUS011937036'
						,'Athena000UUS011937045'
						,'Athena000UUS011905177'
						,'Athena000UUS011905179'
						,'Athena000UUS011905054'
						,'Athena000UUS011905160'
					)
	AND c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

--Create Clearbaldummy if not exists
DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @tmpDumUserName    VARCHAR(30), 
        @AgentID			INT,
		@SiteDBGroupID		SMALLINT

WHILE 1 = 1
BEGIN
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null, @ErrMsg = '',@ErrCode = 0, @SiteDBGroupID = NULL

	SELECT TOP(1) @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal', @SiteDBGroupID = SiteDBGroupID
	FROM #Member
	WHERE CustIDBalanceDummy IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	EXEC Acc_Dep_CustomerInsMember_Ag 
		@custid=@tmpClearBalCustID OUTPUT
		,@creator=@creatorID
		,@username=@tmpDumUserName
		,@userpwd=@Pass
		,@recommend=@AgentID
		,@IP=@IP
		,@ErrCode=@ErrCode OUTPUT
		,@ErrMsg=@ErrMsg OUTPUT

	IF @ErrMsg <> ''
	BEGIN
		PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg

		UPDATE #Member
		SET CustIDBalanceDummy = 0
		WHERE Recommend = @AgentID
	END
	ELSE 
	BEGIN
		PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': Create ClearBal dummy successfully'

		UPDATE #Member
		SET CustIDBalanceDummy = @tmpClearBalCustID
		WHERE Recommend = @AgentID
		
		IF @SiteDBGroupID = 1
		BEGIN
			--> Use LinkedServer to connect Sitedb --> Insert Task_Cust_CheckBalance_Exception on SiteDB
			IF NOT EXISTS( SELECT 1 FROM _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE custid = @tmpClearBalCustID)
			BEGIN
				INSERT INTO _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception(custid, remark) values(@tmpClearBalCustID, @tmpDumUserName)
			END
		END
		ELSE IF @SiteDBGroupID = 2
		BEGIN
			--> Use LinkedServer to connect Sitedb --> Insert Task_Cust_CheckBalance_Exception on SiteDB
			IF NOT EXISTS( SELECT 1 FROM _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE custid = @tmpClearBalCustID)
			BEGIN
				INSERT INTO _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception(custid, remark) values(@tmpClearBalCustID, @tmpDumUserName)
			END
		END
	END
END

--Update ClosingBalance
UPDATE #Member 
SET [ClosingBalance] = b.MemberBalance
FROM #Member
INNER JOIN (
	SELECT custid, ISNULL(SUM(winlost-actual_stake+playercomm),0) as MemberBalance
	FROM DBACC.bodb02.dbo.transfer WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #Member)
	GROUP BY custid
	) b ON #Member.custid = b.custid

DELETE C
FROM [Dep_Customer_Archived] C WITH(ROWLOCK)
	INNER JOIN #Member T ON C.CustID = T.custid

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status])
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status]
FROM #Member


DROP TABLE #Member
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Run SSIS package ArchiveDepCust_FullStep.dtsx -------------------------------