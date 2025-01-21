/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#216870]
	DB: DBCUST/CustDB
*/

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Acc_SuperPrefix](	 GroupName, Prefix, AllowNewSuper, RepUpdateTime)
	SELECT TOP(1000)	 a.GroupName , a.Prefix , a.AllowNewSuper , a.RepUpdateTime 
	FROM CustDB.[dbo].[Acc_SuperPrefix] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Acc_SuperPrefix] as b WITH(NOLOCK)
	ON a.GroupName = b.GroupName and a.Prefix = b.Prefix
	WHERE b.GroupName is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[CategoryConfig](	 CategoryID, CategoryName, OfferDeposit, CategoryNameCS, CustomerClass, HiddenSite, RepUpdateTime)
	SELECT TOP(1000)	 a.CategoryID , a.CategoryName , a.OfferDeposit , a.CategoryNameCS , a.CustomerClass , a.HiddenSite , a.RepUpdateTime 
	FROM CustDB.[dbo].[CategoryConfig] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[CategoryConfig] as b WITH(NOLOCK)
	ON a.CategoryID = b.CategoryID
	WHERE b.CategoryID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[DangerLevelPolicy](	 SportType, DangerLevel, ActionType, Value, LeagueGroupID)
	SELECT TOP(1000)	 a.SportType , a.DangerLevel , a.ActionType , a.Value , a.LeagueGroupID 
	FROM CustDB.[dbo].[DangerLevelPolicy] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[DangerLevelPolicy] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.DangerLevel = b.DangerLevel and a.ActionType = b.ActionType and a.LeagueGroupID = b.LeagueGroupID
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_Initial_BetSetting](	 ConfigID, Currency, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber, MaxPayoutPerMatch)
	SELECT TOP(1000)	 a.ConfigID , a.Currency , a.SportType , a.BetType , a.MinBet , a.MaxBet , a.MaxPerMatch , a.MaxPerNumber , a.MaxPayoutPerMatch 
	FROM CustDB.[dbo].[Dep_Initial_BetSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_Initial_BetSetting] as b WITH(NOLOCK)
	ON a.ConfigID = b.ConfigID and a.Currency = b.Currency and a.SportType = b.SportType and a.BetType = b.BetType
	WHERE b.ConfigID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_Initial_ProductConfig](	 ConfigID, ProductID, SportTypeList, BetTypeList, Site, Currency, StartTime, EndTime, IsTest, Status, CurrentStep, ProcessedStep, Remark)
	SELECT TOP(1000)	 a.ConfigID , a.ProductID , a.SportTypeList , a.BetTypeList , a.Site , a.Currency , a.StartTime , a.EndTime , a.IsTest , a.Status , a.CurrentStep , a.ProcessedStep , a.Remark 
	FROM CustDB.[dbo].[Dep_Initial_ProductConfig] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_Initial_ProductConfig] as b WITH(NOLOCK)
	ON a.ConfigID = b.ConfigID
	WHERE b.ConfigID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_Initial_ProductConfig_Detail](	 ConfigID, SportType, BetType, IsLive, SettingType, IsDefault, DefaultValueSuper, DefaultValueMaster, DefaultValueAgent, DefaultValueMember, SpecialRequirement)
	SELECT TOP(1000)	 a.ConfigID , a.SportType , a.BetType , a.IsLive , a.SettingType , a.IsDefault , a.DefaultValueSuper , a.DefaultValueMaster , a.DefaultValueAgent , a.DefaultValueMember , a.SpecialRequirement 
	FROM CustDB.[dbo].[Dep_Initial_ProductConfig_Detail] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_Initial_ProductConfig_Detail] as b WITH(NOLOCK)
	ON a.ConfigID = b.ConfigID and a.SportType = b.SportType and a.BetType = b.BetType and a.IsLive = b.IsLive and a.SettingType = b.SettingType
	WHERE b.ConfigID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

 

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_ProductBetSetting](	 Sporttype, Bettype, Currency, MinBet, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch, MaxPerBall, RepUpdateTime)
	SELECT TOP(1000)	 a.Sporttype , a.Bettype , a.Currency , a.MinBet , a.MaxBet , a.MaxPerMatch , a.DefaultMinBet , a.DefaultMaxBet , a.DefaultMaxPerMatch , a.MaxPerBall , a.RepUpdateTime 
	FROM CustDB.[dbo].[Dep_ProductBetSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_ProductBetSetting] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.Bettype = b.Bettype and a.Currency = b.Currency
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_ProductSetting](	 ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductSettingID , a.ProductID , a.SettingType , a.TemplateID , a.DisplayOrder , a.SettingLevel , a.RepUpdateTime 
	FROM CustDB.[dbo].[Dep_ProductSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_ProductSetting] as b WITH(NOLOCK)
	ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductSettingID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_ProductSettingDetail](	 ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductSettingID , a.SportType , a.BetType , a.IsLive , a.MaxDefaultValue , a.SettingStatus , a.MinDefaultValue , a.IsApplyBA , a.RepUpdateTime 
	FROM CustDB.[dbo].[Dep_ProductSettingDetail] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_ProductSettingDetail] as b WITH(NOLOCK)
	ON a.ProductSettingID = b.ProductSettingID and a.SportType = b.SportType and a.BetType = b.BetType and a.IsLive = b.IsLive
	WHERE b.ProductSettingID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_ProductSettingType](	 SettingType, SettingName, SettingNameDetail)
	SELECT TOP(1000)	 a.SettingType , a.SettingName , a.SettingNameDetail 
	FROM CustDB.[dbo].[Dep_ProductSettingType] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_ProductSettingType] as b WITH(NOLOCK)
	ON a.SettingType = b.SettingType
	WHERE b.SettingType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_ProductStakeLevelGroup](	 Sporttype, GameGroupID, MinBet, MaxBet, LicenseeGroupID, Remark, RepUpdateTime, SiteID, isDeleted)
	SELECT TOP(1000)	 a.Sporttype , a.GameGroupID , a.MinBet , a.MaxBet , a.LicenseeGroupID , a.Remark , a.RepUpdateTime , a.SiteID , a.isDeleted 
	FROM CustDB.[dbo].[Dep_ProductStakeLevelGroup] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_ProductStakeLevelGroup] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.GameGroupID = b.GameGroupID and a.LicenseeGroupID = b.LicenseeGroupID and a.SiteID = b.SiteID
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_ProductStatusProfile](	 Sporttype, Bettype, bitmapOrder, RepUpdateTime)
	SELECT TOP(1000)	 a.Sporttype , a.Bettype , a.bitmapOrder , a.RepUpdateTime 
	FROM CustDB.[dbo].[Dep_ProductStatusProfile] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_ProductStatusProfile] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.Bettype = b.Bettype
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevel](	 StakeLevelID, GameTypeID, GameGroupID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeID, ResourceId, SiteID, RepUpdateTime)
	SELECT TOP(1000)	 a.StakeLevelID , a.GameTypeID , a.GameGroupID , a.MinLabel , a.MaxLabel , a.MinStake , a.MaxStake , a.ExchangeID , a.ResourceId , a.SiteID , a.RepUpdateTime 
	FROM CustDB.[dbo].[Dep_StakeLevel] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_StakeLevel] as b WITH(NOLOCK)
	ON a.StakeLevelID = b.StakeLevelID
	WHERE b.StakeLevelID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail](	 StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID, MaxGameStake, RepUpdateTime)
	SELECT TOP(1000)	 a.StakeLevelID , a.GameTypeID , a.MinLabel , a.MaxLabel , a.MinStake , a.MaxStake , a.ParentTypeID , a.MaxGameStake , a.RepUpdateTime 
	FROM CustDB.[dbo].[Dep_StakeLevelGroupDetail] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail] as b WITH(NOLOCK)
	ON a.StakeLevelID = b.StakeLevelID and a.GameTypeID = b.GameTypeID
	WHERE b.StakeLevelID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail_History](	 StakeLevelID, GameTypeID, MaxLabel, MaxStake, MaxGameStake, UpdateTime)
	SELECT TOP(1000)	 a.StakeLevelID , a.GameTypeID , a.MaxLabel , a.MaxStake , a.MaxGameStake , a.UpdateTime 
	FROM CustDB.[dbo].[Dep_StakeLevelGroupDetail_History] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail_History] as b WITH(NOLOCK)
	ON a.StakeLevelID = b.StakeLevelID and a.GameTypeID = b.GameTypeID and a.UpdateTime = b.UpdateTime
	WHERE b.StakeLevelID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Dep_UMConfig](	 FunctionType, ProductID, SettingType, LicenseeID, BeginTime, EndTime, Time_Stamp)
	SELECT TOP(1000)	 a.FunctionType , a.ProductID , a.SettingType , a.LicenseeID , a.BeginTime , a.EndTime , a.Time_Stamp 
	FROM CustDB.[dbo].[Dep_UMConfig] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Dep_UMConfig] as b WITH(NOLOCK)
	ON a.FunctionType = b.FunctionType and a.ProductID = b.ProductID and a.SettingType = b.SettingType and a.LicenseeID = b.LicenseeID
	WHERE b.FunctionType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[DomainManagement](	 DomainID, Domain, System, Site, BrandName, Status, ExpiredDate, LastUpdateTime, RestrictedCountries, Remark, isDeleted, RepUpdateTime)
	SELECT TOP(1000)	 a.DomainID , a.Domain , a.System , a.Site , a.BrandName , a.Status , a.ExpiredDate , a.LastUpdateTime , a.RestrictedCountries , a.Remark , a.isDeleted , a.RepUpdateTime 
	FROM CustDB.[dbo].[DomainManagement] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[DomainManagement] as b WITH(NOLOCK)
	ON a.DomainID = b.DomainID
	WHERE b.DomainID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[EaGroupHeadline](	 GroupHeadlineId, GroupId, GroupName, SiteId, ExchangeId, GroupTypeId, EffectiveDate, EndDate, RepUpdateTime)
	SELECT TOP(1000)	 a.GroupHeadlineId , a.GroupId , a.GroupName , a.SiteId , a.ExchangeId , a.GroupTypeId , a.EffectiveDate , a.EndDate , a.RepUpdateTime 
	FROM CustDB.[dbo].[EaGroupHeadline] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[EaGroupHeadline] as b WITH(NOLOCK)
	ON a.GroupHeadlineId = b.GroupHeadlineId and a.GroupId = b.GroupId and a.GroupName = b.GroupName and a.SiteId = b.SiteId and a.ExchangeId = b.ExchangeId
	WHERE b.GroupHeadlineId is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[GameGroup](	 GameGroupID, RefSportType, RefBetType, GroupName, IsDeposit, RepUpdateTime)
	SELECT TOP(1000)	 a.GameGroupID , a.RefSportType , a.RefBetType , a.GroupName , a.IsDeposit , a.RepUpdateTime 
	FROM CustDB.[dbo].[GameGroup] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[GameGroup] as b WITH(NOLOCK)
	ON a.GameGroupID = b.GameGroupID
	WHERE b.GameGroupID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[GameLaunchPerCurrency](	 SportType, BetType, Currency, IsLaunched, IsTest, RepUpdateTime)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.Currency , a.IsLaunched , a.IsTest , a.RepUpdateTime 
	FROM CustDB.[dbo].[GameLaunchPerCurrency] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[GameLaunchPerCurrency] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType and a.Currency = b.Currency
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[GameLaunchPerSite](	 SportType, BetType, SiteID, IsLaunched, IsTest, RepUpdateTime)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.SiteID , a.IsLaunched , a.IsTest , a.RepUpdateTime 
	FROM CustDB.[dbo].[GameLaunchPerSite] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[GameLaunchPerSite] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType and a.SiteID = b.SiteID
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[GameRoundBetLimitSettings](	 SportType, BetType, ProductID, GameRoundBetLimit, RepUpdateTime)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.ProductID , a.GameRoundBetLimit , a.RepUpdateTime 
	FROM CustDB.[dbo].[GameRoundBetLimitSettings] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[GameRoundBetLimitSettings] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Initial_ProductConfig](	 ConfigID, ProductID, SportTypeList, BetTypeList, Site, Currency, StartTime, EndTime, IsTest, Status, CurrentStep, ProcessedStep, Remark)
	SELECT TOP(1000)	 a.ConfigID , a.ProductID , a.SportTypeList , a.BetTypeList , a.Site , a.Currency , a.StartTime , a.EndTime , a.IsTest , a.Status , a.CurrentStep , a.ProcessedStep , a.Remark 
	FROM CustDB.[dbo].[Initial_ProductConfig] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Initial_ProductConfig] as b WITH(NOLOCK)
	ON a.ConfigID = b.ConfigID
	WHERE b.ConfigID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Initial_ProductConfig_Detail](	 ConfigID, SportType, BetType, IsLive, SettingType, IsDefault, CopyFromSportType, CopyFromBetType, DefaultValueSuper, DefaultValueMaster, DefaultValueAgent, DefaultValueMember, SpecialRequirement)
	SELECT TOP(1000)	 a.ConfigID , a.SportType , a.BetType , a.IsLive , a.SettingType , a.IsDefault , a.CopyFromSportType , a.CopyFromBetType , a.DefaultValueSuper , a.DefaultValueMaster , a.DefaultValueAgent , a.DefaultValueMember , a.SpecialRequirement 
	FROM CustDB.[dbo].[Initial_ProductConfig_Detail] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Initial_ProductConfig_Detail] as b WITH(NOLOCK)
	ON a.ConfigID = b.ConfigID and a.SportType = b.SportType and a.BetType = b.BetType and a.IsLive = b.IsLive and a.SettingType = b.SettingType
	WHERE b.ConfigID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

 

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[LossLimit_GlobalSetting](	 ProductId, ExchangeId, MinLossLimit, DefaultLossLimit, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductId , a.ExchangeId , a.MinLossLimit , a.DefaultLossLimit , a.RepUpdateTime 
	FROM CustDB.[dbo].[LossLimit_GlobalSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[LossLimit_GlobalSetting] as b WITH(NOLOCK)
	ON a.ProductId = b.ProductId and a.ExchangeId = b.ExchangeId
	WHERE b.ProductId is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[MaxPayoutGlobalSetting](	 SportType, BetType, Currency, SingleMatchParlay, Combo2, Combo35, ComboOver6, SettingStatus, RepUpdateTime)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.Currency , a.SingleMatchParlay , a.Combo2 , a.Combo35 , a.ComboOver6 , a.SettingStatus , a.RepUpdateTime 
	FROM CustDB.[dbo].[MaxPayoutGlobalSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[MaxPayoutGlobalSetting] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType and a.Currency = b.Currency
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[MsgError](	 MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN, MsgNameIN, RepUpdateTime)
	SELECT TOP(1000)	 a.MsgID , a.MsgGroupID , a.MsgNameEN , a.MsgNameCT , a.MsgNameCS , a.MsgNameJP , a.MsgNameTH , a.MsgNameKO , a.MsgNameES , a.MsgNameVI , a.IsActive , a.MsgNameCN , a.MsgNameIN , a.RepUpdateTime 
	FROM CustDB.[dbo].[MsgError] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[MsgError] as b WITH(NOLOCK)
	ON a.MsgID = b.MsgID
	WHERE b.MsgID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[MsgErrorGroup](	 MsgGroupID, MsgGroupName, RepUpdateTime)
	SELECT TOP(1000)	 a.MsgGroupID , a.MsgGroupName , a.RepUpdateTime 
	FROM CustDB.[dbo].[MsgErrorGroup] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[MsgErrorGroup] as b WITH(NOLOCK)
	ON a.MsgGroupID = b.MsgGroupID
	WHERE b.MsgGroupID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[PlayCurrencySetting](	 ID, SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate, RepUpdateTime)
	SELECT TOP(1000)	 a.ID , a.SiteId , a.SiteName , a.SportType , a.MemberCurrency , a.PlayCurrency , a.FromDate , a.ToDate , a.RepUpdateTime 
	FROM CustDB.[dbo].[PlayCurrencySetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[PlayCurrencySetting] as b WITH(NOLOCK)
	ON a.ID = b.ID
	WHERE b.ID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProblemAccountReason](	 ReasonID, ReasonName, IsCN88, IsCredit, IsLicensee, ReasonNameCS, ReasonGroupID, RepUpdateTime)
	SELECT TOP(1000)	 a.ReasonID , a.ReasonName , a.IsCN88 , a.IsCredit , a.IsLicensee , a.ReasonNameCS , a.ReasonGroupID , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProblemAccountReason] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProblemAccountReason] as b WITH(NOLOCK)
	ON a.ReasonID = b.ReasonID
	WHERE b.ReasonID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductBetSetting](	 Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch, RepUpdateTime)
	SELECT TOP(1000)	 a.Sporttype , a.Bettype , a.Currency , a.MinBet , a.IsDep , a.MaxBet , a.MaxPerMatch , a.DefaultMinBet , a.DefaultMaxBet , a.DefaultMaxPerMatch , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductBetSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductBetSetting] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.Bettype = b.Bettype and a.Currency = b.Currency
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductGlobalSetting](	 Sporttype, Bettype, MaxPositiontaking, Maxsdiscount, IsDep, RepUpdateTime)
	SELECT TOP(1000)	 a.Sporttype , a.Bettype , a.MaxPositiontaking , a.Maxsdiscount , a.IsDep , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductGlobalSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductGlobalSetting] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.Bettype = b.Bettype
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductLaunchedSiteCurrency](	 SiteID, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel, RepUpdateTime)
	SELECT TOP(1000)	 a.SiteID , a.Currency , a.SportType , a.IsLaunched , a.IsTest , a.BetType , a.LaunchedLevel , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductLaunchedSiteCurrency] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductLaunchedSiteCurrency] as b WITH(NOLOCK)
	ON a.SiteID = b.SiteID and a.Currency = b.Currency and a.SportType = b.SportType and a.BetType = b.BetType and a.LaunchedLevel = b.LaunchedLevel
	WHERE b.SiteID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductProfileSiteCurrency](	 SiteID, Currency, ProductSettingID, RepUpdateTime)
	SELECT TOP(1000)	 a.SiteID , a.Currency , a.ProductSettingID , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductProfileSiteCurrency] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductProfileSiteCurrency] as b WITH(NOLOCK)
	ON a.SiteID = b.SiteID and a.Currency = b.Currency and a.ProductSettingID = b.ProductSettingID
	WHERE b.SiteID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductProfileSiteCurrency_UAT](	 SiteID, Currency, ProductSettingID, RepUpdateTime)
	SELECT TOP(1000)	 a.SiteID , a.Currency , a.ProductSettingID , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductProfileSiteCurrency_UAT] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductProfileSiteCurrency_UAT] as b WITH(NOLOCK)
	ON a.SiteID = b.SiteID and a.Currency = b.Currency and a.ProductSettingID = b.ProductSettingID
	WHERE b.SiteID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingDetail](	 SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType, RepUpdateTime)
	SELECT TOP(1000)	 a.SettingType , a.SportType , a.BetType , a.IsLive , a.ProductID , a.MaxPT , a.MaxDiscount , a.IsSync , a.IsHidden , a.IsDisabled , a.SettingLevel , a.DisplayOrder , a.SettingStatus , a.IntervalValue , a.RealProductId , a.MaxChoice , a.ProductSettingID , a.Parent_ProductSettingID , a.Child_DisplayOrder , a.SubType , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductSettingDetail] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingDetail] as b WITH(NOLOCK)
	ON a.ProductSettingID = b.ProductSettingID and a.SettingType = b.SettingType and a.SportType = b.SportType and a.BetType = b.BetType and a.IsLive = b.IsLive
	WHERE b.ProductSettingID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingDetail_UAT](	 SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType, RepUpdateTime)
	SELECT TOP(1000)	 a.SettingType , a.SportType , a.BetType , a.IsLive , a.ProductID , a.MaxPT , a.MaxDiscount , a.IsSync , a.IsHidden , a.IsDisabled , a.SettingLevel , a.DisplayOrder , a.SettingStatus , a.IntervalValue , a.RealProductId , a.MaxChoice , a.ProductSettingID , a.Parent_ProductSettingID , a.Child_DisplayOrder , a.SubType , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductSettingDetail_UAT] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingDetail_UAT] as b WITH(NOLOCK)
	ON a.SettingType = b.SettingType and a.SportType = b.SportType and a.BetType = b.BetType and a.IsLive = b.IsLive and a.ProductSettingID = b.ProductSettingID
	WHERE b.SettingType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingProfile](	 ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductSettingID , a.SettingType , a.SportType , a.BetType , a.IsLive , a.ProductID , a.MaxPT , a.MaxDiscount , a.IsSync , a.IsHidden , a.IsDisabled , a.SettingLevel , a.DisplayOrder , a.SettingStatus , a.IntervalValue , a.RealProductId , a.MaxChoice , a.Parent_ProductSettingID , a.Child_DisplayOrder , a.SubType , a.GroupID , a.GroupType , a.GroupTypeOrder , a.SubGroupID , a.SubGroupOrder , a.CreationStatus , a.DisplayType , a.MarketType , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductSettingProfile] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingProfile] as b WITH(NOLOCK)
	ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductSettingID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingProfile_UAT](	 ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductSettingID , a.SettingType , a.SportType , a.BetType , a.IsLive , a.ProductID , a.MaxPT , a.MaxDiscount , a.IsSync , a.IsHidden , a.IsDisabled , a.SettingLevel , a.DisplayOrder , a.SettingStatus , a.IntervalValue , a.RealProductId , a.MaxChoice , a.Parent_ProductSettingID , a.Child_DisplayOrder , a.SubType , a.GroupID , a.GroupType , a.GroupTypeOrder , a.SubGroupID , a.SubGroupOrder , a.CreationStatus , a.DisplayType , a.MarketType , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductSettingProfile_UAT] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingProfile_UAT] as b WITH(NOLOCK)
	ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductSettingID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingSystemDisplay](	 SystemID, ProductID, SettingType, DisplayMode, RepUpdateTime)
	SELECT TOP(1000)	 a.SystemID , a.ProductID , a.SettingType , a.DisplayMode , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductSettingSystemDisplay] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingSystemDisplay] as b WITH(NOLOCK)
	ON a.SystemID = b.SystemID and a.ProductID = b.ProductID and a.SettingType = b.SettingType
	WHERE b.SystemID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

 

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingType](	 SettingType, SettingName, SettingNameDetail)
	SELECT TOP(1000)	 a.SettingType , a.SettingName , a.SettingNameDetail 
	FROM CustDB.[dbo].[ProductSettingType] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingType] as b WITH(NOLOCK)
	ON a.SettingType = b.SettingType
	WHERE b.SettingType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductSettingUpdateRestriction](	 SystemID, ProductID, SettingType, ActorRoleID, TargetRoleID, ErrCode, RestrictionMode, RepUpdateTime)
	SELECT TOP(1000)	 a.SystemID , a.ProductID , a.SettingType , a.ActorRoleID , a.TargetRoleID , a.ErrCode , a.RestrictionMode , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductSettingUpdateRestriction] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductSettingUpdateRestriction] as b WITH(NOLOCK)
	ON a.SystemID = b.SystemID and a.ProductID = b.ProductID and a.SettingType = b.SettingType and a.ActorRoleID = b.ActorRoleID and a.TargetRoleID = b.TargetRoleID
	WHERE b.SystemID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductStakeLevelGroup](	 Sporttype, GameGroupID, MinBet, MaxBet, CreditGroupID, Remark, RepUpdateTime, isDeleted)
	SELECT TOP(1000)	 a.Sporttype , a.GameGroupID , a.MinBet , a.MaxBet , a.CreditGroupID , a.Remark , a.RepUpdateTime , a.isDeleted 
	FROM CustDB.[dbo].[ProductStakeLevelGroup] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductStakeLevelGroup] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.GameGroupID = b.GameGroupID and a.CreditGroupID = b.CreditGroupID
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductStatusProfile](	 Sporttype, Bettype, bitmapOrder, RepUpdateTime)
	SELECT TOP(1000)	 a.Sporttype , a.Bettype , a.bitmapOrder , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductStatusProfile] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductStatusProfile] as b WITH(NOLOCK)
	ON a.Sporttype = b.Sporttype and a.Bettype = b.Bettype
	WHERE b.Sporttype is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[ProductStatusSiteCurrency](	 SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced, RepUpdateTime)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.Currency , a.SiteID , a.IsHidden , a.IsDisabled , a.HasSynced , a.RepUpdateTime 
	FROM CustDB.[dbo].[ProductStatusSiteCurrency] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[ProductStatusSiteCurrency] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType and a.Currency = b.Currency and a.SiteID = b.SiteID
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[SettingSystem](	 SystemID, SystemName, Description, SystemPrefix)
	SELECT TOP(1000)	 a.SystemID , a.SystemName , a.Description , a.SystemPrefix 
	FROM CustDB.[dbo].[SettingSystem] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[SettingSystem] as b WITH(NOLOCK)
	ON a.SystemID = b.SystemID
	WHERE b.SystemID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Site](	 siteid, site, type, spreada, spreadb, spreadc, spreadd, spreade, spreadf, ServerID, isLicensee, isActive, isDeposit, SpecialGroup, BlockNewCust, UnblockTime, IsChinaView, RepUpdateTime, SiteDBGroupID, SiteLabel, SpecialPlatfrom, CustDBGroupID, SiteType)
	SELECT TOP(1000)	 a.siteid , a.site , a.type , a.spreada , a.spreadb , a.spreadc , a.spreadd , a.spreade , a.spreadf , a.ServerID , a.isLicensee , a.isActive , a.isDeposit , a.SpecialGroup , a.BlockNewCust , a.UnblockTime , a.IsChinaView , a.RepUpdateTime , a.SiteDBGroupID , a.SiteLabel , a.SpecialPlatfrom , a.CustDBGroupID , a.SiteType 
	FROM CustDB.[dbo].[Site] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Site] as b WITH(NOLOCK)
	ON a.siteid = b.siteid
	WHERE b.siteid is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[SiteDBConfig](	 SiteDBGroupID, LinkedServerName, ClientAccessName, AGIP, AWSProxyDomain, AWSProxyPort, RepUpdateTime, FQDN)
	SELECT TOP(1000)	 a.SiteDBGroupID , a.LinkedServerName , a.ClientAccessName , a.AGIP , a.AWSProxyDomain , a.AWSProxyPort , a.RepUpdateTime , a.FQDN 
	FROM CustDB.[dbo].[SiteDBConfig] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[SiteDBConfig] as b WITH(NOLOCK)
	ON a.SiteDBGroupID = b.SiteDBGroupID
	WHERE b.SiteDBGroupID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[SportBettypeSettingMatrix](	 SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, SportTypeRefComm, BetTypeRefComm, TableComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, SporttypeRefWinlossLimit, BettypeRefWinlossLimit, RealProductId, isDeleted, RepUpdateTime, ProductID)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.isLicensee , a.isLive , a.Site , a.isActive , a.SportTypeRefPT , a.BetTypeRefPT , a.isLivePT , a.TablePT , a.SportTypeRefComm , a.BetTypeRefComm , a.TableComm , a.SportTypeRefBetSetting , a.BetTypeRefBetSetting , a.TableBetSetting , a.IsLiveComm , a.IsLiveBetSetting , a.TableBettrans , a.SporttypeRefWinlossLimit , a.BettypeRefWinlossLimit , a.RealProductId , a.isDeleted , a.RepUpdateTime , a.ProductID 
	FROM CustDB.[dbo].[SportBettypeSettingMatrix] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[SportBettypeSettingMatrix] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType and a.isLicensee = b.isLicensee and a.isLive = b.isLive and a.Site = b.Site
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[SportNonOfferedSiteCurrency](	 SportType, BetType, Currency, SiteID, RealProductID, RepUpdateTime)
	SELECT TOP(1000)	 a.SportType , a.BetType , a.Currency , a.SiteID , a.RealProductID , a.RepUpdateTime 
	FROM CustDB.[dbo].[SportNonOfferedSiteCurrency] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[SportNonOfferedSiteCurrency] as b WITH(NOLOCK)
	ON a.SportType = b.SportType and a.BetType = b.BetType and a.Currency = b.Currency and a.SiteID = b.SiteID
	WHERE b.SportType is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[StakeLevel](	 StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID, RepUpdateTime)
	SELECT TOP(1000)	 a.StakeLevelID , a.GameTypeID , a.MinLabel , a.MaxLabel , a.MinStake , a.MaxStake , a.ExchangeId , a.ResourceId , a.GameGroupID , a.RepUpdateTime 
	FROM CustDB.[dbo].[StakeLevel] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[StakeLevel] as b WITH(NOLOCK)
	ON a.StakeLevelID = b.StakeLevelID
	WHERE b.StakeLevelID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[StakeLevel_History](	 StakeLevelID, GameTypeID, MaxLabel, MaxStake, UpdateTime)
	SELECT TOP(1000)	 a.StakeLevelID , a.GameTypeID , a.MaxLabel , a.MaxStake , a.UpdateTime 
	FROM CustDB.[dbo].[StakeLevel_History] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[StakeLevel_History] as b WITH(NOLOCK)
	ON a.StakeLevelID = b.StakeLevelID and a.UpdateTime = b.UpdateTime
	WHERE b.StakeLevelID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[SystemSettings](	 VID, VName, VValue)
	SELECT TOP(1000)	 a.VID , a.VName , a.VValue 
	FROM CustDB.[dbo].[SystemSettings] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[SystemSettings] as b WITH(NOLOCK)
	ON a.VName = b.VName
	WHERE b.VName is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[UMConfig](	 ProductID, SportType, BetType, IsLive, SettingType, FunctionType, SiteID, Currency, SuperID, BeginTime, EndTime, Time_Stamp, ShowTime, LockAddingNew, ConfigID)
	SELECT TOP(1000)	 a.ProductID , a.SportType , a.BetType , a.IsLive , a.SettingType , a.FunctionType , a.SiteID , a.Currency , a.SuperID , a.BeginTime , a.EndTime , a.Time_Stamp , a.ShowTime , a.LockAddingNew , a.ConfigID 
	FROM CustDB.[dbo].[UMConfig] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[UMConfig] as b WITH(NOLOCK)
	ON a.ProductID = b.ProductID and a.SportType = b.SportType and a.BetType = b.BetType and a.IsLive = b.IsLive and a.SettingType = b.SettingType and a.FunctionType = b.FunctionType and a.SiteID = b.SiteID and a.Currency = b.Currency and a.SuperID = b.SuperID
	WHERE b.ProductID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Winlimit_ActionSetting](	 ActionID, ActionName, RepUpdateTime)
	SELECT TOP(1000)	 a.ActionID , a.ActionName , a.RepUpdateTime 
	FROM CustDB.[dbo].[Winlimit_ActionSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Winlimit_ActionSetting] as b WITH(NOLOCK)
	ON a.ActionID = b.ActionID
	WHERE b.ActionID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Winlimit_GameGroupSetting](	 ProductID, BetTypeID, GroupID, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductID , a.BetTypeID , a.GroupID , a.RepUpdateTime 
	FROM CustDB.[dbo].[Winlimit_GameGroupSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Winlimit_GameGroupSetting] as b WITH(NOLOCK)
	ON a.ProductID = b.ProductID and a.BetTypeID = b.BetTypeID
	WHERE b.ProductID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Winlimit_Group](	 GroupID, GroupName)
	SELECT TOP(1000)	 a.GroupID , a.GroupName 
	FROM CustDB.[dbo].[Winlimit_Group] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Winlimit_Group] as b WITH(NOLOCK)
	ON a.GroupID = b.GroupID
	WHERE b.GroupID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Winlimit_LevelSetting](	 LevelID, LevelName, LevelOrder, RepUpdateTime)
	SELECT TOP(1000)	 a.LevelID , a.LevelName , a.LevelOrder , a.RepUpdateTime 
	FROM CustDB.[dbo].[Winlimit_LevelSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Winlimit_LevelSetting] as b WITH(NOLOCK)
	ON a.LevelID = b.LevelID
	WHERE b.LevelID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Winlimit_ProductGlobalSetting](	 ProductID, BetTypeID, GroupID, GroupName, Level1, Level2, Level3, Level101, Level102, blockedTransferLvl3, Currency, IsDeposit)
	SELECT TOP(1000)	 a.ProductID , a.BetTypeID , a.GroupID , a.GroupName , a.Level1 , a.Level2 , a.Level3 , a.Level101 , a.Level102 , a.blockedTransferLvl3 , a.Currency , a.IsDeposit 
	FROM CustDB.[dbo].[Winlimit_ProductGlobalSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Winlimit_ProductGlobalSetting] as b WITH(NOLOCK)
	ON a.ProductID = b.ProductID and a.BetTypeID = b.BetTypeID and a.GroupID = b.GroupID and a.Currency = b.Currency and a.IsDeposit = b.IsDeposit
	WHERE b.ProductID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[Winlimit_ProductSetting](	 ProductID, BettypeID, LevelID, SettingStatus, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductID , a.BettypeID , a.LevelID , a.SettingStatus , a.RepUpdateTime 
	FROM CustDB.[dbo].[Winlimit_ProductSetting] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[Winlimit_ProductSetting] as b WITH(NOLOCK)
	ON a.ProductID = b.ProductID and a.BettypeID = b.BettypeID and a.LevelID = b.LevelID
	WHERE b.ProductID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

while 1 = 1 
begin 
	INSERT INTO GlobCustDB.[dbo].[WinLimit_ProductSettingDetail](	 ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount, RepUpdateTime)
	SELECT TOP(1000)	 a.ProductID , a.GroupID , a.ExchangeID , a.SiteID , a.LevelID , a.MaxWinLimit , a.IsBlockedPlaceBet , a.IsBlockedTransfer , a.MaxWinLimit_RM , a.IsSuspendedAccount , a.RepUpdateTime 
	FROM CustDB.[dbo].[WinLimit_ProductSettingDetail] as a WITH(NOLOCK)
	LEFT JOIN GlobCustDB.[dbo].[WinLimit_ProductSettingDetail] as b WITH(NOLOCK)
	ON a.ProductID = b.ProductID and a.GroupID = b.GroupID and a.ExchangeID = b.ExchangeID and a.SiteID = b.SiteID and a.LevelID = b.LevelID
	WHERE b.ProductID is null;
	IF @@ROWCOUNT = 0 BREAK;
	WAITFOR DELAY '00:00:00.100';
END;

