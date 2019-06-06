/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Update comm 
*/
USE CustDB
GO

SELECT t.* INTO #SportBettypeFilter2
FROM dbo.f_CS_SportBetTypeSettingSelect(1, 2, 0) t	

DECLARE @CommSetting_Super VARCHAR(MAX), @CommSetting_MA VARCHAR(MAX), @CommSetting_Member VARCHAR(MAX), @DiscountSuper_XML XML, @DiscountMA_XML XML, @DiscountMember_XML XML

SELECT @CommSetting_Super='<ROOT><Comm SportType="1" BetType="1" IsLive="0" GroupId="1" ValueId="46"/>
								<Comm SportType="1" BetType="1" IsLive="0" GroupId="2" ValueId="26"/>
								<Comm SportType="1" BetType="1" IsLive="0" GroupId="3" ValueId="16"/>
								<Comm SportType="1" BetType="1" IsLive="0" GroupId="4" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="5" ValueId="46"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="6" ValueId="26"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="7" ValueId="16"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="8" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="9" ValueId="46"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="10" ValueId="26"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="11" ValueId="16"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="12" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="13" ValueId="46"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="14" ValueId="26"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="15" ValueId="16"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="16" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="17" ValueId="46"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="18" ValueId="26"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="19" ValueId="16"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="20" ValueId="1"/>
								<Comm SportType="9999" BetType="10" IsLive="0" GroupId="0" ValueId="1"/></ROOT>'

SELECT @CommSetting_MA='<ROOT><Comm SportType="1" BetType="1" IsLive="0" GroupId="1" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="0" GroupId="2" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="0" GroupId="3" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="0" GroupId="4" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="5" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="6" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="7" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" GroupId="8" ValueId="1"/>
								<Comm SportType="1" BetType="5" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="1" BetType="9999" IsLive="1" GroupId="0" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="9" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="10" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="11" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" GroupId="12" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="13" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="14" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="15" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" GroupId="16" ValueId="1"/>
								<Comm SportType="2" BetType="20" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="2" BetType="9999" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="17" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="18" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="19" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" GroupId="20" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" GroupId="21" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" GroupId="22" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" GroupId="23" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" GroupId="24" ValueId="1"/>
								<Comm SportType="99" BetType="5" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="99" BetType="9999" IsLive="0" GroupId="0" ValueId="1"/>
								<Comm SportType="9999" BetType="10" IsLive="0" GroupId="0" ValueId="1"/></ROOT>'

SELECT @CommSetting_Member='<ROOT><Comm SportType="1" BetType="1" IsLive="0" ValueId="1"/>
								<Comm SportType="1" BetType="1" IsLive="1" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="0" ValueId="1"/>
								<Comm SportType="2" BetType="1" IsLive="1" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="0" ValueId="1"/>
								<Comm SportType="99" BetType="1" IsLive="1" ValueId="1"/></ROOT>'

SELECT cm.* INTO #CommSuper_tmp
FROM dbo.f_CS_CommParse(@CommSetting_Super) cm
	INNER JOIN #SportBettypeFilter2 ft ON cm.SportType = ft.SportType AND cm.BetType = ft.BetType AND cm.IsLive = ft.IsLive	

SELECT cm.* INTO #CommMA_tmp
FROM dbo.f_CS_CommParse(@CommSetting_MA) cm
	INNER JOIN #SportBettypeFilter2 ft ON cm.SportType = ft.SportType AND cm.BetType = ft.BetType AND cm.IsLive = ft.IsLive	

SELECT cm.* INTO #CommMember_tmp
FROM dbo.f_CS_CommParse(@CommSetting_Member) cm
	INNER JOIN #SportBettypeFilter2 ft ON cm.SportType = ft.SportType AND cm.BetType = ft.BetType AND cm.IsLive = ft.IsLive	

SET @DiscountSuper_XML =(
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									comm.ValueId	AS '@val'
							FROM #CommSuper_tmp comm
								INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive AND bs.GroupId = comm.GroupId
							WHERE bs.Type = 'DiscountAgent'
							FOR XML PATH('r')
								, TYPE
							)
					FOR XML PATH('root')
						, TYPE
					)		

SET @DiscountMA_XML =(
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									comm.ValueId	AS '@val'
							FROM #CommMA_tmp comm
								INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive AND bs.GroupId = comm.GroupId
							WHERE bs.Type = 'DiscountAgent'
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

CREATE TABLE #SuperList (ID INT IDENTITY(1,1), CustId INT)
CREATE TABLE #MAList (ID INT IDENTITY(1,1), CustId INT)
CREATE TABLE #MemberList (ID INT IDENTITY(1,1), CustId INT)

--118 affected rows
INSERT INTO #SuperList (CustId)
SELECT c.custid
FROM dbo.customer c WITH (NOLOCK)
WHERE c.roleid = 4 AND c.site = 'CN88' 

INSERT INTO #MAList (CustId)
SELECT c.custid
FROM dbo.customer c WITH (NOLOCK)
WHERE c.roleid IN(3,2) AND c.site = 'CN88'

INSERT INTO #MemberList (CustId)
SELECT c.custid
FROM dbo.customer c WITH (NOLOCK)
	INNER JOIN #MAList a ON c.recommend = a.CustId
WHERE c.roleid = 1

UPDATE ca
SET ca.Discount = comm.binaryStr_new
FROM dbo.CS_CustDiscount_Agent ca WITH (ROWLOCK)
	INNER JOIN #SuperList s ON ca.CustId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(ca.Discount, @DiscountSuper_XML) comm	

UPDATE ca
SET ca.Discount = comm.binaryStr_new
FROM dbo.CS_CustDiscount_Agent ca WITH (ROWLOCK)
	INNER JOIN #MAList s ON ca.CustId = s.custid
	CROSS APPLY dbo.f_SetBinaryValues(ca.Discount, @DiscountMA_XML) comm	

UPDATE cm
SET cm.PlayerDiscount = playercomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	CROSS APPLY dbo.f_SetBinaryValues(cm.PlayerDiscount, @DiscountMember_XML) playercomm	

DELETE FROM dbo.CS_CustDiscount_Member 

UPDATE cm
SET cm.IsGroupComm = 1
FROM dbo.CS_CustSettingMode cm WITH (ROWLOCK)

DROP TABLE #SuperList
DROP TABLE #CommSuper_tmp
DROP TABLE #CommMA_tmp
DROP TABLE #CommMember_tmp
