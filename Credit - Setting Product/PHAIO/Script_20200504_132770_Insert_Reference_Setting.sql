/*
	Date: 20200504@Eden
	Task: PHAIO 5.1: Offer New Bet Types Penalty Shootout Combo [#132770]
	DB: DBTRANS/bodb02
*/
USE [bodb02]
GO
DELETE
FROM Sport_Bettype_Reference_Setting WITH (ROWLOCK)
WHERE bettype = 376

INSERT [dbo].[Sport_Bettype_Reference_Setting] ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting]) VALUES (1, 376, 0, 0, N'All', 0, 1, 4, 0, N'CustSetting', N'default', 1, 4, N'CustSetting', N'default', 1, 4, N'CustSetting', N'default', 0, 0)
INSERT [dbo].[Sport_Bettype_Reference_Setting] ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting]) VALUES (1, 376, 0, 1, N'All', 0, 1, 4, 0, N'CustSetting', N'default', 1, 4, N'CustSetting', N'default', 1, 4, N'CustSetting', N'default', 0, 0)
INSERT [dbo].[Sport_Bettype_Reference_Setting] ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting]) VALUES (1, 376, 1, 0, N'All', 0, 1, 4, 0, N'Dep_CustSetting', N'default', 1, 4, N'Dep_CustSetting', N'default', 1, 4, N'Dep_CustSetting', N'default', 0, 0)
INSERT [dbo].[Sport_Bettype_Reference_Setting] ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting]) VALUES (1, 376, 1, 1, N'All', 0, 1, 4, 0, N'Dep_CustSetting', N'default', 1, 4, N'Dep_CustSetting', N'default', 1, 4, N'Dep_CustSetting', N'default', 0, 0)
INSERT [dbo].[Sport_Bettype_Reference_Setting] ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting]) VALUES (1, 376, 0, 0, N'CN88', 0, 1, 1, 0, N'CS_CustPTGroupSetting_Member', N'DCS', 1, 9999, N'CS_CustDiscount_Member', N'DCS', 1, 9999, N'CS_CustBetSetting_Member', N'DCS', 0, 0)
INSERT [dbo].[Sport_Bettype_Reference_Setting] ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting]) VALUES (1, 376, 0, 1, N'CN88', 0, 1, 1, 0, N'CS_CustPTGroupSetting_Member', N'DCS', 1, 9999, N'CS_CustDiscount_Member', N'DCS', 1, 9999, N'CS_CustBetSetting_Member', N'DCS', 1, 1)

SELECT *
FROM Sport_Bettype_Reference_Setting S WITH (NOLOCK)
WHERE bettype = 376