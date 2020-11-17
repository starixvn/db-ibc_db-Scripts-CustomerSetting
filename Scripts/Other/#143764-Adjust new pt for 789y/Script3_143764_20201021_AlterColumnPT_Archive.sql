/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
    Created: Eden@20201021
    Task: Change datatype PT tables [#143764]
			CustPTSetting3rd_Agent_old
			CustPTSetting3rd_Member_old
			CustPTGroupSetting3rd_Member_old 
    DB: DBARCCUST/bodb_Customer
*/ 
USE bodb_Customer
GO	
--> For Small Table :----------------------------------------------------------------
	--Remove Default
	
	ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]		
	ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]	
	ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]		
	ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]	
	ALTER TABLE CustPTGroupSetting3rd_Member_old DROP CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]
	GO
	--ALTER COLUMN
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN SuperPT			SMALLMONEY NOT NULL			
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN MasterPT		SMALLMONEY NOT NULL		
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN AgentPT			SMALLMONEY NOT NULL			
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN AutoSuperPT		SMALLMONEY NOT NULL		
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN AutoMasterPT	SMALLMONEY NOT NULL	
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN MinPT			SMALLMONEY NOT NULL			
	ALTER TABLE CustPTSetting3rd_Agent_old ALTER COLUMN MaxPT			SMALLMONEY NOT NULL

	ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN SuperPT		SMALLMONEY NOT NULL			
	ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN MasterPT		SMALLMONEY NOT NULL		
	ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN AgentPT		SMALLMONEY NOT NULL			
	ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN AutoSuperPT	SMALLMONEY NOT NULL		
	ALTER TABLE CustPTGroupSetting3rd_Member_old ALTER COLUMN AutoMasterPT	SMALLMONEY NOT NULL				
	GO
	--Add Default
	ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]			DEFAULT (0) FOR SuperPT
	ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]			DEFAULT (0) FOR MasterPT
	ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]			DEFAULT (0) FOR AgentPT
	ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]		DEFAULT (0) FOR AutoMasterPT
	ALTER TABLE CustPTGroupSetting3rd_Member_old ADD CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]		DEFAULT (0) FOR AutoSuperPT
	GO

--> For Big tables :----------------------------------------------------------------
	--Rename Constraint
	exec sp_rename 'DF_CustPTSetting3rd_Member_SuperPT','DF_CustPTSetting3rd_Member_SuperPT_BK'
	exec sp_rename 'DF_CustPTSetting3rd_Member_MasterPT','DF_CustPTSetting3rd_Member_MasterPT_BK'
	exec sp_rename 'DF_CustPTSetting3rd_Member_AgentPT','DF_CustPTSetting3rd_Member_AgentPT_BK'
	exec sp_rename 'DF_CustPTSetting3rd_Member_AutoMasterPT','DF_CustPTSetting3rd_Member_AutoMasterPT_BK'
	exec sp_rename 'DF_CustPTSetting3rd_Member_AutoSuperPT','DF_CustPTSetting3rd_Member_AutoSuperPT_BK'
	GO

	--ALTER COLUMN
	ALTER TABLE CustPTSetting3rd_Member_old ADD SuperPT_tmp			SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_old ADD MasterPT_tmp		SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_old ADD AgentPT_tmp			SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]			DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_old ADD AutoSuperPT_tmp		SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]		DEFAULT (0) 
	ALTER TABLE CustPTSetting3rd_Member_old ADD AutoMasterPT_tmp	SMALLMONEY  NULL		CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]	DEFAULT (0) 
	GO

	--Rename current columns
	exec sp_rename 'CustPTSetting3rd_Member_old.SuperPT','SuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.MasterPT','MasterPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.AgentPT','AgentPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.AutoSuperPT','AutoSuperPT_BK','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.AutoMasterPT','AutoMasterPT_BK','COLUMN'
	GO

	--Rename new columns
	exec sp_rename 'CustPTSetting3rd_Member_old.SuperPT_tmp','SuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.MasterPT_tmp','MasterPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.AgentPT_tmp','AgentPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.AutoSuperPT_tmp','AutoSuperPT','COLUMN'
	exec sp_rename 'CustPTSetting3rd_Member_old.AutoMasterPT_tmp','AutoMasterPT','COLUMN'
	GO

	--move data from old columns to new columns
	WHILE 1 = 1
	BEGIN
		UPDATE TOP (5000) c
		SET	  c.AgentPT = c.AgentPT_BK, 
			c.MasterPT = c.MasterPT_BK, 
			c.SuperPT = c.SuperPT_BK, 
			c.AutoMasterPT = c.AutoMasterPT_BK, 
			c.AutoSuperPT = c.AutoSuperPT_BK
		FROM CustPTSetting3rd_Member_old c WITH (ROWLOCK)
		WHERE AgentPT is null

		IF @@ROWCOUNT = 0 BREAK;

		--WAITFOR DELAY '00:00:00.010'
	END

	--REMOVE redudant columns
	ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT DF_CustPTSetting3rd_Member_SuperPT_BK
	ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT DF_CustPTSetting3rd_Member_MasterPT_BK
	ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT DF_CustPTSetting3rd_Member_AgentPT_BK
	ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT DF_CustPTSetting3rd_Member_AutoMasterPT_BK
	ALTER TABLE CustPTSetting3rd_Member_old DROP CONSTRAINT DF_CustPTSetting3rd_Member_AutoSuperPT_BK
	GO
		
	ALTER TABLE CustPTSetting3rd_Member_old
	DROP COLUMN SuperPT_BK, MasterPT_BK, AgentPT_BK, AutoSuperPT_BK, AutoMasterPT_BK
	GO