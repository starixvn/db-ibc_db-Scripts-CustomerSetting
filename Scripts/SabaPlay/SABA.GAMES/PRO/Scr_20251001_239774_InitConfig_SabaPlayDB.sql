/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on SABAPLAY[#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
------------------------SABAPLAY DB----------------------------------------------------
--Insert OperatorGameSetting table
DECLARE @Env VARCHAR(10) = 'UAT' --SIT, UAT, PRO
DECLARE @return_value int, @ErrCode int, @ErrMsg varchar(100)
DECLARE @VendorGeneralURL varchar(255)  -- OwcwApiServer
DECLARE @VendorResultURL varchar(255)  -- OwcwApiServer
DECLARE @OwCoreURL varchar(255) --OneWorksApiCoreServer
DECLARE @RefKey varchar(50)
DECLARE @Note nvarchar(255)

IF @Env = 'PRO'
BEGIN
	SET @VendorGeneralURL = N'http://sg-intapi.vn-sc-klprod.gamora.prod'
	SET @VendorResultURL = N'http://sg-intresult.vn-sc-klprod.gamora.prod'
	SET @OwCoreURL = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/SabaClub'
	SET @RefKey = N'61tSCtQEwZscs93kK324lC0uQShncZmf'
	SET @Note = N'9jg479kb7v9kjv0g'
END
ELSE IF @Env = 'UAT'
BEGIN
	SET @VendorGeneralURL = N'http://l1uatapi.vn-sc-kluat.gamora.prod'
	SET @VendorResultURL = N'http://l1uatresult.vn-sc-kluat.gamora.prod'
	SET @OwCoreURL = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/SabaClub'
	SET @RefKey = N'61tSCtQEwZscs93kK324lC0uQShncZmf'
	SET @Note = N'9jg479kb7v9kjv0g'
END
ELSE IF @Env = 'SIT'
BEGIN
	SET @VendorGeneralURL = N'http://l1api.sc-sit.nebula.sit'
	SET @VendorResultURL = N'http://l1result.sc-sit.nebula.sit'
	SET @OwCoreURL = N'http://owapi1.playonesit.com:7133/api/SabaClub'
	SET @RefKey = N'123licensee1%^&sit'
	SET @Note = N'9jg479kb7v9kjv0g'
END

EXEC [dbo].[BA_OperatorGameSetting_Ins] 
	  @OperatorId = 1, @VendorId = 42
	, @SettingType = N'OperatorEndPoint', @ValidatePwd = NULL, @ValidateKey = NULL
	, @Url = @OwCoreURL
	, @OtherInfo = NULL, @SubOperatorId = 0

EXEC [dbo].[BA_OperatorGameSetting_Ins] 
	  @OperatorId = 1, @VendorId = 42
	, @SettingType = N'VendorEndPoint_General'
	, @ValidatePwd = NULL, @ValidateKey = NULL
	, @Url = @VendorGeneralURL
	, @OtherInfo = NULL, @SubOperatorId = 0

EXEC [dbo].[BA_OperatorGameSetting_Ins] 
	  @OperatorId = 1, @VendorId = 42
	, @SettingType = N'VendorEndPoint_Result'
	, @ValidatePwd = NULL, @ValidateKey = NULL
	, @Url = @VendorResultURL
	, @OtherInfo = NULL, @SubOperatorId = 0

-- Insert VendorAgentInfo table
EXEC [dbo].[BA_VendorAgentInfo_Ins] 
	  @OperatorId = 1, @VendorId = 42, @VendorAgentId = N''
	, @VendorAgentKey = N'', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA'
	, @RefName = N'ONEworks1',@RefKey = @RefKey
	, @RefCode = N'',@Note = @Note
GO

-- Insert GameVendorInfo table
EXEC [dbo].[BA_GameVendorInfo_Ins] @VendorId = 42, @VendorName = N'SabaClub', @GameType = N'SabaClub'

DECLARE @OperatorProductSettingId int, @ErrCode int, @ErrMsg varchar(100) 
EXEC [dbo].[AP_BO_OperatorProductSetting_Ins] 
	  @OperatorInfoId = 1, @OperatorId = 1, @SubOperatorId = 0
	, @VendorId = 42, @FirstBillingDate = NULL, @BasisOfBilling = NULL
	, @ChargeTypeId = 1, @ChargeOnId = 1, @FromDate = N'2024-10-23'
	, @ToDate = N'2050-12-31', @OperatorProductSettingId = @OperatorProductSettingId OUTPUT
	, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT

DECLARE @OperatorPositionTakingId int, @ErrCode2 int, @ErrMsg2 varchar(100) 
EXEC [dbo].[AP_BO_OperatorPositionTaking_Ins] 
	  @OperatorProductSettingId = @OperatorProductSettingId
	, @CurrencyISO = N'ALL', @PositionTaking = 0, @OperatorPositionTakingId = @OperatorPositionTakingId OUTPUT
	, @ErrCode = @ErrCode2 OUTPUT, @ErrMsg = @ErrMsg2 OUTPUT
GO

-- insert VendorGameList
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1612', @VendorId = 42, @GameId3rd = N'1', @GameName = N'Sicbo', @TypeDesc = N'{"Variation":"ZeroSum"}'
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1613', @VendorId = 42, @GameId3rd = N'2', @GameName = N'XocDia', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1614', @VendorId = 42, @GameId3rd = N'3', @GameName = N'Fish Prawn Crab', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1615', @VendorId = 42, @GameId3rd = N'4', @GameName = N'Big Small Turbo', @TypeDesc = N'{"Variation":"ZeroSum"}'
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1616', @VendorId = 42, @GameId3rd = N'5', @GameName = N'Odd Even', @TypeDesc = N'{"Variation":"ZeroSum"}'
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1617', @VendorId = 42, @GameId3rd = N'6', @GameName = N'Odd Even Turbo', @TypeDesc = N'{"Variation":"ZeroSum"}'
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1618', @VendorId = 42, @GameId3rd = N'7', @GameName = N'Dragon Tiger', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1619', @VendorId = 42, @GameId3rd = N'8', @GameName = N'Keno Pro Max', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1620', @VendorId = 42, @GameId3rd = N'9', @GameName = N'Mini Se Die', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1621', @VendorId = 42, @GameId3rd = N'10', @GameName = N'Baccarat', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1622', @VendorId = 42, @GameId3rd = N'11', @GameName = N'Keno Pro Viet', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1623', @VendorId = 42, @GameId3rd = N'12', @GameName = N'Keno Max', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1624', @VendorId = 42, @GameId3rd = N'13', @GameName = N'Keno Max 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1625', @VendorId = 42, @GameId3rd = N'14', @GameName = N'Keno Mini', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1626', @VendorId = 42, @GameId3rd = N'15', @GameName = N'Keno Mini 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1627', @VendorId = 42, @GameId3rd = N'16', @GameName = N'Keno Spring', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1628', @VendorId = 42, @GameId3rd = N'17', @GameName = N'Keno Summer', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1629', @VendorId = 42, @GameId3rd = N'18', @GameName = N'Keno Autumn', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1630', @VendorId = 42, @GameId3rd = N'19', @GameName = N'Keno Winter', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1631', @VendorId = 42, @GameId3rd = N'20', @GameName = N'Bola Tangkas', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1632', @VendorId = 42, @GameId3rd = N'21', @GameName = N'Roulette', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1633', @VendorId = 42, @GameId3rd = N'22', @GameName = N'VIP Se Die', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1634', @VendorId = 42, @GameId3rd = N'23', @GameName = N'Blackjack', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1635', @VendorId = 42, @GameId3rd = N'24', @GameName = N'Special Se Die', @TypeDesc = N'{"Variation":"ZeroSum"}'
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1636', @VendorId = 42, @GameId3rd = N'25', @GameName = N'Sic Bo', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1637', @VendorId = 42, @GameId3rd = N'26', @GameName = N'VIP Fish Prawn Crab', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1638', @VendorId = 42, @GameId3rd = N'27', @GameName = N'VIP Baccarat', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1639', @VendorId = 42, @GameId3rd = N'28', @GameName = N'VIP Se Die War', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1640', @VendorId = 42, @GameId3rd = N'29', @GameName = N'Four Guardians', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1641', @VendorId = 42, @GameId3rd = N'30', @GameName = N'Fish Prawn Crab PRO', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1642', @VendorId = 42, @GameId3rd = N'31', @GameName = N'RNG Lottery', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1643', @VendorId = 42, @GameId3rd = N'35', @GameName = N'Three Cards', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1644', @VendorId = 42, @GameId3rd = N'38', @GameName = N'The Legend of Heroes', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1645', @VendorId = 42, @GameId3rd = N'36', @GameName = N'Keno Match', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1646', @VendorId = 42, @GameId3rd = N'37', @GameName = N'Keno Match MD5', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1647', @VendorId = 42, @GameId3rd = N'40', @GameName = N'Keno Power', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1648', @VendorId = 42, @GameId3rd = N'41', @GameName = N'Keno Power MD5', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1649', @VendorId = 42, @GameId3rd = N'43', @GameName = N'Bitcoin Master', @TypeDesc = N'{"Variation":"ZeroSum"}'
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1650', @VendorId = 42, @GameId3rd = N'39', @GameName = N'Casino Hold''em Poker', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1651', @VendorId = 42, @GameId3rd = N'45', @GameName = N'Hi-Lo', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1652', @VendorId = 42, @GameId3rd = N'42', @GameName = N'Texas Hold''em Poker', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1653', @VendorId = 42, @GameId3rd = N'46', @GameName = N'Nightclub Lady', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1654', @VendorId = 42, @GameId3rd = N'47', @GameName = N'Treasure Island', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1655', @VendorId = 42, @GameId3rd = N'48', @GameName = N'Blockchain Baccarat', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1656', @VendorId = 42, @GameId3rd = N'49', @GameName = N'Way to Goal', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1657', @VendorId = 42, @GameId3rd = N'52', @GameName = N'Mega Keno', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1658', @VendorId = 42, @GameId3rd = N'53', @GameName = N'Mega Keno 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1659', @VendorId = 42, @GameId3rd = N'50', @GameName = N'Las Vegas', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1660', @VendorId = 42, @GameId3rd = N'51', @GameName = N'Marina Bay', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1661', @VendorId = 42, @GameId3rd = N'54', @GameName = N'Macau', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1662', @VendorId = 42, @GameId3rd = N'55', @GameName = N'Monte Carlo', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1663', @VendorId = 42, @GameId3rd = N'56', @GameName = N'Mini Se Die 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1664', @VendorId = 42, @GameId3rd = N'57', @GameName = N'Mini Se Die 3', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1665', @VendorId = 42, @GameId3rd = N'58', @GameName = N'Mini Se Die 4', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1666', @VendorId = 42, @GameId3rd = N'59', @GameName = N'Fruit Slot', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1667', @VendorId = 42, @GameId3rd = N'60', @GameName = N'Fan Tan', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1668', @VendorId = 42, @GameId3rd = N'61', @GameName = N'Win Three Cards', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1669', @VendorId = 42, @GameId3rd = N'62', @GameName = N'Fortune Cat', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1670', @VendorId = 42, @GameId3rd = N'63', @GameName = N'Happy Ocean', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1671', @VendorId = 42, @GameId3rd = N'64', @GameName = N'Magic Forest', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1672', @VendorId = 42, @GameId3rd = N'65', @GameName = N'DJ Club', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1673', @VendorId = 42, @GameId3rd = N'68', @GameName = N'Mission: Impossible', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1674', @VendorId = 42, @GameId3rd = N'69', @GameName = N'BLACKPINK', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1675', @VendorId = 42, @GameId3rd = N'66', @GameName = N'Candy Land', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1676', @VendorId = 42, @GameId3rd = N'67', @GameName = N'Dragon Tiger Fight', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1677', @VendorId = 42, @GameId3rd = N'70', @GameName = N'Transformers', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1678', @VendorId = 42, @GameId3rd = N'71', @GameName = N'Color Game', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1679', @VendorId = 42, @GameId3rd = N'72', @GameName = N'Pontoon', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1680', @VendorId = 42, @GameId3rd = N'75', @GameName = N'Bandar Qiu Qiu', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1681', @VendorId = 42, @GameId3rd = N'73', @GameName = N'Spaceflight', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1682', @VendorId = 42, @GameId3rd = N'74', @GameName = N'One Piece', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1683', @VendorId = 42, @GameId3rd = N'76', @GameName = N'Dragon Ball', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1684', @VendorId = 42, @GameId3rd = N'77', @GameName = N'Chinese Blackjack', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1685', @VendorId = 42, @GameId3rd = N'78', @GameName = N'Football Dice', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1686', @VendorId = 42, @GameId3rd = N'79', @GameName = N'Football Slot', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1687', @VendorId = 42, @GameId3rd = N'80', @GameName = N'Coin Toss', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1688', @VendorId = 42, @GameId3rd = N'93', @GameName = N'Euro 2024 RNG', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1689', @VendorId = 42, @GameId3rd = N'81', @GameName = N'Lucky BaccaratX', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1690', @VendorId = 42, @GameId3rd = N'95', @GameName = N'Se Die 3X', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1691', @VendorId = 42, @GameId3rd = N'96', @GameName = N'Kara Krus', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1692', @VendorId = 42, @GameId3rd = N'94', @GameName = N'Pusoy', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1693', @VendorId = 42, @GameId3rd = N'82', @GameName = N'Lucky Baccarat 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1694', @VendorId = 42, @GameId3rd = N'83', @GameName = N'Lucky Baccarat 3', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1695', @VendorId = 42, @GameId3rd = N'84', @GameName = N'Baccarat 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1696', @VendorId = 42, @GameId3rd = N'85', @GameName = N'Baccarat 3', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'1697', @VendorId = 42, @GameId3rd = N'86', @GameName = N'Baccarat 4', @TypeDesc = N''
--------------------------------------
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13200', @VendorId = 42, @GameId3rd = N'87', @GameName = N'Baccarat 5', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13201', @VendorId = 42, @GameId3rd = N'88', @GameName = N'Lucky Baccarat 4', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13202', @VendorId = 42, @GameId3rd = N'89', @GameName = N'Lucky Baccarat 5', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13203', @VendorId = 42, @GameId3rd = N'90', @GameName = N'Baccarat 6', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13204', @VendorId = 42, @GameId3rd = N'91', @GameName = N'Baccarat 7', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13205', @VendorId = 42, @GameId3rd = N'92', @GameName = N'Baccarat 8', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13206', @VendorId = 42, @GameId3rd = N'97', @GameName = N'Baccarat 9', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13207', @VendorId = 42, @GameId3rd = N'98', @GameName = N'Speed Baccarat', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13208', @VendorId = 42, @GameId3rd = N'100', @GameName = N'Speed Baccarat 2', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13209', @VendorId = 42, @GameId3rd = N'101', @GameName = N'Speed Baccarat 3', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13210', @VendorId = 42, @GameId3rd = N'102', @GameName = N'BaccaratX', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13211', @VendorId = 42, @GameId3rd = N'103', @GameName = N'7 Up 7 Down', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13212', @VendorId = 42, @GameId3rd = N'106', @GameName = N'Christmas X', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13213', @VendorId = 42, @GameId3rd = N'104', @GameName = N'Spinner Soccer', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13214', @VendorId = 42, @GameId3rd = N'107', @GameName = N'Tap Fortune', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13215', @VendorId = 42, @GameId3rd = N'109', @GameName = N'Crypto Mining', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13216', @VendorId = 42, @GameId3rd = N'113', @GameName = N'Rocket X', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13217', @VendorId = 42, @GameId3rd = N'114', @GameName = N'Spinner Soccer X', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13218', @VendorId = 42, @GameId3rd = N'117', @GameName = N'God Of Fortune', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13219', @VendorId = 42, @GameId3rd = N'115', @GameName = N'Solo Blackjack', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13220', @VendorId = 42, @GameId3rd = N'116', @GameName = N'Solo Pontoon', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13221', @VendorId = 42, @GameId3rd = N'118', @GameName = N'RNG Soccer', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13222', @VendorId = 42, @GameId3rd = N'119', @GameName = N'RNG Basketball', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13223', @VendorId = 42, @GameId3rd = N'133', @GameName = N'Temple Of Cai Shen', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13224', @VendorId = 42, @GameId3rd = N'121', @GameName = N'Wukong''s Revenge', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13225', @VendorId = 42, @GameId3rd = N'123', @GameName = N'Ramses'' Lost Tomb', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13226', @VendorId = 42, @GameId3rd = N'125', @GameName = N'One Day In Paradise', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13227', @VendorId = 42, @GameId3rd = N'124', @GameName = N'Ne Zha''s Rebellion', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13228', @VendorId = 42, @GameId3rd = N'122', @GameName = N'Summer Heat', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13229', @VendorId = 42, @GameId3rd = N'126', @GameName = N'Poseidon''s Realm', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13230', @VendorId = 42, @GameId3rd = N'130', @GameName = N'Aladdin''s Wishes', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13231', @VendorId = 42, @GameId3rd = N'134', @GameName = N'Mini Roulette', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13232', @VendorId = 42, @GameId3rd = N'129', @GameName = N'Wild West Most Wanted', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13233', @VendorId = 42, @GameId3rd = N'131', @GameName = N'Happy Farm', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13234', @VendorId = 42, @GameId3rd = N'127', @GameName = N'Mahjong Wins', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13235', @VendorId = 42, @GameId3rd = N'132', @GameName = N'Fruit Samurai', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13236', @VendorId = 42, @GameId3rd = N'128', @GameName = N'Aztec Princess', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13237', @VendorId = 42, @GameId3rd = N'139', @GameName = N'Olympub', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13238', @VendorId = 42, @GameId3rd = N'140', @GameName = N'Viva Fiesta', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13239', @VendorId = 42, @GameId3rd = N'141', @GameName = N'Big Bass Fishing', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13240', @VendorId = 42, @GameId3rd = N'142', @GameName = N'Street Warrior', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13241', @VendorId = 42, @GameId3rd = N'143', @GameName = N'Lucky Neko', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13242', @VendorId = 42, @GameId3rd = N'146', @GameName = N'Totem Rush', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13243', @VendorId = 42, @GameId3rd = N'155', @GameName = N'Queen Of Bounty', @TypeDesc = N''
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13244', @VendorId = 42, @GameId3rd = N'154', @GameName = N'Monster Munchies', @TypeDesc = N''
-------------------------
EXEC [dbo].[BA_VendorGameList_Ins] @GameId = N'13245', @VendorId = 42, @GameId3rd = N'156', @GameName = N'Soccer PinGoal', @TypeDesc = N''
GO
/*
SELECT 1 FROM GameVendorInfo WITH(NOLOCK) WHERE vendorid = 42
SELECT 1 FROM OperatorProductSetting WITH(NOLOCK) WHERE vendorid = 42
SELECT 1 
FROM OperatorPositionTaking WITH(NOLOCK) 
WHERE OperatorProductSettingId IN ( 
									SELECT OperatorProductSettingId 
									FROM OperatorProductSetting WITH(NOLOCK) 
									WHERE vendorid = 42) 

SELECT 1 FROM VendorAgentInfo WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1
SELECT 1 FROM OperatorGameSetting WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1
SELECT 1 FROM VendorGameList WITH(NOLOCK) WHERE vendorid = 42
/*
--CLEAN DATA : 
DELETE FROM GameVendorInfo WITH(ROWLOCK) WHERE vendorid = 42

DELETE FROM OperatorPositionTaking WITH(ROWLOCK) 
	   WHERE OperatorProductSettingId IN ( 
											SELECT OperatorProductSettingId 
											FROM OperatorProductSetting WITH(NOLOCK) 
											WHERE vendorid = 42) 

DELETE FROM OperatorProductSetting WITH(ROWLOCK) WHERE vendorid = 42

DELETE FROM VendorAgentInfo WITH(ROWLOCK) WHERE vendorid = 42 AND OperatorId = 1

DELETE FROM OperatorGameSetting WITH(ROWLOCK) WHERE vendorid = 42 AND OperatorId = 1

DELETE FROM VendorGameList WITH(ROWLOCK) WHERE vendorid = 42
*/