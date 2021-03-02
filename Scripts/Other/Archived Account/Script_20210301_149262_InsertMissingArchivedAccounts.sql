/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210301@Eden
	Task: Insert missing archived info for masters 4140770, 15493067, 18313830, 32247548 and their downlines [RM#149262]
	DB: DBCUST/CustDB
*/
DECLARE @S1_ArchivedDate DATETIME  = '2021-01-20'
DECLARE @S2_ArchivedDate DATETIME = '2021-02-23'

SELECT c.custid, 
       username, 
       c.roleid,
	   CAST(0 AS BIT ) AS IsFinished
INTO #TmpAgentMaster
FROM custinfo c WITH(NOLOCK)
     LEFT JOIN Cust_ArchiveAccount a WITH(NOLOCK)
       ON c.custid = a.CustID
WHERE c.mrecommend IN(4140770, 15493067, 18313830, 32247548)
ORDER BY roleid

--SELECT * FROM #TmpAgentMaster

--Process data for Stage 1
DECLARE @CustID INT, @Username VARCHAR(30), @RoleID TINYINT
DECLARE @LogSPData varchar(5000),
	@UserID int = 360418,
	@ErrMsg nvarchar(200) = '',
	@ErrCode int = 0

WHILE 1 = 1
BEGIN
	UPDATE TOP(1) t
	SET t.IsFinished = 1,
		@CustID = t.custid,
		@RoleID = t.roleid,
		@Username = t.username
	FROM #TmpAgentMaster t
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;
	
	--Insert Archived log
	IF @RoleID = 2
	BEGIN
		--Log S1
		SELECT @LogSPData = '<DBA_ArchiveAccount1_CloseAgentLine AccName="'+ coalesce(cast(@Username as varchar(50)),space(1)) + '" ' +
			'UserID="'+ coalesce(cast(@UserID as varchar(50)),space(1)) + '" ' +
			'ErrMsg="'+ coalesce(cast(@ErrMsg as varchar(400)),space(1)) + '" ' +
			'ErrCode="'+ coalesce(cast(@ErrCode as varchar(50)),space(1)) + '" />'

		INSERT INTO DBLOG.bodb_CustomerLog.dbo.UserLog_RunSP(UserID, CustID, ActionID, TrackingValue, Duration, logdate)
		SELECT @UserID, @CustID, 1115 AS ActionID, @LogSPData AS TrackingValue, 0 AS Duration, @S1_ArchivedDate

		--Log S2
		Select @LogSPData = '<DBA_ArchiveAccount2_DisableAgentLine AccName="'+ coalesce(cast(@Username as varchar(50)),space(1))+ '" ' +
					'UserID="'+ coalesce(cast(@UserID as varchar(50)),space(1)) + '" ' +
					'ErrMsg="'+ coalesce(cast(@ErrMsg as varchar(400)),space(1))+ '" ' +
					'ErrCode="'+ coalesce(cast(@ErrCode as varchar(50)),space(1))  + '"/>'

		INSERT INTO DBLOG.bodb_CustomerLog.dbo.UserLog_RunSP(UserID, CustID, ActionID, TrackingValue, Duration, logdate)
		SELECT @UserID, @CustID, 1178 AS ActionID, @LogSPData AS TrackingValue, 0 AS Duration, @S2_ArchivedDate
	END
	ELSE IF @RoleID = 3
	BEGIN
		--Log S1
		SELECT @LogSPData = '<DBA_ArchiveAccount1_CloseMaster AccName="'+ coalesce(cast(@Username as varchar(50)),space(1)) + '" ' +
						'UserID="'+ coalesce(cast(@UserID as varchar(50)),space(1)) + '" ' +
						'ErrMsg="'+ coalesce(cast(@ErrMsg as varchar(400)),space(1)) + '" ' +
						'ErrCode="'+ coalesce(cast(@ErrCode as varchar(50)),space(1)) + '" />'

		INSERT INTO DBLOG.bodb_CustomerLog.dbo.UserLog_RunSP(UserID, CustID, ActionID, TrackingValue, Duration, logdate)
		SELECT @UserID, @CustID, 1175 AS ActionID, @LogSPData AS TrackingValue, 0 AS Duration, @S1_ArchivedDate

		--Log S2
		Select @LogSPData = '<DBA_ArchiveAccount2_DisableMasterSuper AccName="'+ coalesce(cast(@Username as varchar(50)),space(1))+ '" ' +
						'UserID="'+ coalesce(cast(@UserID as varchar(50)),space(1)) + '" ' +
						'ErrMsg="'+ coalesce(cast(@ErrMsg as varchar(400)),space(1))+ '" ' +
						'ErrCode="'+ coalesce(cast(@ErrCode as varchar(50)),space(1))  + '"/>'

		INSERT INTO DBLOG.bodb_CustomerLog.dbo.UserLog_RunSP(UserID, CustID, ActionID, TrackingValue, Duration, logdate)
		SELECT @UserID, @CustID, 1177 AS ActionID, @LogSPData AS TrackingValue, 0 AS Duration, @S2_ArchivedDate
	END

	--Insert update Cust_ArchiveAccount info - S1 
	EXEC dbo.[Acc_DormantAccountList_InsertUpdate] 
		@CustId = @CustID,
		@RoleID = @RoleID,
		@StageID = 1,
		@ProcessedDate = @S1_ArchivedDate,
		@ArchivedDate = @S1_ArchivedDate

	--Insert update Cust_ArchiveAccount info - S2
	EXEC dbo.[Acc_DormantAccountList_InsertUpdate] 
		@CustId = @CustID,
		@RoleID = @RoleID,
		@StageID = 2,
		@ProcessedDate = @S2_ArchivedDate,
		@ArchivedDate = @S2_ArchivedDate
END

DROP TABLE #TmpAgentMaster