/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210913
	Task: Support script to Archive Stage 2 due to job failed unexpectedly(Sep 13) [Redmine: #161532]   
	DB: DBCUST/CUSTDB
*/
USE [CustDB]
GO

SET NOCOUNT ON
	
DECLARE @srecommend INT
		, @mrecommend INT
		, @ReduceCredit MONEY = 0
		, @OldCredit MONEY = 0
		, @LogData VARCHAR(500)
		, @custid INT
		, @NewCredit MONEY = 0
		, @RealDownlineCredit MONEY = 0
		, @username NVARCHAR(MAX)
		, @recommend INT
		, @ArchivedDate	DATE = GETDATE() --keep time stamp for Cust_ArchiveAccount
		, @ProcessedDate DATETIME 
		, @ArchivedCustID INT
		, @IsOverwrite	BIT
		, @stage tinyint

DECLARE @status varchar(200), @GroupLevelName VARCHAR(10) = '' 
DECLARE @agent varchar(50), @ErrMsg VARCHAR(150), @msg VARCHAR(100), @roleid_tmp INT, @S1M1_username NVARCHAR(100)
CREATE TABLE #ReduceCredit (CustId INT,RoleID TINYINT,GroupLevelName VARCHAR(10), srecommend INT,Credit MONEY, ReduceCredit MONEY DEFAULT(0), IsFinished BIT DEFAULT(0))
CREATE TABLE #ArchiveMasterSuper_tmp (CustID INT, RoleID TINYINT, GroupLevelName VARCHAR(10),username NVARCHAR(100), IsFinished BIT DEFAULT(0))
	
--Detect StageID
if (@stage is null)
begin
	select @status = VValue from DBACC.bodb02.dbo.SystemSettings with(nolock) where VName = 'aa_Status'
	select @stage = case @status 
		when 'Stage 1 - Running' then 1
		when 'Stage 2 - Running' then 2
		when 'Stage 3 - Running' then 3
		when 'Stage 4 - Running' then 4
		else 0 end
end

IF @stage = 2
BEGIN
							
	INSERT INTO #ReduceCredit (CustId,srecommend,RoleID,Credit)
	SELECT c.custid, c.srecommend, 3 ,credit
	FROM (SELECT DISTINCT Master FROM dbo.tmpCustArchived  WITH (NOLOCK)) AS t
		CROSS APPLY (SELECT custid,srecommend,credit FROM dbo.custInfo c1 WITH (NOLOCK) WHERE c1.username= t.Master and c1.roleid = 3) AS c
		
	INSERT INTO #ReduceCredit (CustId,srecommend,RoleID,Credit)
	SELECT c.custid, c.custid, 4,credit
	FROM (SELECT DISTINCT super FROM dbo.tmpCustArchived  WITH (NOLOCK)) AS t
		CROSS APPLY (SELECT custid,credit FROM dbo.custInfo c1 WITH (NOLOCK) WHERE c1.username= t.Super and c1.roleid = 4) AS c 
		
	EXEC DBA_ArchiveAccount_GenMasterSuperGroupLevel @StageId = @stage

	---Exclude finished agent and correct ReduceCredit info for them
	;WITH TempTBL AS(
	SELECT r.CustId, 
		SUM(ISNULL(ca.ReducedCredit,0)) AS ReducedCredit
	FROM tmpCustArchived a WITH (NOLOCK) 
		INNER JOIN custInfo c WITH(NOLOCK) ON a.recommend = c.custid
		INNER JOIN #ReduceCredit r ON r.custid IN (c.mrecommend,c.srecommend)
		INNER JOIN Cust_ArchiveAccount ca WITH(NOLOCK) ON a.recommend = ca.CustID
	WHERE a.IsFinished = 1 
		AND a.ErrMsg = ''
	GROUP BY r.CustId
	)
	UPDATE r
	SET r.ReduceCredit = t.ReducedCredit
	FROM #ReduceCredit r 
		INNER JOIN TempTBL t ON r.CustId = t.CustId
	-------------------------------------------------------------------
		
	WHILE(1=1)
	BEGIN
		SELECT @ErrMsg = ''

		SELECT TOP (1) @agent = Agent, @recommend = recommend 
		FROM tmpCustArchived a WITH (NOLOCK) 
		WHERE IsFinished = 0

		IF (@@ROWCOUNT = 0) BREAK
		
		EXEC dbo.DBA_ArchiveAccount2_DisableAgentLine @AccName = @agent, @ErrMsg = @ErrMsg OUTPUT, @srecommend = @srecommend OUTPUT, @mrecommend = @mrecommend OUTPUT, @ReduceCredit = @ReduceCredit OUTPUT,@ArchivedDate = @ArchivedDate
			
		UPDATE tmpCustArchived 
		SET ErrMsg = @ErrMsg, IsFinished = 1
		WHERE Agent = @agent

		IF @ErrMsg = ''
		BEGIN
			IF @ReduceCredit <>  0
			BEGIN
				UPDATE #ReduceCredit
					SET ReduceCredit = ReduceCredit + @ReduceCredit
				WHERE CustId IN (@srecommend, @mrecommend)

				--Writelog clear given credit for Agent
				SELECT  @LogData = 'Update Credits for SMA Account '+ COALESCE(@agent, SPACE(1))  

				BEGIN TRY
					EXEC DBLOG.bodb_CustomerLog.dbo.WriteLog_UserLog_Credit
						@UserID = 360418,
						@CustID = @recommend,
						@Doing = @LogData,
						@OldValue = @ReduceCredit,
						@NewValue = 0,
						@IP = '100.100.100.100',
						@ActionID = 1222
				END TRY
				BEGIN CATCH
					SELECT @LogData = @LogData + ' ErrMsg:' + ERROR_MESSAGE()

					EXEC bodb_CustomerLog.dbo.WriteLog_UserLog_Credit
						@UserID = 360418,
						@CustID = @recommend,
						@Doing = @LogData,
						@OldValue = @ReduceCredit,
						@NewValue = 0,
						@IP = '100.100.100.100',
						@ActionID = 1222
				END CATCH
			END	
		END
	
		SET @msg = 'Stage 2 - Done Agent Level ' + @agent + CHAR(13)
		RAISERROR(@msg, 0, 0) WITH NOWAIT	
			
		WAITFOR DELAY '00:00:00.120'
		--IF (@ErrMsg <> '') BREAK
	END

	--Gen List Super Master into tmpCustGroupLevelArchived
	EXEC DBA_ArchiveAccount_GenMasterSuperGroupLevel @StageId = @stage

		
		
	-- Processing for M0, M1, S1
	INSERT INTO #ArchiveMasterSuper_tmp (CustID, GroupLevelName, RoleID, username)
	SELECT ar.custid, ar.GroupLevelName, ar.Roleid, ci.username
	FROM dbo.tmpCustGroupLevelArchived ar WITH (NOLOCK)
		INNER JOIN dbo.custinfo ci WITH (NOLOCK)  ON ar.custid = ci.custid
	WHERE ar.GroupLevelName IN ('S1','M1','M0')
	ORDER BY ar.Roleid
		
	IF EXISTS (SELECT TOP (1) 1 FROM #ArchiveMasterSuper_tmp)
	BEGIN
		WHILE(1=1)
		BEGIN
			SELECT @ErrMsg = ''
			SELECT @ProcessedDate = GETDATE()
				
			UPDATE TOP (1) t
				SET  IsFinished = 1
					, @S1M1_username = username
					, @roleid_tmp = roleid
					, @GroupLevelName = GroupLevelName
					, @custid = custid
			FROM #ArchiveMasterSuper_tmp t 
			WHERE IsFinished = 0	
				
			IF (@@ROWCOUNT = 0) BREAK
				
			EXEC dbo.DBA_ArchiveAccount2_DisableMasterSuper @AccName = @S1M1_username,@srecommend = @srecommend OUTPUT, @ReduceCredit = @ReduceCredit OUTPUT, @ErrMsg = @ErrMsg OUTPUT,@ArchivedDate = @ArchivedDate
				
			PRINT 'DBA_ArchiveAccount2_DisableMasterSuper' + @ErrMsg
				
			IF @ErrMsg = ''
			BEGIN
				IF @ReduceCredit <> 0
				BEGIN
					IF @roleid_tmp = 3
					BEGIN
						UPDATE r
							SET ReduceCredit = r.ReduceCredit + @ReduceCredit - t.ReduceCredit
						FROM #ReduceCredit r
							CROSS APPLY (SELECT	ReduceCredit FROM #ReduceCredit WHERE CustId = @custid) AS t	
						WHERE CustId = @srecommend
					END
				END	
			END	
				
			SET @msg = 'Stage 2 - Done Disable ' + @GroupLevelName + ':'+ @S1M1_username +   CHAR(13) 
			RAISERROR(@msg, 0, 0) WITH NOWAIT	
				
			WAITFOR DELAY '00:00:00.010'
				
		END
	END
	--Reduce SMA Credit, remove M0, M1, S1
	DELETE r
	FROM #ReduceCredit r
		INNER JOIN dbo.tmpCustGroupLevelArchived a WITH (NOLOCK) ON r.CustId = a.custid	
	WHERE a.GroupLevelName IN ('M0','M1','S1')	

	IF EXISTS (SELECT TOP(1) 1 FROM #ReduceCredit WHERE ReduceCredit <> 0)
	BEGIN
			
		WHILE(1=1)
		BEGIN
			UPDATE t
			SET t.IsFinished = 1
				, @custid = t.CustId
				, @ReduceCredit = t.ReduceCredit
				, @GroupLevelName = t.GroupLevelName
				, @roleid_tmp = t.RoleID
			FROM #ReduceCredit t
			WHERE T.CustId IN (SELECT TOP 1 CustId FROM #ReduceCredit  WHERE  IsFinished = 0
								AND ReduceCredit <> 0
								ORDER BY RoleID ASC )

		
			IF @@ROWCOUNT = 0 
				BREAK
				
			SELECT	@username = username,
					@OldCredit = Credit
			FROM	dbo.custInfo WITH (NOLOCK)
			WHERE	custid = @custid
				
			IF @roleid_tmp = 3 
			BEGIN
				SET @RealDownlineCredit = ISNULL((SELECT SUM(credit) FROM	dbo.custInfo WITH (NOLOCK) WHERE mrecommend = @custid AND roleid  = 2),0)
			END
			ELSE
			BEGIN
				SET @RealDownlineCredit = ISNULL((SELECT SUM(credit) FROM	dbo.custInfo WITH (NOLOCK) WHERE srecommend = @custid AND roleid  = 3),0)
			END
			SET @RealDownlineCredit = CASE WHEN 0 < @RealDownlineCredit THEN @RealDownlineCredit ELSE 0 END

			SET @NewCredit = CASE WHEN @OldCredit - @ReduceCredit < @RealDownlineCredit THEN @RealDownlineCredit
									ELSE @OldCredit - @ReduceCredit END

			UPDATE c
				SET c.credit = @NewCredit
			FROM dbo.custInfo c WITH (ROWLOCK, UPDLOCK)
			WHERE c.custid = @custid	

			--Writelog
			SELECT  @LogData = 'Update Credits for SMA Account '+ COALESCE(@username, SPACE(1))  

			BEGIN TRY
				EXEC DBLOG.bodb_CustomerLog.dbo.WriteLog_UserLog_Credit
					@UserID = 360418,
					@CustID = @CustID,
					@Doing = @LogData,
					@OldValue = @OldCredit,
					@NewValue = @NewCredit,
					@IP = '100.100.100.100',
					@ActionID = 1222
			END TRY
			BEGIN CATCH
				SELECT @LogData = @LogData + ' ErrMsg:' + ERROR_MESSAGE()

				EXEC bodb_CustomerLog.dbo.WriteLog_UserLog_Credit
					@UserID = 360418,
					@CustID = @CustID,
					@Doing = @LogData,
					@OldValue = @OldCredit,
					@NewValue = @NewCredit,
					@IP = '100.100.100.100',
					@ActionID = 1222
			END CATCH
		END
	END
END

DROP TABLE #ReduceCredit
DROP TABLE #ArchiveMasterSuper_tmp	
