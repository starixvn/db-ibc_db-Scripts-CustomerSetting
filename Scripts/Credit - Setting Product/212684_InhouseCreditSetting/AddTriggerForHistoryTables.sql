/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 2024114@Johnson
	Task: Add triggers for credit history tables [redmine: #212684]
	DB: DBCUST-CUSTDB
*/ 
----------------------------------------------------------------
--CustDiscount3rd_Agent
CREATE TRIGGER [dbo].[CustDiscount3rd_Agent_update] ON [dbo].[CustDiscount3rd_Agent] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustDiscount3rd_Agent] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[CustDiscount3rd_Agent_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[Discount] 
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[Discount] 
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--CustDiscount3rd_Member
CREATE TRIGGER [dbo].[CustDiscount3rd_Member_update] ON [dbo].[CustDiscount3rd_Member] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustDiscount3rd_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[CustDiscount3rd_Member_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[PlayerDiscount] ,
		[AgentDiscount] ,
		[MasterDiscount] ,
		[SuperDiscount] 
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[PlayerDiscount] ,
		[AgentDiscount] ,
		[MasterDiscount] ,
		[SuperDiscount] 
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--custInfo
CREATE TRIGGER [dbo].[CustInfo_update] ON [dbo].[custInfo]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [custInfo] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.CustInfo_history (
        username
        ,custid
        ,currency
        ,roleid
        ,srecommend
        ,mrecommend
        ,recommend
        ,dangercust
        ,autosuspend
        ,reject
        ,credit
        ,closed
        ,MatchLimit
        ,VirtualMultiplier
        ,[Enabled]
        ,danger     
        ,danger2
        ,danger3
        ,DisableOutright            
        ,Abnormal
        ,DoubleCommLosing       
        ,autosuspend2       
        ,DisableEsports
        ,DisableSuperLive
        ,LockUpd
        ,BonusWalletFlag
        ,DangerLevel
        ,CustomerClass
        ,danger4
        ,danger5
        ,CCSoccer
        ,CCBasketball
        ,CCEsports
        ,CCOtherSports
        ,CCNonSports
        ,autosuspend3
        )
    SELECT username
        ,custid
        ,currency
        ,roleid
        ,srecommend
        ,mrecommend
        ,recommend
        ,dangercust
        ,autosuspend
        ,reject
        ,credit
        ,closed
        ,MatchLimit
        ,VirtualMultiplier
        ,[Enabled]
        ,danger 
        ,danger2
        ,danger3
        ,DisableOutright
        ,Abnormal
        ,DoubleCommLosing
        ,autosuspend2
        ,DisableEsports
        ,DisableSuperLive
        ,LockUpd
        ,BonusWalletFlag
        ,DangerLevel
        ,CustomerClass
        ,danger4
        ,danger5
        ,CCSoccer
        ,CCBasketball
        ,CCEsports
        ,CCOtherSports
        ,CCNonSports
        ,autosuspend3
    FROM [DELETED]
END	
GO
----------------------------------------------------------------
--CustMaxPayoutSetting_Agent
CREATE TRIGGER [dbo].[CustMaxPayoutSetting_Agent_update] ON [dbo].[CustMaxPayoutSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustMaxPayoutSetting_Agent] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	INSERT INTO CustDB_History.dbo.[CustMaxPayoutSetting_Agent_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[SingleMatchParlay],
		[Combo2],
		[Combo35],
		[ComboOver6]
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[SingleMatchParlay],
		[Combo2],
		[Combo35],
		[ComboOver6]
	FROM [DELETED]
	
END
GO

----------------------------------------------------------------
--CustMaxPayoutSetting_Member
CREATE TRIGGER [dbo].[CustMaxPayoutSetting_Member_update] ON [dbo].[CustMaxPayoutSetting_Member] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustMaxPayoutSetting_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
	
*/
BEGIN 
	SET NOCOUNT ON
	INSERT INTO CustDB_History.dbo.[CustMaxPayoutSetting_Member_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[SingleMatchParlay],
		[Combo2],
		[Combo35],
		[ComboOver6]
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[SingleMatchParlay],
		[Combo2],
		[Combo35],
		[ComboOver6]
	FROM [DELETED]
	
END
GO

----------------------------------------------------------------
--Customer
CREATE TRIGGER [dbo].[trg_Customer_update] ON [dbo].[Customer]
AFTER UPDATE
AS
/*  
	Created by: 2024114@Johnson
	Task: Trigger for updating [Customer] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN
	SET NOCOUNT ON
	 

	INSERT INTO CustDB_History.dbo.Customer_history (
	custid
	,firstname
	,lastname
	,address
	,postal
	,city
	,STATE
	,country
	,phone
	,mobilephone
	,fax
	,email
	,birthday
	,refcode1
	,refcode2
	,remark
	,creatdate
	,creator
	,username
	,currency
	,userpwd
	,lastlogged
	,pwdexpiry
	,roleid
	,mrecommend
	,recommend
	,ugroup
	,logincount
	,on_sessionid
	,site
	,iplogin
	,important
	,srecommend
	,username2
		)
	SELECT d.custid
	,d.firstname
	,d.lastname
	,d.address
	,d.postal
	,d.city
	,d.STATE
	,d.country
	,d.phone
	,d.mobilephone
	,d.fax
	,d.email
	,d.birthday
	,d.refcode1
	,d.refcode2
	,d.remark
	,d.creatdate
	,d.creator
	,d.username
	,d.currency
	,d.userpwd
	,d.lastlogged
	,d.pwdexpiry
	,d.roleid
	,d.mrecommend
	,d.recommend
	,d.ugroup
	,d.logincount
	,d.on_sessionid
	,d.site
	,d.iplogin
	,d.important
	,d.srecommend
	,d.username2
	FROM [DELETED] d
		inner join inserted I on i.custid = d.custid
	WHERE d.lastlogged = i.lastlogged  --- no need to record changes are made on lastlogged column
END
GO

----------------------------------------------------------------
--CustProductStatus
CREATE TRIGGER [dbo].[CustProductStatus_update] ON [dbo].[CustProductStatus] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustProductStatus] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN 
  SET NOCOUNT ON
  
  INSERT INTO CustDB_History.dbo.[CustProductStatus_History] (
    [CustID] ,
    [bitmapHasSynced] ,
    [bitmapIsHidden] ,
    [bitmapIsDisabled],
    [SuspendInfo],
	[Locked],
	[CloseInfo]  
  )
  SELECT
    [CustID] ,
    [bitmapHasSynced] ,
    [bitmapIsHidden] ,
    [bitmapIsDisabled],
    [SuspendInfo],
	[Locked],
	[CloseInfo]
  FROM [DELETED]
END
GO

----------------------------------------------------------------
--CustPTGroupSetting3rd_Member
CREATE TRIGGER [dbo].[CustPTGroupSetting3rd_Member_update] ON [dbo].[CustPTGroupSetting3rd_Member] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustPTGroupSetting3rd_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[CustPTGroupSetting3rd_Member_History] (
		[AgentID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] ,
		[IsAutoMasterPT] ,
		[AutoMasterPT] ,
		[IsAutoSuperPT] ,
		[AutoSuperPT]
	)
	SELECT
		[AgentID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] ,
		[IsAutoMasterPT] ,
		[AutoMasterPT] ,
		[IsAutoSuperPT] ,
		[AutoSuperPT]
	
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--CustPTSetting3rd_Agent
CREATE TRIGGER [dbo].[CustPTSetting3rd_Agent_update] ON [dbo].[CustPTSetting3rd_Agent] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustPTSetting3rd_Agent] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[CustPTSetting3rd_Agent_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] ,
		[IsAutoMasterPT] ,
		[AutoMasterPT] ,
		[IsAutoSuperPT] ,
		[AutoSuperPT] ,
		[MinPT] ,
		[MaxPT] 
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[IsLive] ,
		[SuperPT] ,
		[MasterPT] ,
		[AgentPT] ,
		[IsAutoMasterPT] ,
		[AutoMasterPT] ,
		[IsAutoSuperPT] ,
		[AutoSuperPT] ,
		[MinPT] ,
		[MaxPT] 
	
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--CustPTSetting3rd_Member
CREATE TRIGGER [dbo].[CustPTSetting3rd_Member_update] ON [dbo].[CustPTSetting3rd_Member] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustPTSetting3rd_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[CustPTSetting3rd_Member_History] (
		[CustID],
		[SportType],
		[BetType],
		[IsLive] ,
		[SuperPT],
		[MasterPT],
		[AgentPT],
		[IsAutoMasterPT],
		[AutoMasterPT],
		[IsAutoSuperPT],
		[AutoSuperPT]
	)
	SELECT
		[CustID],
		[SportType],
		[BetType],
		[IsLive] ,
		[SuperPT],
		[MasterPT],
		[AgentPT],
		[IsAutoMasterPT],
		[AutoMasterPT],
		[IsAutoSuperPT],
		[AutoSuperPT]
	
	FROM [DELETED]
END
GO


----------------------------------------------------------------
--CustSettingMode3rd
CREATE TRIGGER [dbo].[CustSettingMode3rd_update] ON [dbo].[CustSettingMode3rd] AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustSettingMode3rd] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.[CustSettingMode3rd_History] (
		[CustID] ,
		[IsGrouped] 
	)
	SELECT
		[CustID] ,
		[IsGrouped]
	FROM [DELETED]
END
GO

----------------------------------------------------------------
--CustStakeLevel_Agent
CREATE TRIGGER [dbo].[CustStakeLevel_Agent_update] ON [dbo].[CustStakeLevel_Agent]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustStakeLevel_Agent] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.CustStakeLevel_Agent_history 
		(	CustID, SportType, BetType, StakeLevelList)
	SELECT	CustID, SportType, BetType, StakeLevelList
	FROM	Deleted
END 
GO

----------------------------------------------------------------
--CustStakeLevel_Member
CREATE TRIGGER [dbo].[CustStakeLevel_Member_update] ON [dbo].[CustStakeLevel_Member]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustStakeLevel_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.CustStakeLevel_Member_history
		(	CustID, SportType, BetType, StakeLevelList, LastUpdated)
	SELECT	CustID, SportType, BetType, StakeLevelList, LastUpdated
	FROM	Deleted
END 
GO

----------------------------------------------------------------
--CustWinLossLimit_Agent
CREATE TRIGGER [dbo].[CustWinLossLimit_Agent_update] ON [dbo].[CustWinLossLimit_Agent]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustWinLossLimit_Agent] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.CustWinLossLimit_Agent_history
		(	CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT	CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
	FROM	Deleted
END 
GO

----------------------------------------------------------------
--CustWinLossLimit_Member
CREATE TRIGGER [dbo].[CustWinLossLimit_Member_update] ON [dbo].[CustWinLossLimit_Member]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustWinLossLimit_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.CustWinLossLimit_Member_history
		(	CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT	CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
	FROM	Deleted
END 