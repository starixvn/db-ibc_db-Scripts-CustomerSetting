/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			CustPTSetting3rd_Agent_history
			CustPTSetting3rd_Member_history
    DB: DBTP/bodb_CustHistory
*/ 
USE bodb_CustHistory
GO
--Step 1 : Create new columns
	--DROP CONSTRAINT
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT		
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT	
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT		
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT	
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT		
	ALTER TABLE CustPTSetting3rd_Agent_history DROP CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT		

	ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]		
	ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]	
	ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]		
	ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	
	ALTER TABLE CustPTSetting3rd_Member_history DROP CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]
	GO
	--ALTER COLUMN
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  SuperPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_SuperPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  MasterPT_tmp		SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MasterPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  AgentPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AgentPT		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  AutoSuperPT_tmp		SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AutoSuperPT	DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  AutoMasterPT_tmp	SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_AutoMasterPT	DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  MinPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MinPT			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Agent_history ADD  MaxPT_tmp			SMALLMONEY  NULL		CONSTRAINT DF_CustPTSetting3rd_Agent_MaxPT			DEFAULT (90)
	
	ALTER TABLE CustPTSetting3rd_Member_history ADD SuperPT_tmp			SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_history ADD MasterPT_tmp		SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_history ADD AgentPT_tmp			SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_history ADD AutoSuperPT_tmp		SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_history ADD AutoMasterPT_tmp	SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	DEFAULT (0) 
	GO	
			
--Step 2: rename current columns ( run on all DB of custdb_custsetting publications )
	--Rename current columns
	exec sp_rename 'CustPTSetting3rd_Agent_history.SuperPT','SuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.MasterPT','MasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.AgentPT','AgentPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.AutoSuperPT','AutoSuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.AutoMasterPT','AutoMasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.MinPT','MinPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.MaxPT','MaxPT_BK','COLUMN'

	exec sp_rename 'CustPTSetting3rd_Member_history.SuperPT','SuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.MasterPT','MasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.AgentPT','AgentPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.AutoSuperPT','AutoSuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.AutoMasterPT','AutoMasterPT_BK','COLUMN'
	GO
	--Rename new columns
	exec sp_rename 'CustPTSetting3rd_Agent_history.SuperPT_tmp','SuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.MasterPT_tmp','MasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.AgentPT_tmp','AgentPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.AutoSuperPT_tmp','AutoSuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.AutoMasterPT_tmp','AutoMasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.MinPT_tmp','MinPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Agent_history.MaxPT_tmp','MaxPT','COLUMN'

	exec sp_rename 'CustPTSetting3rd_Member_history.SuperPT_tmp','SuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.MasterPT_tmp','MasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.AgentPT_tmp','AgentPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.AutoSuperPT_tmp','AutoSuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_history.AutoMasterPT_tmp','AutoMasterPT','COLUMN'
	GO

--Step 3 :  move data from old columns to new columns
	DECLARE @batch int = 5000
	CREATE TABLE #CustTbl_Agent(CustID INT PRIMARY KEY)
	CREATE TABLE #CustTbl_Member(CustID INT PRIMARY KEY)
	CREATE TABLE #CustTbl_tmp(CustID INT PRIMARY KEY)


	INSERT INTO #CustTbl_Agent(CustID)
	SELECT DISTINCT CustID FROM CustPTSetting3rd_Agent_history WITH (NOLOCK)

	INSERT INTO #CustTbl_Member(CustID)
	SELECT DISTINCT CustID FROM CustPTSetting3rd_Member_history WITH (NOLOCK)

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
		FROM CustPTSetting3rd_Agent_history c WITH (ROWLOCK, UPDLOCK)
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
		FROM CustPTSetting3rd_Member_history c WITH (ROWLOCK, UPDLOCK)
				INNER JOIN #CustTbl_tmp t
				ON c.CustID = t.CustID;

		--WAITFOR DELAY '00:00:00.010'
	END

	DROP TABLE #CustTbl_Agent
	DROP TABLE #CustTbl_Member
	DROP TABLE #CustTbl_tmp

	GO