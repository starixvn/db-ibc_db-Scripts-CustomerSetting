/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230414@Johnson
	Task: Add profile setting for SportBettypeSettingMatrix for Cricket & Saba Cricket [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 

UPDATE SportBettypeSettingMatrix WITH(UPDLOCK)
SET SportTypeRefBetSetting	= 50,
	BetTypeRefBetSetting = 1,
	StructureVerBetSetting = 'DCS'
WHERE Sporttype = 50
	AND IsLicensee = 1
GO

INSERT INTO [dbo].[SportBettypeSettingMatrix]
           ([SportType]
           ,[BetType]
           ,[isLicensee]
           ,[isLive]
           ,[Site]
           ,[isActive]
           ,[SportTypeRefPT]
           ,[BetTypeRefPT]
           ,[isLivePT]
           ,[TablePT]
           ,[StructureVerPT]
           ,[SportTypeRefComm]
           ,[BetTypeRefComm]
           ,[TableComm]
           ,[StructureVerComm]
           ,[SportTypeRefBetSetting]
           ,[BetTypeRefBetSetting]
           ,[TableBetSetting]
           ,[StructureVerBetSetting]
           ,[IsLiveComm]
           ,[IsLiveBetSetting]
		   ,TableBettrans
		   ,RealProductId)
SELECT t.SportType, s.Bettype, 1 as isLicensee, s.isLive, 'ALL' Site, 1 as isActive, 
	1 SportTypeRefPT, 1 BetTypeRefPT, 0 isLivePT, 'Dep_CustPTGroupSetting_Member' TablePT, 'DCS' StructureVerPT,
	NULL SportTypeRefComm, NULL  BetTypeRefComm, 'Dep_CustDiscountGroupSetting_Member' TableComm, 'DCS' StructureVerComm,
	t.Sporttype as SportTypeRefBetSetting, 1 BetTypeRefBetSetting, 'Dep_CustBetSettingGameGroup_Member' TableBetSetting, 'DCS' StructureVerBetSetting, 0 IsLiveComm, 0 IsLiveBetSetting,
	'bettrans', 1
FROM DBTXN.bodb02.dbo.Sport_Bettype_Reference_Setting s WITH(NOLOCK)
	CROSS APPLY (SELECT 9907 as SportType
				) t
WHERE s.SportType = 50	
	and s.IsLicensee = 1