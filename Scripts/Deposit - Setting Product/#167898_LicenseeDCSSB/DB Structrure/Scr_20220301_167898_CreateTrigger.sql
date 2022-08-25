/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created by: Eden@20220301
	Task: Create trigger for New tables of SB - Deposit DCS & Number Games DCS [Redmine:#167898]		
	DB: DBTP-bodb02
*/
USE bodb02
GO
-------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('Dep_CustBetSettingGame_Agent_Insert_update') IS NOT NULL
	DROP TRIGGER Dep_CustBetSettingGame_Agent_Insert_update
go
CREATE TRIGGER [dbo].[Dep_CustBetSettingGame_Agent_Insert_update] ON [dbo].Dep_CustBetSettingGame_Agent
AFTER UPDATE
AS
/*
	Created by: Eden@20220301
	Task: Trigger for Inserting, updating [Dep_CustBetSettingGame_Agent] table 
	DB: DBTP/bodb02

	Revisions: 
		- 20220301@Eden: Deposit - Sportsbook - Revise customer settings [Redmine: #167898] 
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.[Dep_CustBetSettingGame_Agent_History](
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
	)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,0
	FROM [DELETED]
END 

GO
IF OBJECT_ID('Dep_CustBetSettingGame_Member_Insert_update') IS NOT NULL
	DROP TRIGGER Dep_CustBetSettingGame_Member_Insert_update
go
CREATE TRIGGER [dbo].[Dep_CustBetSettingGame_Member_Insert_update] ON [dbo].[Dep_CustBetSettingGame_Member]
AFTER UPDATE
AS
/*
	Created by: 20210820@Eden
	Task: Trigger for Inserting, updating [Dep_CustBetSettingGame_Member] table 
	DB: DBTP/bodb02

	Revisions: 
		- 20220301@Eden: Deposit - Sportsbook - Revise customer settings [Redmine: #167898] 
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.[Dep_CustBetSettingGame_Member_History](
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
	)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,0
	FROM [DELETED]
END

GO
IF OBJECT_ID('Dep_CustBetSettingGameGroup_Member_Insert_update') IS NOT NULL
	DROP TRIGGER Dep_CustBetSettingGameGroup_Member_Insert_update
go
CREATE TRIGGER [dbo].[Dep_CustBetSettingGameGroup_Member_Insert_update] ON [dbo].[Dep_CustBetSettingGameGroup_Member]
AFTER UPDATE
AS
/*
	Created by: 20210820@Eden
	Task: Trigger for Inserting, updating [Dep_CustBetSettingGameGroup_Member] table 
	DB: DBTP/bodb02

	Revisions: 
		- 20220301@Eden: Deposit - Sportsbook - Revise customer settings [Redmine: #167898] 
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.[Dep_CustBetSettingGameGroup_Member_History](
		 AgentID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
	)
	SELECT AgentID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,0
	FROM [DELETED]
END
