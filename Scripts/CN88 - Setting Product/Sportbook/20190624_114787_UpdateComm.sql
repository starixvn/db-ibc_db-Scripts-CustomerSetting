/*
	Created: 20190624@Elodie
	DB: DBCUST/CustDB
	Task: Update comm 
*/
USE CustDB
GO

SELECT t.* INTO #SportBettypeFilter2
FROM dbo.f_CS_SportBetTypeSettingSelect(1, 2, 0) t	

DECLARE @CommSetting_SMA VARCHAR(MAX), @CommSettingD_Member VARCHAR(MAX), @CommSetting_Member VARCHAR(MAX), 
		@DiscountSMA_XML XML, @DiscountMember_XML XML, @DiscountGroupDMember_XML XML

SELECT @CommSetting_SMA='<ROOT><Comm SportType="1" BetType="1" IsLive="0" GroupId="4" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="8" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="12" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="16" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="20" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" GroupId="24" ValueId="1"/>
								<Comm SportType="1" BetType="5" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="1" GroupId="0" ValueId="1"/>
								<Comm SportType="2" BetType="20" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="2" BetType="9999" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="99" BetType="5" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="99" BetType="9999" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="9999" BetType="10" IsLive="0" GroupId="0" ValueId="1"/></ROOT>'

SELECT @CommSetting_Member='<ROOT><Comm SportType="1" BetType="5" IsLive="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="1" ValueId="1"/>
								<Comm SportType="2" BetType="20" IsLive="0" ValueId="1"/>
								<Comm SportType="2" BetType="9999" IsLive="0" ValueId="1"/>
								<Comm SportType="99" BetType="5" IsLive="0" ValueId="1"/>
								<Comm SportType="99" BetType="9999" IsLive="0" ValueId="1"/>
								<Comm SportType="9999" BetType="10" IsLive="0" ValueId="1"/></ROOT>'

SELECT @CommSettingD_Member='<ROOT><Comm SportType="1" BetType="1" IsLive="0" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" ValueId="1"/>
								<Comm SportType="1" BetType="5" IsLive="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="1" ValueId="1"/>
								<Comm SportType="2" BetType="20" IsLive="0" ValueId="1"/>
								<Comm SportType="2" BetType="9999" IsLive="0" ValueId="1"/>
								<Comm SportType="99" BetType="5" IsLive="0" ValueId="1"/>
								<Comm SportType="99" BetType="9999" IsLive="0" ValueId="1"/>
								<Comm SportType="9999" BetType="10" IsLive="0" ValueId="1"/></ROOT>'


SELECT cm.* INTO #CommSMA_tmp
FROM dbo.f_CS_CommParse(@CommSetting_SMA) cm
	INNER JOIN #SportBettypeFilter2 ft ON cm.SportType = ft.SportType AND cm.BetType = ft.BetType AND cm.IsLive = ft.IsLive	

SELECT cm.* INTO #CommMember_tmp
FROM dbo.f_CS_CommParse(@CommSetting_Member) cm
	INNER JOIN #SportBettypeFilter2 ft ON cm.SportType = ft.SportType AND cm.BetType = ft.BetType AND cm.IsLive = ft.IsLive	

SELECT cm.* INTO #CommDMember_tmp
FROM dbo.f_CS_CommParse(@CommSettingD_Member) cm
	INNER JOIN #SportBettypeFilter2 ft ON cm.SportType = ft.SportType AND cm.BetType = ft.BetType AND cm.IsLive = ft.IsLive	

SET @DiscountSMA_XML =(
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									comm.ValueId	AS '@val'
							FROM #CommSMA_tmp comm
								INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive AND bs.GroupId = comm.GroupId
							WHERE bs.Type = 'DiscountAgent'
							FOR XML PATH('r')
								, TYPE
							)
					FOR XML PATH('root')
						, TYPE
					)		

SET @DiscountGroupDMember_XML =(
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											comm.ValueId	AS '@val'
									FROM #CommDMember_tmp comm
										INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									WHERE bs.Type = 'DiscountMember'
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)


SET @DiscountMember_XML =(
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											comm.ValueId	AS '@val'
									FROM #CommMember_tmp comm
										INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									WHERE bs.Type = 'DiscountMember'
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)

CREATE TABLE #SMAList (ID INT IDENTITY(1,1), CustId INT)
CREATE TABLE #MemberList (ID INT IDENTITY(1,1), CustId INT, ugroup VARCHAR(3))

INSERT INTO #SMAList (CustId)
SELECT c.custid
FROM dbo.customer c WITH (NOLOCK)
WHERE c.roleid IN(4,3,2) AND c.site = 'CN88'

INSERT INTO #MemberList (CustId, ugroup)
SELECT c.custid, ugroup
FROM dbo.customer c WITH (NOLOCK)
	INNER JOIN #SMAList a ON c.recommend = a.CustId
WHERE c.roleid = 1

UPDATE ca
SET ca.Discount = comm.binaryStr_new
FROM dbo.CS_CustDiscount_Agent ca WITH (ROWLOCK)
	INNER JOIN #SMAList s ON ca.CustId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(ca.Discount, @DiscountSMA_XML) comm	

UPDATE cm
SET cm.PlayerDiscount = playercomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.SuperDiscount = scomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN #SMAList s ON cm.AgentId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(cm.PlayerDiscount, @DiscountGroupDMember_XML) playercomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @DiscountGroupDMember_XML) acomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @DiscountGroupDMember_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @DiscountGroupDMember_XML) scomm	
WHERE cm.uGroup = 'd'

UPDATE cm
SET cm.PlayerDiscount = playercomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.SuperDiscount = scomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN #SMAList s ON cm.AgentId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(cm.PlayerDiscount, @DiscountMember_XML) playercomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @DiscountMember_XML) acomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @DiscountMember_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @DiscountMember_XML) scomm	
WHERE cm.uGroup <> 'd'

UPDATE cm
SET cm.PlayerDiscount = playercomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.SuperDiscount = scomm.binaryStr_new
FROM dbo.CS_CustDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN #MemberList s ON cm.CustId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(cm.PlayerDiscount, @DiscountGroupDMember_XML) playercomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @DiscountGroupDMember_XML) acomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @DiscountGroupDMember_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @DiscountGroupDMember_XML) scomm	
WHERE s.uGroup = 'd'

UPDATE cm
SET cm.PlayerDiscount = playercomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.SuperDiscount = scomm.binaryStr_new
FROM dbo.CS_CustDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN #MemberList s ON cm.CustId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(cm.PlayerDiscount, @DiscountMember_XML) playercomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @DiscountMember_XML) acomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @DiscountMember_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @DiscountMember_XML) scomm	
WHERE s.uGroup <> 'd'

DROP TABLE #SMAList
DROP TABLE #MemberList
DROP TABLE #CommSMA_tmp
DROP TABLE #CommMember_tmp
