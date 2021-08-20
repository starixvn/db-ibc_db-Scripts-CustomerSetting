/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20210820
	Task: Create new trigger tables [CustBetSetting_Agent], [CustBetSetting_Member] [Redmine: #158073]   
	DB: DBTP/bodb02
*/
USE bodb02
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('CustBetSetting_Agent_Insert_update') IS NOT NULL
	DROP TRIGGER CustBetSetting_Agent_Insert_update
go
CREATE TRIGGER [dbo].[CustBetSetting_Agent_Insert_update] ON [dbo].[CustBetSetting_Agent]
AFTER UPDATE,DELETE
AS
/*
	Created by: 20210820@Eden
	Task: Trigger for Inserting, updating [CustBetSetting_Agent] table 
	DB: DBTP/bodb02

	Revisions: 
		- 20210820@Eden: Max Payout Per Match [redmine: #158073]
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.[CustBetSetting_Agent_History](
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
	)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
	FROM [DELETED]
END 

GO
IF OBJECT_ID('CustBetSetting_Member_Insert_update') IS NOT NULL
	DROP TRIGGER CustBetSetting_Member_Insert_update
go
CREATE TRIGGER [dbo].[CustBetSetting_Member_Insert_update] ON [dbo].[CustBetSetting_Member]
AFTER UPDATE,DELETE
AS
/*
	Created by: 20210820@Eden
	Task: Trigger for Inserting, updating [CustBetSetting_Member] table 
	DB: DBTP/bodb02

	Revisions: 
		- 20210820@Eden: Max Payout Per Match [redmine: #158073]
	
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.[CustBetSetting_Member_History](
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
	)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
	FROM [DELETED]
END 
