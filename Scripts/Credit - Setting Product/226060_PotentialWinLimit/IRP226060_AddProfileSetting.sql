/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250509@Johnson	
	Task: Add profile setting for Potential Winning Limit/Threshold [redmine:#226060]
	DB: DBCUST-CustDB
*/
/*
--update current order for SB
UPDATE ProductSettingProfile WITH (ROWLOCK)
SET GroupTypeOrder = GroupTypeOrder*5,
    RepUpdateTime = SYSDATETIME()
WHERE GroupID = 1
    and GroupTypeOrder > 1

--script rollback
UPDATE ProductSettingProfile WITH (ROWLOCK)
SET GroupTypeOrder = GroupTypeOrder/5,
    RepUpdateTime = SYSDATETIME()
WHERE GroupID = 1
    and GroupTypeOrder > 1
*/    


--add new profile setting for Potential Winning Limit/Threshold         
INSERT INTO [dbo].[ProductSettingProfile]
           ([ProductSettingID]
           ,[SettingType]
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
           ,[MaxChoice]
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType]
           ,[GroupID]
           ,[GroupType]
           ,[GroupTypeOrder]
           ,[SubGroupID]
           ,[SubGroupOrder]
           ,[CreationStatus]
           ,[DisplayType]
           ,[MarketType]
           ,[RepUpdateTime]
           )
SELECT  383 ProductSettingID, 30 SettingType, 0 SportType, 0 BetType, 0 IsLive, 1 ProductID, 90 MaxPT, 0.01 MaxDiscount, 0 IsSync, 1 IsHidden, 0 IsDisabled, 1 SettingLevel, 1 DisplayOrder, 1 SettingStatus, NULL IntervalValue, 1 RealProductId, NULL MaxChoice, NULL Parent_ProductSettingID, 1 Child_DisplayOrder, NULL SubType,
        1 GroupID, 162 GroupType, 5 GroupTypeOrder, NULL SubGroupID, NULL SubGroupOrder, 0 CreationStatus, NULL DisplayType, 0 MarketType, SYSDATETIME() RepUpdateTime       

INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail)
SELECT 162, 'GT Potential Win Limit','Potential Win Limit'
