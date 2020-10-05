/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201002@Eden
	Task: Create ProductSettingType table [Redmine:#142115]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
--DROP TABLE [ProductSettingType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSettingType](
	SettingType TINYINT NOT NULL,
	SettingName VARCHAR(30),
	SettingNameDetail VARCHAR(30),
CONSTRAINT [PK_ProductSettingType] PRIMARY KEY CLUSTERED 
(
	SettingType ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Data]

) ON [Data]

--Insert Data for ProductSettingType
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (1, 'Position Taking', 'PositionTaking')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (18, 'Position Taking', 'PositionTaking')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (2, 'Bet Setting', 'BetLimit')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (9, 'Bet Setting', 'GameBetLimit')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (16, 'Bet Setting', 'BetSetting')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (3, 'Commission', 'Discount')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (19, 'Commission', 'Discount')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (5, 'Commission', 'ChargeCommission')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (10, 'Commission', 'GroupDiscount')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (14, 'Commission', 'TicketCommission')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (15, 'Commission', 'WinningShareCommission')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (4, 'Product Status', 'ProductStatus')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (11, 'Product Status', 'ProductGameStatus')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (13, 'Product Status', 'NewProductStatus')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (6, 'Win Loss Limit', 'WinLossLimit')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (12, 'Win Loss Limit', 'LossLimit')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (7, 'Stake Level', 'SingleStakeLevel')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (8, 'Stake Level', 'GroupStakeLevel')
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (17, 'Stake Level', 'MultipleStakeLevel')
