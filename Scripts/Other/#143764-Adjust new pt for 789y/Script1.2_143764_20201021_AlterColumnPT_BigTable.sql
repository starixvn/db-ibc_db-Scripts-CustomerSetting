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
	ALTER TABLE CustPTSetting3rd_Agent ADD  SuperPT_tmp			SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  MasterPT_tmp		SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  AgentPT_tmp			SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  AutoSuperPT_tmp		SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT	DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  AutoMasterPT_tmp	SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT	DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  MinPT_tmp			SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent ADD  MaxPT_tmp			SMALLMONEY NOT NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT			DEFAULT (90)
	
	ALTER TABLE CustPTSetting3rd_Member ADD SuperPT_tmp			SMALLMONEY NOT NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD MasterPT_tmp		SMALLMONEY NOT NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD AgentPT_tmp			SMALLMONEY NOT NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD AutoSuperPT_tmp		SMALLMONEY NOT NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member ADD AutoMasterPT_tmp	SMALLMONEY NOT NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	DEFAULT (0) 
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
		@target VARCHAR(20)
	AS
	BEGIN
		SET NOCOUNT ON
	
		IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
		IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

		IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
		IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN

		DECLARE @batch int = 5000
		CREATE TABLE #CustTbl_Agent(CustID INT PRIMARY KEY)
		CREATE TABLE #CustTbl_Member(CustID INT PRIMARY KEY)
		CREATE TABLE #CustTbl_tmp(CustID INT PRIMARY KEY)


		INSERT INTO #CustTbl_Agent(CustID)
		SELECT DISTINCT CustID FROM CustPTSetting3rd_Agent WITH (NOLOCK)

		INSERT INTO #CustTbl_Member(CustID)
		SELECT DISTINCT CustID FROM CustPTSetting3rd_Member WITH (NOLOCK)

		WHILE 1 = 1
		BEGIN
			TRUNCATE TABLE #CustTbl_tmp

			DELETE TOP (5000) t
			OUTPUT deleted.CustID INTO #CustTbl_tmp(CustID)
			FROM #CustTbl_Agent t

			IF @@ROWCOUNT = 0 BREAK;
	
			UPDATE c
			SET	  c.AgentPT = c.AgentPT_BK, 
				  c.MasterPT = c.MasterPT_BK, 
				  c.SuperPT = c.SuperPT_BK, 
				  c.IsAutoMasterPT = c.AutoMasterPT_BK, 
				  c.AutoSuperPT = c.AutoSuperPT_BK, 
				  c.MinPT = c.MinPT_BK, 
				  c.MaxPT = c.MaxPT_BK
			FROM CustPTSetting3rd_Agent c WITH (ROWLOCK, UPDLOCK)
				 INNER JOIN #CustTbl_tmp t
				   ON c.CustID = t.CustID;

			WAITFOR DELAY '00:00:00.010'
		END

		WHILE 1 = 1
		BEGIN
			TRUNCATE TABLE #CustTbl_tmp

			DELETE TOP (5000) t
			OUTPUT deleted.CustID INTO #CustTbl_tmp(CustID)
			FROM #CustTbl_Member t

			IF @@ROWCOUNT = 0 BREAK;
	
			UPDATE c
			SET	  c.AgentPT = c.AgentPT_BK, 
				  c.MasterPT = c.MasterPT_BK, 
				  c.SuperPT = c.SuperPT_BK, 
				  c.IsAutoMasterPT = c.AutoMasterPT_BK, 
				  c.AutoSuperPT = c.AutoSuperPT_BK
			FROM CustPTSetting3rd_Member c WITH (ROWLOCK, UPDLOCK)
				 INNER JOIN #CustTbl_tmp t
				   ON c.CustID = t.CustID;

			WAITFOR DELAY '00:00:00.010'
		END
	END
	GO
---------------------------------------------------------------------------------------------------------------------------
--Step 5.2 : Update data for New column ( run on all replications of custdb_custsetting publications )
	EXEC [Acc_DynamicCustSetting3rd_09] @target = 'REPLICATED'
	GO
---------------------------------------------------------------------------------------------------------------------------
--Step 5.3 : Update data for New column ( run on DBCUST/CUSTDB)
	EXEC [Acc_DynamicCustSetting3rd_09] @target = 'DBCUST'
	GO
---------------------------------------------------------------------------------------------------------------------------
--Step 6 : REMOVE column --DO later
	--ALTER TABLE CustPTSetting3rd_Agent ADD  SuperPT_BK	
	--ALTER TABLE CustPTSetting3rd_Agent ADD  MasterPT_BK
	--ALTER TABLE CustPTSetting3rd_Agent ADD  AgentPT_BK	
	--ALTER TABLE CustPTSetting3rd_Agent ADD  AutoSuperPT_BK
	--ALTER TABLE CustPTSetting3rd_Agent ADD  AutoMasterPT_BK
	--ALTER TABLE CustPTSetting3rd_Agent ADD  MinPT_BK	
	--ALTER TABLE CustPTSetting3rd_Agent ADD  MaxPT_BK	

	--ALTER TABLE CustPTSetting3rd_Member ADD SuperPT_BK	
	--ALTER TABLE CustPTSetting3rd_Member ADD MasterPT_BK
	--ALTER TABLE CustPTSetting3rd_Member ADD AgentPT_BK	
	--ALTER TABLE CustPTSetting3rd_Member ADD AutoSuperPT_BK
	--ALTER TABLE CustPTSetting3rd_Member ADD AutoMasterPT_BK
	--GO