/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240415@Eden
	Task: Alter tables add column RepUpdateTime: [#201733]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	Create new table stored deleted datas:
		WLMonitored_Global_Del
		WLMonitored_Player_Del
		WLMonitored_SMA_Del

	DB: DBCUST-CustDB
*/
USE CustDB
GO

ALTER TABLE WLMonitored_Global ADD RepUpdateTime DATETIME2 NULL CONSTRAINT DF_WLMonitored_Global_RepUpdateTime DEFAULT SYSDATETIME()
ALTER TABLE WLMonitored_Player ADD 
	RepUpdateTime DATETIME2 NULL CONSTRAINT DF_WLMonitored_Player_RepUpdateTime DEFAULT SYSDATETIME(),
	CreatedDate DATETIME NULL CONSTRAINT DF_WLMonitored_Player_CreatedDate DEFAULT GETDATE()

ALTER TABLE WLMonitored_SMA ADD RepUpdateTime DATETIME2 NULL CONSTRAINT DF_WLMonitored_SMA_RepUpdateTime DEFAULT SYSDATETIME()

--Create indexes:
CREATE NONCLUSTERED INDEX IX_WLMonitored_Global_RepUpdateTime ON WLMonitored_Global(RepUpdateTime ASC) 
CREATE NONCLUSTERED INDEX IX_WLMonitored_Player_RepUpdateTime ON WLMonitored_Player(RepUpdateTime ASC) 
CREATE NONCLUSTERED INDEX IX_WLMonitored_SMA_RepUpdateTime ON WLMonitored_SMA(RepUpdateTime ASC) 
GO

--Create new table stored deleted datas:
CREATE TABLE [dbo].WLMonitored_Global_Del(
	[AgentID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7)  NOT NULL,
)  ON [DATA]

CREATE TABLE [dbo].WLMonitored_Player_Del(
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7)  NOT NULL,
)  ON [DATA]

CREATE TABLE [dbo].WLMonitored_SMA_Del(
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7)  NOT NULL,
)  ON [DATA]

--Create indexes:
CREATE CLUSTERED INDEX IX_WLMonitored_Global_Del ON WLMonitored_Global_Del(RepUpdateTime ASC) 
CREATE CLUSTERED INDEX IX_WLMonitored_Player_Del ON WLMonitored_Player_Del(RepUpdateTime ASC) 
CREATE CLUSTERED INDEX IX_WLMonitored_SMA_Del ON WLMonitored_SMA_Del (RepUpdateTime ASC) 
GO


--Init data new columns WLMonitored_Player
WHILE 1 = 1
BEGIN
	UPDATE TOP(1000) t
	SET CreatedDate = InitSettingTime,
		RepUpdateTime = SYSDATETIME()
	FROM WLMonitored_Player t WITH(ROWLOCK,UPDLOCK)
	WHERE RepUpdateTime IS NULL

	IF @@ROWCOUNT = 0
		BREAK
END

--Init data new columns WLMonitored_Global
WHILE 1 = 1
BEGIN
	UPDATE TOP(1000) t
	SET RepUpdateTime = SYSDATETIME()
	FROM WLMonitored_Global t WITH(ROWLOCK,UPDLOCK)
	WHERE RepUpdateTime IS NULL

	IF @@ROWCOUNT = 0
		BREAK
END

--Init data new columns WLMonitored_SMA
WHILE 1 = 1
BEGIN
	UPDATE TOP(1000) t
	SET RepUpdateTime = SYSDATETIME()
	FROM WLMonitored_SMA t WITH(ROWLOCK,UPDLOCK)
	WHERE RepUpdateTime IS NULL

	IF @@ROWCOUNT = 0
		BREAK
END
/*
DROP INDEX WLMonitored_Global.IX_WLMonitored_Global_RepUpdateTime
ALTER TABLE WLMonitored_Global DROP CONSTRAINT DF_WLMonitored_Global_RepUpdateTime
ALTER TABLE WLMonitored_Global DROP COLUMN RepUpdateTime

DROP INDEX WLMonitored_Player.IX_WLMonitored_Player_RepUpdateTime
ALTER TABLE WLMonitored_Player DROP CONSTRAINT DF_WLMonitored_Player_RepUpdateTime
ALTER TABLE WLMonitored_Player DROP COLUMN RepUpdateTime
ALTER TABLE WLMonitored_Player DROP CONSTRAINT DF_WLMonitored_Player_CreatedDate
ALTER TABLE WLMonitored_Player DROP COLUMN CreatedDate

DROP INDEX WLMonitored_SMA.IX_WLMonitored_SMA_RepUpdateTime
ALTER TABLE WLMonitored_SMA DROP CONSTRAINT DF_WLMonitored_SMA_RepUpdateTime
ALTER TABLE WLMonitored_SMA DROP COLUMN RepUpdateTime

DROP TABLE WLMonitored_Global_Del
DROP TABLE WLMonitored_Player_Del
DROP TABLE WLMonitored_SMA_Del
*/