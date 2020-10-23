/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			CustPTSetting3rd_Agent
			CustPTSetting3rd_Member
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
---------------------------------------------------------------------------------------------------------------------------
--Step 1 : Create new columns with new datatype (Rub on DBCUST/CUSTDB)
	--DROP DEFAULT CONSTRAINT for current columns
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT		
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT	
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT		
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT	
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT		
	ALTER TABLE CustPTSetting3rd_Agent DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT	

	ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]		
	ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]	
	ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]		
	ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	
	ALTER TABLE CustPTSetting3rd_Member DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]
	GO	
	--ALTER COLUMN
	ALTER TABLE CustPTSetting3rd_Agent ADD  SuperPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  MasterPT_tmp		SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  AgentPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  AutoSuperPT_tmp		SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT	DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  AutoMasterPT_tmp	SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT	DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  MinPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  MaxPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT			DEFAULT (90)
	
	ALTER TABLE CustPTSetting3rd_Member ADD SuperPT_tmp			SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD MasterPT_tmp		SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD AgentPT_tmp			SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD AutoSuperPT_tmp		SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD AutoMasterPT_tmp	SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	DEFAULT (0) 
	GO
GO
---------------------------------------------------------------------------------------------------------------------------
--Step 2 : Turn OFF replication for those tables
---------------------------------------------------------------------------------------------------------------------------
--Step 3: rename current columns ( run on all DB of custdb_custsetting publications )
	--Rename current columns
	exec sp_rename 'CustPTSetting3rd_Agent.SuperPT','SuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.MasterPT','MasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.AgentPT','AgentPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.AutoSuperPT','AutoSuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.AutoMasterPT','AutoMasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.MinPT','MinPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.MaxPT','MaxPT_BK','COLUMN'

	exec sp_rename 'CustPTSetting3rd_Member.SuperPT','SuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.MasterPT','MasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.AgentPT','AgentPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.AutoSuperPT','AutoSuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.AutoMasterPT','AutoMasterPT_BK','COLUMN'
	GO
	--Rename new columns
	exec sp_rename 'CustPTSetting3rd_Agent.SuperPT_tmp','SuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.MasterPT_tmp','MasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.AgentPT_tmp','AgentPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.AutoSuperPT_tmp','AutoSuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.AutoMasterPT_tmp','AutoMasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.MinPT_tmp','MinPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent.MaxPT_tmp','MaxPT','COLUMN'

	exec sp_rename 'CustPTSetting3rd_Member.SuperPT_tmp','SuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.MasterPT_tmp','MasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.AgentPT_tmp','AgentPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.AutoSuperPT_tmp','AutoSuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member.AutoMasterPT_tmp','AutoMasterPT','COLUMN'
	GO
---------------------------------------------------------------------------------------------------------------------------
--Step 4 : Turn ON replication for those tables
---------------------------------------------------------------------------------------------------------------------------
--Step 5.1 ; SP move data from old columns to new columns (run ON DBCUST/CUSTDB)
	ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
		@srecommend INT	,
		@target VARCHAR(20)
	AS
	BEGIN
		SET NOCOUNT ON
	
		IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
		IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

		IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
		IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN

		DECLARE @batch int = 5000
		CREATE TABLE #CustTbl_Agent(CustID INT PRIMARY KEY)
		CREATE TABLE #CustTbl_Member(CustID INT PRIMARY KEY)
		CREATE TABLE #CustTbl_tmp(CustID INT PRIMARY KEY)

		INSERT INTO #CustTbl_Member (CustID)
		SELECT custid
		FROM Custinfo WITH (NOLOCK)
		WHERE srecommend = @srecommend AND roleid = 1
	
		INSERT INTO #CustTbl_Agent (CustID)
		SELECT custid
		FROM Custinfo WITH (NOLOCK)
		WHERE srecommend = @srecommend AND roleid IN (2,3,4)

		WHILE 1 = 1
		BEGIN
			TRUNCATE TABLE #CustTbl_tmp

			DELETE TOP (@batch) t
			OUTPUT deleted.CustID INTO #CustTbl_tmp(CustID)
			FROM #CustTbl_Agent t

			IF @@ROWCOUNT = 0 BREAK;
	
			UPDATE c
			SET	  c.AgentPT = c.AgentPT_BK, 
				  c.MasterPT = c.MasterPT_BK, 
				  c.SuperPT = c.SuperPT_BK, 
				  c.AutoMasterPT = c.AutoMasterPT_BK, 
				  c.AutoSuperPT = c.AutoSuperPT_BK, 
				  c.MinPT = c.MinPT_BK, 
				  c.MaxPT = c.MaxPT_BK
			FROM CustPTSetting3rd_Agent c WITH (ROWLOCK, UPDLOCK)
				 INNER JOIN #CustTbl_tmp t
				   ON c.CustID = t.CustID;

			--WAITFOR DELAY '00:00:00.010'
		END

		WHILE 1 = 1
		BEGIN
			TRUNCATE TABLE #CustTbl_tmp

			DELETE TOP (@batch) t
			OUTPUT deleted.CustID INTO #CustTbl_tmp(CustID)
			FROM #CustTbl_Member t

			IF @@ROWCOUNT = 0 BREAK;
	
			UPDATE c
			SET	  c.AgentPT = c.AgentPT_BK, 
				  c.MasterPT = c.MasterPT_BK, 
				  c.SuperPT = c.SuperPT_BK, 
				  c.AutoMasterPT = c.AutoMasterPT_BK, 
				  c.AutoSuperPT = c.AutoSuperPT_BK
			FROM CustPTSetting3rd_Member c WITH (ROWLOCK, UPDLOCK)
				 INNER JOIN #CustTbl_tmp t
				   ON c.CustID = t.CustID;

			--WAITFOR DELAY '00:00:00.010'
		END
		DROP TABLE #CustTbl_Agent
		DROP TABLE #CustTbl_Member
		DROP TABLE #CustTbl_tmp
	END
	GO
---------------------------------------------------------------------------------------------------------------------------
--Step 5.2 : Update data for New column ( run on all replications of custdb_custsetting publications )
	--Disable trigger DBTP
	DISABLE TRIGGER [dbo].[CustPTSetting3rd_Agent_update] ON [dbo].[CustPTSetting3rd_Agent] 
	GO  
	DISABLE TRIGGER [dbo].[CustPTSetting3rd_Member_update] ON [dbo].[CustPTSetting3rd_Member]
	GO 

	--Update data for New column
	CREATE TABLE #supers (custid int,isfinished bit default(0))
	DECLARE @srecommend INT

	INSERT INTO #supers(custid)
	SELECT ci.srecommend
	FROM CustPTSetting3rd_Agent C WITH(NOLOCK)
		INNER JOIN  Custinfo ci WITH (NOLOCK) ON ci.custid = c.custid
	UNION
	SELECT ci.srecommend
	FROM CustPTSetting3rd_Member C WITH(NOLOCK)
		INNER JOIN  Custinfo ci WITH (NOLOCK) ON ci.custid = c.custid

	-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid	
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK
	
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
				,@target = 'REPLICATED'
			
			
		--WAITFOR DELAY '00:00:00.010'
	END

	DROP TABLE #supers
	GO

	--Enable trigger DBTP
	ENABLE TRIGGER [dbo].[CustPTSetting3rd_Agent_update] ON [dbo].[CustPTSetting3rd_Agent] 
	GO  
	ENABLE TRIGGER [dbo].[CustPTSetting3rd_Member_update] ON [dbo].[CustPTSetting3rd_Member]
	GO  
---------------------------------------------------------------------------------------------------------------------------
--Step 5.3 : Update data for New column ( run on DBCUST/CUSTDB)
	USE CUSTDB
	GO
	CREATE TABLE #supers (custid int,isfinished bit default(0))
	DECLARE @srecommend INT

	INSERT INTO #supers(custid)
	SELECT ci.srecommend
	FROM CustPTSetting3rd_Agent C WITH(NOLOCK)
		INNER JOIN  Custinfo ci WITH (NOLOCK) ON ci.custid = c.custid
	UNION
	SELECT ci.srecommend
	FROM CustPTSetting3rd_Member C WITH(NOLOCK)
		INNER JOIN  Custinfo ci WITH (NOLOCK) ON ci.custid = c.custid

	-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid	
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK
	
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
				,@target = 'DBCUST'
			
			
		--WAITFOR DELAY '00:00:00.010'
	END

	DROP TABLE #supers
	GO
---------------------------------------------------------------------------------------------------------------------------
--Step 6 : REMOVE column --DO later
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  SuperPT_BK	
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  MasterPT_BK
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  AgentPT_BK	
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  AutoSuperPT_BK
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  AutoMasterPT_BK
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  MinPT_BK	
	--ALTER TABLE CustPTSetting3rd_Agent DROP COLUMN  MaxPT_BK	

	--ALTER TABLE CustPTSetting3rd_Member DROP COLUMN SuperPT_BK	
	--ALTER TABLE CustPTSetting3rd_Member DROP COLUMN MasterPT_BK
	--ALTER TABLE CustPTSetting3rd_Member DROP COLUMN AgentPT_BK	
	--ALTER TABLE CustPTSetting3rd_Member DROP COLUMN AutoSuperPT_BK
	--ALTER TABLE CustPTSetting3rd_Member DROP COLUMN AutoMasterPT_BK
	--GO