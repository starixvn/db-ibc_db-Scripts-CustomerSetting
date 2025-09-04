/*<info serverAlias="DBCUST-CustDB" executers="" viewers="" isFunction="1" isNested="0"></info>*/
CREATE FUNCTION dbo.Fn_Archive_RestoreData_GetTableListByStage (@Stage INT)
RETURNS @TableList TABLE (
    TableSource NVARCHAR(100),
    TableTarget NVARCHAR(100),
    RoleID      INT DEFAULT 0   -- 0 : ALL , 1 : Member , 2 : SMA
)
AS
BEGIN
     -- Add more stages as needed Stage 1 , 2

    -- Stage 3: All tables Impacted
    IF @Stage = 3
    BEGIN
        INSERT INTO @TableList VALUES
            ('BetSetting_Agent_old',           'BetSetting_Agent', 2),
            ('BetSetting3rd_Agent_old',        'BetSetting3rd_Agent' , 2),
            ('CustDiscount3rd_Agent_old',      'CustDiscount3rd_Agent' , 2),
            ('CustMaxPayoutSetting_Agent_old', 'CustMaxPayoutSetting_Agent' , 2),
            ('CustPTSetting3rd_Agent_old',     'CustPTSetting3rd_Agent' , 2),
            ('CustStakeLevel_Agent_old',       'CustStakeLevel_Agent' , 2),
            ('CustWinLossLimit_Agent_old',     'CustWinLossLimit_Agent' , 2),
            ('CustSettingMode3rd_old',         'CustSettingMode3rd' , 1),
            ('BetSetting_Member_old',          'BetSetting_Member' , 1),
            ('BetSetting3rd_Member_old',       'BetSetting3rd_Member' , 1),
            ('CustDiscount3rd_Member_old',     'CustDiscount3rd_Member' , 1),
            ('CustPTSetting3rd_Member_old',    'CustPTSetting3rd_Member' , 1),
            ('CustMaxPayoutSetting_Member_old','CustMaxPayoutSetting_Member' , 1),
            ('CustStakeLevel_Member_old',      'CustStakeLevel_Member', 1),
            ('CustWinLossLimit_Member_old',    'CustWinLossLimit_Member' , 1),
            ('CustVirtualSetting_Old',         'CustVirtualSetting' , 0 ),
            
            ('custinfo_old',                   'custinfo' , 0),
            ('CustProductStatus_old',          'CustProductStatus' , 0),
            ('CustLoginInfo_old',              'CustLoginInfo' , 2),
            ('CustLoginInfo_Member_old',       'CustLoginInfo_Member' , 1);
    END
    -- Add more stages as needed
    RETURN;
END