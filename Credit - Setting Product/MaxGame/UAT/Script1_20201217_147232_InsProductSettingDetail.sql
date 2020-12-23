/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task:  Insert ProductSettingDetail for Max Game [RM:#147232]
	DB: DBCUST/CUSTDB
*/
DECLARE  @productID SMALLINT = 22 -- Macau Games
		,@settingType SMALLINT = 8 -- GroupStakeLevel
		,@betType SMALLINT = 5401
		,@sportType SMALLINT = 237

DELETE psd
FROM dbo.ProductSettingDetail psd WITH(ROWLOCK)
WHERE 	psd.ProductID = @productID 
	AND SettingType = @settingType 
	AND SportType  = @sportType 
	AND BetType = @betType			

INSERT INTO [ProductSettingDetail]
    ([SettingType]
    ,[SportType]
    ,[BetType]
    ,[IsLive]
    ,[ProductID]
    ,[MaxPT]
    ,[MaxDiscount]
    ,[IsSync] 
    ,[IsHidden]
    ,[IsDisabled]
    ,[SettingLevel]
    ,[DisplayOrder]
    ,[SettingStatus]
    ,[IntervalValue]
    ,[RealProductId]
    ,[MaxChoice])
VALUES
(
	@settingType,
	@sportType,
	@betType,
	0,-- IsLive
	@productID,
	NULL,-- MaxPT
	NULL,-- MaxDiscount
	NULL,--  IsSync
	NULL,--  IsHidden
    NULL,--  IsDisabled
    2,--  SettingLevel
    5,--  DisplayOrder
    1,--  SettingStatus (only UAT)
    NULL,--  IntervalValue
    22,--  RealProductId
    NULL--  MaxChoice
)

--select * from ProductSettingDetail (NOLOCK) WHERE ProductID = 22