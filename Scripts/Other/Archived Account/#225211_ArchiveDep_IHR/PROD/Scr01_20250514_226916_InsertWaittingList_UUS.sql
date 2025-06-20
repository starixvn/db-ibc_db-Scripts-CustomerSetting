/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20250514@Tacy
    Task: archive members UUS : [#226916]

		Athena000UUS011904495
		Athena000UUS011904504
		Athena000UUS011904512
		Athena000UUS011904513
		Athena000UUS011904520
		Athena000UUS011905235

		SWSiteUUS01013
    
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

--> Delete waiting agents before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'

DELETE d
OUTPUT deleted.CustID, dbo.f_GetDateTime2()
INTO Dep_Customer_Archived_Del_InHouse (CustID, RepUpdateTime)
FROM  Dep_Customer_Archived d WITH(ROWLOCK)  
	INNER JOIN #TempDeleted t
		ON t.CustID = d.CustID

-- Add List UUS
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
		,s.site
		,s.CustDBGroupID
INTO #Member
FROM Customer c WITH(NOLOCK)
	LEFT JOIN Customer bal WITH(NOLOCK) 
		ON bal.recommend = c.recommend
		AND bal.username like '%ClearBal'
	INNER JOIN Customer ag WITH(NOLOCK) ON c.recommend = ag.custid
	INNER JOIN Site s WITH(NOLOCK) ON s.site = c.site
WHERE c.username IN (
						 'Athena000UUS011904495'
						,'Athena000UUS011904504'
						,'Athena000UUS011904512'
						,'Athena000UUS011904513'
						,'Athena000UUS011904520'
						,'Athena000UUS011905235'
						,'SWSiteUUS01013'
					)
	AND c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

--Create Clearbaldummy if not exists
DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
		@ErrExtraInfo	   VARCHAR(MAX)  = '',
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @tmpDumUserName    VARCHAR(30), 
        @AgentID			INT,
		@SiteDBGroupID		SMALLINT,
		@CustDBGroupID		SMALLINT,
		@Site				VARCHAR(10)


WHILE 1 = 1
BEGIN
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null
		, @ErrExtraInfo='', @ErrMsg = '',@ErrCode = 0
		, @SiteDBGroupID = NULL, @CustDBGroupID = NULL, @Site = NULL

	SELECT TOP(1) @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal', @Site = site
				, @SiteDBGroupID = SiteDBGroupID, @CustDBGroupID = CustDBGroupID
	FROM #Member
	WHERE CustIDBalanceDummy IS NULL

	IF @@ROWCOUNT = 0
		BREAK
	
	-- Insert dummy account on GlobCustDB
	EXEC GlobCustDB.dbo.API_CustomerIns_Register
			@UserName		= @tmpDumUserName
			,@UplineID		= @AgentID
			,@roleid		= 1
			,@SiteDBGroupID	= @CustDBGroupID
			,@site			= @site
			,@CustID		= @tmpClearBalCustID OUT
			,@ErrCode		= @ErrCode OUT
			,@ErrMsg		= @ErrMsg OUT
			,@ErrExtraInfo	= @ErrExtraInfo OUT

	IF @ErrMsg <> ''
	BEGIN
		PRINT 'On GlobCustDB - AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg
		PRINT 'ErrExtraInfo: ' + @ErrExtraInfo

		UPDATE #Member
		SET CustIDBalanceDummy = 0
		WHERE Recommend = @AgentID
	END
	ELSE
	BEGIN
		-- Insert dummy account on CustDB
		EXEC Acc_Dep_CustomerInsMember_Ag 
				 @custid=@tmpClearBalCustID
				,@creator=@creatorID
				,@username=@tmpDumUserName
				,@userpwd=@Pass
				,@recommend=@AgentID
				,@IP=@IP
				,@ErrCode=@ErrCode OUTPUT
				,@ErrMsg=@ErrMsg OUTPUT
				,@ErrExtraInfo=@ErrExtraInfo OUTPUT

		IF @ErrMsg <> ''
		BEGIN
			PRINT 'On CustDB - AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg
			PRINT 'ErrExtraInfo: ' + @ErrExtraInfo
			PRINT 'GlobCustDB: Rollback ClearBalCust - ' + CAST(@tmpClearBalCustID AS VARCHAR)

			UPDATE #Member
			SET CustIDBalanceDummy = 0
			WHERE Recommend = @AgentID

			EXEC GlobCustDB.dbo.Acc_CustomerIns_Rollback @custid = @tmpClearBalCustID
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

DELETE d
OUTPUT deleted.CustID, dbo.f_GetDateTime2()
INTO Dep_Customer_Archived_Del_InHouse (CustID, RepUpdateTime)
FROM  Dep_Customer_Archived d WITH(ROWLOCK)  
	INNER JOIN #Member t
		ON t.CustID = d.CustID

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status],RepUpdateTime)
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status],dbo.f_GetDateTime2()
FROM #Member
WHERE CustIDBalanceDummy<>0


DROP TABLE #Member, #TempDeleted
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Run SSIS package ArchiveDepCust_FullStep.dtsx -------------------------------