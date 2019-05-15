/*
	Created: 20190409@Elodie
	Task: Prepare structure for new credit site
	DB: DBTP/bodb_CustHistory
*/

USE bodb_CustHistory
GO

CREATE TABLE CS_CustPTSetting_Agent_History
(
	UpdateTime	DATETIME NOT NULL CONSTRAINT [DF_CS_CustPTSetting_Agent_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId		INT NOT NULL,
	SuperPT		BINARY(10),
	MasterPT	BINARY(10),
	AgentPT		BINARY(10),
	MinPT		BINARY(10),
	MaxPT		BINARY(10),
	SuperPT2	BINARY(10),
	MasterPT2	BINARY(10),
	AgentPT2	BINARY(10),
	MinPT2		BINARY(10),
	MaxPT2		BINARY(10),
) ON [CS_CustPTSetting_table]
GO

CREATE CLUSTERED INDEX CS_CustPTSetting_Agent_His_Index ON CS_CustPTSetting_Agent_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustPTSetting_table]
GO

CREATE TABLE CS_CustPTGroupSetting_Member_History
(
	UpdateTime	DATETIME NOT NULL CONSTRAINT [DF_CS_CustPTGroupSetting_Member_History_UpdateTime]  DEFAULT (GETDATE()),
	AgentId		INT NOT NULL,
	SuperPT		BINARY(10) NOT NULL,
	MasterPT	BINARY(10) NOT NULL,
	AgentPT		BINARY(10) NOT NULL,
	SuperPT2	BINARY(10) NOT NULL,
	MasterPT2	BINARY(10) NOT NULL,
	AgentPT2	BINARY(10) NOT NULL,
) ON [CS_CustPTSetting_table]
GO

CREATE CLUSTERED INDEX CS_CustPTGroupSetting_Member_His_Index ON CS_CustPTGroupSetting_Member_History
(
	UpdateTime DESC,
	AgentId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustPTSetting_table]
GO

CREATE TABLE CS_CustSettingMode_History  
(
	UpdateTime		DATETIME NOT NULL CONSTRAINT [DF_CS_CustSettingMode_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId			INT NOT NULL,
	IsGroupPT		BIT NOT NULL,
	IsGroupComm		BIT NOT NULL,
) ON [CS_CustSettingMode_table]
GO
CREATE CLUSTERED INDEX CS_CustSettingMode_His_Index ON CS_CustSettingMode_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustSettingMode_table]
GO

CREATE TABLE CS_CustBetSetting_Agent_History  
(
	UpdateTime		DATETIME NOT NULL CONSTRAINT [DF_CS_CustBetSetting_Agent_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId			INT NOT NULL,
	SportType		SMALLINT NOT NULL,
	BetType			SMALLINT NOT NULL,
	IsLive			BIT NOT NULL,
	MaxBet			MONEY,
	MaxPerEvent		MONEY,
) ON [CS_CustBetSetting_table]
GO
CREATE CLUSTERED INDEX CS_CustBetSetting_Agent_His_Index ON CS_CustBetSetting_Agent_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustBetSetting_table]
GO

CREATE TABLE CS_CustBetSetting_Member_History  
(
	UpdateTime		DATETIME NOT NULL CONSTRAINT [DF_CS_CustBetSetting_Member_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId			INT NOT NULL,
	SportType		SMALLINT NOT NULL,
	BetType			SMALLINT NOT NULL,
	IsLive			BIT NOT NULL,
	MaxBet			MONEY,
	MaxPerEvent		MONEY,
) ON [CS_CustBetSetting_table]
GO
CREATE CLUSTERED INDEX CS_CustBetSetting_Member_His_Index ON CS_CustBetSetting_Member_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustBetSetting_table]
GO

CREATE TABLE CS_CustDiscount_Agent_History  
(
	UpdateTime	DATETIME NOT NULL CONSTRAINT [DF_CS_CustDiscount_Agent_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId		INT NOT NULL,
	Discount	BINARY(50) NOT NULL,
) ON [CS_CustDiscount_table]
GO
CREATE CLUSTERED INDEX CS_CustDiscount_Agent_His_Index ON CS_CustDiscount_Agent_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustDiscount_table]
GO

CREATE TABLE CS_CustDiscount_Member_History  
(
	UpdateTime			DATETIME NOT NULL CONSTRAINT [DF_CS_CustDiscount_Member_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId				INT NOT NULL,
	PlayerDiscount		BINARY(30) NOT NULL,
	AgentDiscount		BINARY(30) NOT NULL,
	MasterDiscount		BINARY(30) NOT NULL,
	SuperDiscount		BINARY(30) NOT NULL,
) ON [CS_CustDiscount_table]
GO
CREATE CLUSTERED INDEX CS_CustDiscount_Member_His_Index ON CS_CustDiscount_Member_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustDiscount_table]
GO

CREATE TABLE CS_CustGroupDiscount_Member_History  
(
	UpdateTime		DATETIME NOT NULL CONSTRAINT [DF_CS_CustGroupDiscount_Member_History_UpdateTime]  DEFAULT (GETDATE()),
	AgentId			INT NOT NULL,
	uGroup			VARCHAR(3) NOT NULL,
	PlayerDiscount	BINARY(30) NOT NULL,
	AgentDiscount	BINARY(30) NOT NULL,
	MasterDiscount	BINARY(30) NOT NULL,
	SuperDiscount	BINARY(30) NOT NULL,
) ON [CS_CustDiscount_table]
GO
CREATE CLUSTERED INDEX CS_CustGroupDiscount_Member_His_Index ON CS_CustGroupDiscount_Member_History
(
	UpdateTime DESC,
	AgentId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CS_CustDiscount_table]
GO
