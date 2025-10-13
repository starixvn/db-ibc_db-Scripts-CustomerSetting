/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Clean config for SABA.GAMES on SABAPLAY - redudant data[#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
--OperatorGameSetting
EXEC [dbo].[BA_OperatorGameSetting_Del] @OperatorId = 1,@SubOperatorID = 0, @VendorId = 42, @SettingType = N'OperatorEndPoint'
EXEC [dbo].[BA_OperatorGameSetting_Del] @OperatorId = 1,@SubOperatorID = 0, @VendorId = 42, @SettingType = N'VendorEndPoint_General'
EXEC [dbo].[BA_OperatorGameSetting_Del] @OperatorId = 1,@SubOperatorID = 0, @VendorId = 42, @SettingType = N'VendorEndPoint_Result'
GO

--VendorAgentInfo
EXEC [dbo].[BA_VendorAgentInfo_Del] @OperatorId = 1, @VendorId = 42, @VendorAgentId = N'', @VendorAgentKey = N'', @VendorAgentCode = N'Credit'
GO

--GameVendorInfo
EXEC [dbo].[BA_GameVendorInfo_Del] @VendorId = 42

--OperatorProductSetting
DECLARE  @ErrCode int, @ErrMsg varchar(100)
EXEC [dbo].[AP_BO_OperatorProductSetting_Del] 
	  @OperatorProductSettingId = 507
	, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
SELECT @ErrCode, @ErrMsg
GO

--OperatorPositionTaking
DECLARE  @ErrCode int, @ErrMsg varchar(100)
EXEC [dbo].[AP_BO_OperatorPositionTaking_Del] 
  @OperatorPositionTakingId = 548
, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
GO

--VendorGameList
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13200'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13201'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13202'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13203'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13204'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13205'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13206'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13207'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13208'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13209'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13210'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13211'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13212'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13213'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13214'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13215'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13216'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13217'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13218'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13219'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13220'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13221'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13222'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13223'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13224'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13225'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13226'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13227'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13228'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13229'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13230'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13231'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13232'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13233'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13234'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13235'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13236'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13237'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13238'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13239'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13240'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13241'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13242'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13243'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13244'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'13245'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1612'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1613'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1614'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1615'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1616'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1617'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1618'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1619'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1620'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1621'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1622'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1623'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1624'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1625'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1626'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1627'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1628'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1629'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1630'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1631'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1632'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1633'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1634'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1635'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1636'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1637'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1638'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1639'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1640'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1641'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1642'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1643'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1644'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1645'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1646'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1647'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1648'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1649'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1650'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1651'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1652'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1653'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1654'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1655'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1656'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1657'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1658'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1659'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1660'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1661'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1662'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1663'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1664'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1665'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1666'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1667'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1668'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1669'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1670'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1671'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1672'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1673'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1674'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1675'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1676'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1677'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1678'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1679'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1680'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1681'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1682'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1683'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1684'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1685'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1686'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1687'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1688'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1689'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1690'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1691'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1692'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1693'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1694'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1695'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1696'
EXEC [dbo].[BA_VendorGameList_Del] @GameId = N'1697'
