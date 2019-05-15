/*
	Created: 20190409@Elodie
	Task: Add trigger for new credit site
	DB: DBTP/bodb_CustHistory
*/
USE [bodb02]
GO

CREATE TRIGGER [dbo].[CS_CustPTSetting_Agent_update] ON [dbo].[CS_CustPTSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustPTSetting_Agent] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustPTSetting_Agent_History] (
		[CustId]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
        ,[MinPT]
        ,[MaxPT]
        ,[SuperPT2]
        ,[MasterPT2]
        ,[AgentPT2]
        ,[MinPT2]
        ,[MaxPT2]
	)
	SELECT
		[CustId]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
        ,[MinPT]
        ,[MaxPT]
        ,[SuperPT2]
        ,[MasterPT2]
        ,[AgentPT2]
        ,[MinPT2]
        ,[MaxPT2]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustPTGroupSetting_Member_update] ON [dbo].[CS_CustPTGroupSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustPTGroupSetting_Member] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustPTGroupSetting_Member_History] (
		[AgentId]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
        ,[SuperPT2]
        ,[MasterPT2]
        ,[AgentPT2]
	)
	SELECT
		[AgentId]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
        ,[SuperPT2]
        ,[MasterPT2]
        ,[AgentPT2]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustSettingMode_update] ON [dbo].[CS_CustSettingMode] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustSettingMode] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustSettingMode_History] (
		[CustId]
        ,[IsGroupPT]
        ,[IsGroupComm]
	)
	SELECT
		[CustId]
        ,[IsGroupPT]
        ,[IsGroupComm]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustBetSetting_Agent_update] ON [dbo].[CS_CustBetSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustBetSetting_Agent] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustBetSetting_Agent_History] (
		[CustId]
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[MaxBet]
        ,[MaxPerEvent]
	)
	SELECT
		[CustId]
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[MaxBet]
        ,[MaxPerEvent]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustBetSetting_Member_update] ON [dbo].[CS_CustBetSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustBetSetting_Member] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustBetSetting_Member_History] (
		[CustId]
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[MaxBet]
        ,[MaxPerEvent]
	)
	SELECT
		[CustId]
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[MaxBet]
        ,[MaxPerEvent]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustDiscount_Agent_update] ON [dbo].[CS_CustDiscount_Agent] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustDiscount_Agent] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustDiscount_Agent_History] (
		[CustId]
        ,[Discount]
	)
	SELECT
		[CustId]
        ,[Discount]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustDiscount_Member_update] ON [dbo].[CS_CustDiscount_Member] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustDiscount_Member] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustDiscount_Member_History] (
		[CustId]
        ,[PlayerDiscount]
        ,[AgentDiscount]
        ,[MasterDiscount]
        ,[SuperDiscount]
	)
	SELECT
		[CustId]
        ,[PlayerDiscount]
        ,[AgentDiscount]
        ,[MasterDiscount]
        ,[SuperDiscount]
	FROM [DELETED]
END
GO

CREATE TRIGGER [dbo].[CS_CustGroupDiscount_Member_update] ON [dbo].[CS_CustGroupDiscount_Member] AFTER UPDATE
AS
/*
	Created by: 20190409@Elodie
	Task: Trigger for updating [CS_CustGroupDiscount_Member] table 
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[CS_CustGroupDiscount_Member_History] (
		[AgentId]
        ,[uGroup]
        ,[PlayerDiscount]
        ,[AgentDiscount]
        ,[MasterDiscount]
        ,[SuperDiscount]
	)
	SELECT
		[AgentId]
        ,[uGroup]
        ,[PlayerDiscount]
        ,[AgentDiscount]
        ,[MasterDiscount]
        ,[SuperDiscount]
	FROM [DELETED]
END
GO