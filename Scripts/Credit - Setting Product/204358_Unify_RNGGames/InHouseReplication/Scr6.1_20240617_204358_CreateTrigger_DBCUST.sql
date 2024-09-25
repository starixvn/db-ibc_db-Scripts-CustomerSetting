/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240617@Eden
	Task: trigger update for new History tables  [#204358]
		BetSetting3rd_Agent --> BetSetting3rd_Agent_History
		BetSetting3rd_Member --> BetSetting3rd_Member_History
	DB: DBCUST-CustDB
*/

/****** Object:  Trigger [BetSetting3rd_Agent_update] ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'BetSetting3rd_Agent_update' AND type = 'TR')
	DROP TRIGGER [dbo].[BetSetting3rd_Agent_update]
GO



/****** Object:  Trigger [dbo].[BetSetting3rd_Agent_update] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].[BetSetting3rd_Agent_update] ON [dbo].[BetSetting3rd_Agent]
AFTER UPDATE
AS
/*
    Created by: 20240617@Eden
    Task: Trigger for updating [BetSetting3rd_Agent] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240617@Eden: Unify RNG Games [redmine: #204358]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[BetSetting3rd_Agent_History](
         CustID
        ,SportType
        ,BetType
        ,MinBet
        ,MaxBet
        ,MaxPerMatch
        ,MaxPerNumber
    )
    SELECT CustID
        ,SportType
        ,BetType
        ,MinBet
        ,MaxBet
        ,MaxPerMatch
        ,MaxPerNumber
    FROM [DELETED]
END 
GO

ALTER TABLE [dbo].[BetSetting3rd_Agent] ENABLE TRIGGER [BetSetting3rd_Agent_update]
GO

/****** Object:  Trigger [BetSetting3rd_Member_update]  ******/
IF EXISTS(SELECT 1 FROM sys.objects where name = 'BetSetting3rd_Member_update' AND type = 'TR')
	DROP TRIGGER [dbo].[BetSetting3rd_Member_update]
GO

/****** Object:  Trigger [dbo].[BetSetting3rd_Member_update] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------
CREATE TRIGGER [dbo].[BetSetting3rd_Member_update] ON [dbo].[BetSetting3rd_Member]
AFTER UPDATE
AS
/*
    Created by: 20240617@Eden
    Task: Trigger for updating [BetSetting3rd_Member] table 
    DB: DBCUST-CustDB

    Revisions: 
        - 20240617@Eden: Unify RNG Games [redmine: #204358]
    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[BetSetting3rd_Member_History](
         CustID
        ,SportType
        ,BetType
        ,MinBet
        ,MaxBet
        ,MaxPerMatch
        ,MaxPerNumber
    )
    SELECT CustID
        ,SportType
        ,BetType
        ,MinBet
        ,MaxBet
        ,MaxPerMatch
        ,MaxPerNumber
    FROM [DELETED]
END 
GO

ALTER TABLE [dbo].[BetSetting3rd_Member] ENABLE TRIGGER [BetSetting3rd_Member_update]
GO


