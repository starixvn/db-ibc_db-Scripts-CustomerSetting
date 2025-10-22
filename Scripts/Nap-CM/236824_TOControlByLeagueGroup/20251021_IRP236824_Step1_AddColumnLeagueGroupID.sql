/*<info serverAlias="DBCUST-CustDB,DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBAGE-bodb02"></info>*/
/*
	Created: 20251021@Johnson
	Task: Enhancement - TO Monitor Control By League [Redmine:#236824]	
	DB: DBCUST/CustDB
*/
--step 1: add new column LeagueGroupID into TOControl_GlobalSetting table
ALTER TABLE TOControl_GlobalSetting ADD LeagueGroupID int
GO

ALTER TABLE TOControl_GlobalSetting ADD IsLeagueGroupLock int
GO

ALTER TABLE [dbo].[TOControl_GlobalSetting] ADD  CONSTRAINT [DF_TOControl_GlobalSetting_LeagueGroupID]  DEFAULT (-1) FOR [LeagueGroupID]
GO

ALTER TABLE [dbo].[TOControl_GlobalSetting] ADD  CONSTRAINT [DF_TOControl_GlobalSetting_IsLeagueGroupLock]  DEFAULT (0) FOR [IsLeagueGroupLock]
GO

--update Default value for new column
WHILE(1=1)
BEGIN
	UPDATE TOP (5000) TOControl_GlobalSetting WITH(ROWLOCK)
	SET LeagueGroupID = -1,
		IsLeagueGroupLock = 0
	WHERE LeagueGroupID IS NULL

	IF @@ROWCOUNT = 0 BREAK

	WAITFOR DELAY '00:00:0.28'
END
GO

ALTER TABLE TOControl_GlobalSetting ALTER COLUMN LeagueGroupID INT NOT NULL
GO
