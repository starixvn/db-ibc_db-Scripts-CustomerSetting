/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20230714
	Task: ALTER TRIGGER Back to Origin[Redmine: #191243]   
	DB: DBTP-bodb02
*/
-----------------Disable Trigger--------------------
USE bodb02
GO 
ALTER TRIGGER [dbo].[Dep_CustBetSettingGame_Agent_update] ON [dbo].Dep_CustBetSettingGame_Agent
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
----------------------------------------------------------------
GO
ALTER TRIGGER [dbo].[Dep_CustBetSettingGame_Member_update] ON [dbo].[Dep_CustBetSettingGame_Member]
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
----------------------------------------------------------------
ALTER TRIGGER [dbo].[Dep_CustBetSettingGameGroup_Member_update] ON [dbo].[Dep_CustBetSettingGameGroup_Member]
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
GO
----------------------------------------------------------------
ALTER TRIGGER [dbo].[CustBetSetting_Member_Insert_update] ON [dbo].[CustBetSetting_Member]
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
GO
----------------------------------------------------------------
ALTER TRIGGER [dbo].[CustBetSetting_Agent_Insert_update] ON [dbo].[CustBetSetting_Agent]
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