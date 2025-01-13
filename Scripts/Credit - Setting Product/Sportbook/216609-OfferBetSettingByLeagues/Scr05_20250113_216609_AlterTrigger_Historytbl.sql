/*<info serverAlias="DBCUST-CUSTDB"></info>*/

--BetSetting_Agent
ALTER TRIGGER [dbo].[BetSetting_Agent_Insert_update] ON [dbo].[BetSetting_Agent]
AFTER UPDATE,DELETE
AS
/*
    Created by: 20240617@Johnson
    Task: Trigger for Inserting, updating [BetSetting_Agent] table 
    DB: DBCUST/CustDB

    Revisions: 
        - 20240617@Johnson: scale out DBCUST [redmine: #199915]
		- 20250113@Tacy: Add column [LeagueID] [redmine: #216609]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[BetSetting_Agent_History](
         CustID
        ,SportType
        ,BetType
		,LeagueID
        ,MinBet
        ,MaxBet
        ,MaxPerMatch        
        ,MaxPayoutPerMatch
    )
    SELECT CustID
        ,SportType
        ,BetType
		,LeagueID
        ,MinBet
        ,MaxBet
        ,MaxPerMatch      
        ,MaxPayoutPerMatch
    FROM [DELETED]
END 
GO

----------------------------------------------------------------------------------
--BetSetting_Member
ALTER TRIGGER [dbo].[BetSetting_Member_Insert_update] ON [dbo].[BetSetting_Member]
AFTER UPDATE,DELETE
AS
/*
    Created by: 20240617@Johnson
    Task: Trigger for Inserting, updating [BetSetting_Agent] table 
    DB: DBCUST/CustDB

    Revisions: 
        - 20240617@Johnson: scale out DBCUST [redmine: #199915]
		- 20250113@Tacy: Add column [LeagueID] [redmine: #216609]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[BetSetting_Member_History](
         CustID
        ,SportType
        ,BetType
		,LeagueID
        ,MinBet
        ,MaxBet
        ,MaxPerMatch        
        ,MaxPayoutPerMatch
    )
    SELECT CustID
        ,SportType
        ,BetType
		,LeagueID
        ,MinBet
        ,MaxBet
        ,MaxPerMatch      
        ,MaxPayoutPerMatch
    FROM [DELETED]
END 
GO