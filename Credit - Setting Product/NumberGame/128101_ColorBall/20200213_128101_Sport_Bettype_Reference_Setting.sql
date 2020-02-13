/*
    Created: Tiara
    Date: 2020-02-13
    Task : Insert data to Sport_Bettype_Reference_Setting for NG Color Ball [Redmine: #128101]
    DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

INSERT [dbo].[Sport_Bettype_Reference_Setting]  ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting]) VALUES (161,91,0,1,'All',1,161,85,1,'CustSetting3rd','default',161,85,'CustSetting3rd','default',161,85,'CustSetting3rd','default')
INSERT [dbo].[Sport_Bettype_Reference_Setting]  ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting]) VALUES (161,91,1,1,'All',1,161,81,0,'Dep_CustSetting3rd','default',161,81,'Dep_CustSetting3rd','default',161,81,'Dep_CustSetting3rd','default')
INSERT [dbo].[Sport_Bettype_Reference_Setting]  ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting]) VALUES (161,91,0,1,'CN88',1,9998,81,0,'CS_CustPTGroupSetting_Member','DCS',NULL,NULL,'CS_CustDiscount_Member','DCS',9998,81,'CS_CustBetSetting_Member','DCS')