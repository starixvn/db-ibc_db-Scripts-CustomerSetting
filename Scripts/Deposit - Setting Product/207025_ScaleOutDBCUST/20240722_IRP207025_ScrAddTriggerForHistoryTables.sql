/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20240722@Johnson
	Task: Add triggers for deposit history tables [redmine: #207025]
	DB: DBCUST-CUSTDB
*/ 
----------------------------------------------------------------
--Dep_CustBetSetting_Member
CREATE TRIGGER [dbo].[Dep_CustBetSetting_Member_update] ON [dbo].[Dep_CustBetSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustBetSetting_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustBetSetting_Member_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[MinBet],
		[MaxBet],
		[MaxPerMatch]
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[MinBet],
		[MaxBet],
		[MaxPerMatch]
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustBetSetting_Agent
CREATE TRIGGER [dbo].[Dep_CustBetSetting_Agent_update] ON [dbo].[Dep_CustBetSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustBetSetting_Agent] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]
*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustBetSetting_Agent_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[MinBet] ,
		[MaxBet] ,
		[MaxPerMatch]
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[MinBet] ,
		[MaxBet] ,
		[MaxPerMatch]
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustBetSettingGame_Agent
CREATE TRIGGER [dbo].[Dep_CustBetSettingGame_Agent_update] ON [dbo].[Dep_CustBetSettingGame_Agent]
AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustBetSettingGame_Agent] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]
    
*/
BEGIN   
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[Dep_CustBetSettingGame_Agent_History](
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
--Dep_CustBetSettingGame_Member
CREATE TRIGGER [dbo].[Dep_CustBetSettingGame_Member_update] ON [dbo].[Dep_CustBetSettingGame_Member]
AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustBetSettingGame_Member] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]
  
*/
BEGIN  
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[Dep_CustBetSettingGame_Member_History](
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
--Dep_CustBetSettingGameGroup_Member
CREATE TRIGGER [dbo].[Dep_CustBetSettingGameGroup_Member_update] ON [dbo].[Dep_CustBetSettingGameGroup_Member]
AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustBetSettingGameGroup_Member] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]
    
*/
BEGIN   
    SET NOCOUNT ON;

    INSERT INTO CustDB_History.dbo.[Dep_CustBetSettingGameGroup_Member_History](
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
--Dep_CustDiscountGroupSetting_Member
CREATE TRIGGER [dbo].[Dep_CustDiscountGroupSetting_Member_update] ON [dbo].[Dep_CustDiscountGroupSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustBetSettingGameGroup_Member] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustDiscountGroupSetting_Member_History] 
	(
	   [AgentID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount]		
	)
	SELECT
		[AgentID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount] 
	FROM [DELETED]
END

GO
----------------------------------------------------------------
--Dep_CustDiscountSetting_Agent
CREATE TRIGGER [dbo].[Dep_CustDiscountSetting_Agent_update] ON [dbo].[Dep_CustDiscountSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustDiscountSetting_Agent] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustDiscountSetting_Agent_History] (
		[CustID],
		[SportType],
		[BetType],
		Discount 
		
	)
	SELECT
		[CustID],
		[SportType],
		[BetType],
		Discount 
	FROM [DELETED]
END
GO
----------------------------------------------------------------
--Dep_CustDiscountSetting_Member
CREATE TRIGGER [dbo].[Dep_CustDiscountSetting_Member_update] ON [dbo].[Dep_CustDiscountSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustDiscountSetting_Member] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustDiscountSetting_Member_History] 
	(
	   [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount]		
	)
	SELECT
		[CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount] 
	FROM [DELETED]
END

GO
----------------------------------------------------------------
--Dep_CustProductStatus
CREATE TRIGGER [dbo].[Dep_CustProductStatus_update] ON [dbo].[Dep_CustProductStatus] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustProductStatus] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustProductStatus_History] (
		[CustID] ,		
		[bitmapIsHidden] ,
		[bitmapIsDisabled] 
	)
	SELECT
		[CustID] ,		
		[bitmapIsHidden] ,
		[bitmapIsDisabled] 
	FROM [DELETED]
END

GO
----------------------------------------------------------------
--Dep_CustPTGroupSetting_Member
CREATE TRIGGER [dbo].[Dep_CustPTGroupSetting_Member_update] ON [dbo].[Dep_CustPTGroupSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustPTGroupSetting_Member] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustPTGroupSetting_Member_History] (
		[AgentID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] 	
	)
	SELECT
		[AgentID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] 	
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustPTSetting_Agent
CREATE TRIGGER [dbo].[Dep_CustPTSetting_Agent_update] ON [dbo].[Dep_CustPTSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustPTSetting_Agent] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]
*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustPTSetting_Agent_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] 		
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] 		
	
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustPTSetting_Member
CREATE TRIGGER [dbo].[Dep_CustPTSetting_Member_update] ON [dbo].[Dep_CustPTSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustPTSetting_Member] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustPTSetting_Member_History] (
		[CustID],
		[SportType],
		[BetType],
		[IsLive] ,
		[SuperPT],
		[MasterPT],
		[AgentPT]	
	)
	SELECT
		[CustID],
		[SportType],
		[BetType],
		[IsLive] ,
		[SuperPT],
		[MasterPT],
		[AgentPT]
	
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustSettingGame
CREATE TRIGGER [dbo].[Dep_CustSettingGame_update] ON [dbo].[Dep_CustSettingGame]
AFTER UPDATE
AS   
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustSettingGame] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.Dep_CustSettingGame_History (
			CustID, Bettype, Sporttype, apositiontaking, mpositiontaking, spositiontaking, playerdiscount, discount, adiscount, sdiscount)
	SELECT CustID, Bettype, Sporttype, apositiontaking, mpositiontaking, spositiontaking, playerdiscount, discount, adiscount, sdiscount
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustSettingMode
CREATE TRIGGER [dbo].[Dep_CustSettingMode_update] ON [dbo].[Dep_CustSettingMode] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustSettingMode] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]


*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[Dep_CustSettingMode_History] (
		[CustID] ,
		IsGroupedPT, 
		IsGroupedComm,
		IsGroupedBetLimit,
		IsGroupedStakeLevel
	)
	SELECT
		[CustID] ,
		IsGroupedPT, 
		IsGroupedComm,
		IsGroupedBetLimit,
		IsGroupedStakeLevel
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustStakeLevel_Agent
CREATE TRIGGER [dbo].[Dep_CustStakeLevel_Agent_update] ON [dbo].[Dep_CustStakeLevel_Agent] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustStakeLevel_Agent] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.Dep_CustStakeLevel_Agent_History (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		StakeLevelList
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		StakeLevelList
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--Dep_CustStakeLevel_Member
CREATE TRIGGER [dbo].[Dep_CustStakeLevel_Member_update] ON [dbo].[Dep_CustStakeLevel_Member] AFTER UPDATE
AS
/*
	Created by: 20240722@Johnson
	Task: Trigger for updating [Dep_CustStakeLevel_Agent] table
	DB: DBCUST/CUSTDB

	Revisions: 
       - 20240722@Johnson: Apply In-house Replication for Deposit Customer Setting [redmine:#207025]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.Dep_CustStakeLevel_Member_History (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		StakeLevelList,
		LastUpdated
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		StakeLevelList,
		LastUpdated
	FROM [DELETED]
END

GO



