/*<info serverAlias="DBSabaPlay-WalletBridgeDB"></info>*/ 
/*
	Created: Helios@20251008
	Task: Check data Consistency from SiteDb03 with WalletBridgeDB - CHECK BEFORE UM [#239774]
	DB: DBSabaPlay-WalletBridgeDB
*/

DECLARE
     
      @Timestamp				TIMESTAMP   = xxxx -- Max Timestamp from script : 1_GetData_BeforeUM_GetMaxTimestamp_SabaDB

	SET NOCOUNT ON

	-- Get ticket running matching with SiteDB 
	SELECT 
		CASE 
			WHEN t.TicketStatus = 0 THEN 'running'
			WHEN t.TicketStatus = 1 THEN 'WON'
			WHEN t.TicketStatus = 2 THEN 'LOSE'
			WHEN t.TicketStatus = 3 THEN 'DRAW'
			WHEN t.TicketStatus = 4 THEN 'VOID'
			WHEN t.TicketStatus = 5 THEN 'Reject'
			WHEN t.TicketStatus = 6 THEN 'Refund'
		END AS Status , 
		TicketId,
		GameId,
		VendorId,
		OperatorId,
		SubOperatorId,
		OperatorCustId,
		GsGameRoundId,
		GsTransId,
		TransDate,
		SettleDate,
		Stake,
		ActualStake,
		NetStake,
		Winlose,
		TicketStatus,
		Platform,
		CurrencyISO,
		IpAddress,
		TransDesc,
		ExtraInfo,
		Odds,
		VendorAgentSeq,
		PositionTaking,
		TicketNo,
		Timestamp,
		ActualRate,
		OperatorCustName,
		ReportDate,
		Contribution,
		WalletType,
		Balance 
	FROM	dbo.Tickets t WITH (NOLOCK)
	WHERE t.Timestamp >= @Timestamp
	-- SABA.games
	AND t.GameId IN (
				'1600','1601','1602','1603','1604','1605','1606','1607','1608','1609',
				'1610','1611','1612','1613','1614','1615','1616','1617','1618','1619',
				'1620','1621','1622','1623','1624','1625','1626','1627','1628','1629',
				'1630','1631','1632','1633','1634','1635','1636','1637','1638','1639',
				'1640','1641','1642','1643','1644','1645','1646','1647','1648','1649',
				'1650','1651','1652','1653','1654','1655','1656','1657','1658','1659',
				'1660','1661','1662','1663','1664','1665','1666','1667','1668','1669',
				'1670','1671','1672','1673','1674','1675','1676','1677','1678','1679',
				'1680','1681','1682','1683','1684','1685','1686','1687','1688','1689',
				'1690','1691','1692','1693','1694','1695','1696','1697','1698','1699',
				'13200','13201','13202','13203','13204','13205','13206','13207','13208','13209',
				'13210','13211','13212','13213','13214','13215','13216','13217','13218','13219',
				'13220','13221','13222','13223','13224','13225','13226','13227','13228','13229',
				'13230','13231','13232','13233','13234','13235','13236','13237','13238','13239',
				'13240','13241','13242','13243','13244','13245','13246','13247','13248','13249',
				'13250','13251','13252','13253','13254','13255','13256','13257','13258','13259',
				'13260','13261','13262','13263','13264','13265','13266','13267','13268','13269',
				'13270','13271','13272','13273','13274','13275','13276','13277','13278','13279',
				'13280','13281','13282','13283','13284','13285','13286','13287','13288','13289',
				'13290','13291','13292','13293','13294','13295','13296','13297','13298','13299'
			)
