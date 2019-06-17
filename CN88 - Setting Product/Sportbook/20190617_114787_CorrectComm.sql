/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Update comm 
*/
USE CustDB
GO

SELECT t.* INTO #SportBettypeFilter2
FROM dbo.f_CS_SportBetTypeSettingSelect(1, 2, 0) t	

DECLARE @GroupASuperDiscount_XML XML, @GroupBSuperDiscount_XML XML, @GroupCSuperDiscount_XML XML, @GroupDSuperDiscount_XML XML
DECLARE @GroupAMasterDiscount_XML XML, @GroupBMasterDiscount_XML XML, @GroupCMasterDiscount_XML XML, @GroupDMasterDiscount_XML XML
DECLARE @GroupAAgentDiscount_XML XML, @GroupBAgentDiscount_XML XML, @GroupCAgentDiscount_XML XML, @GroupDAgentDiscount_XML XML

CREATE TABLE #SuperList (CustId INT)
CREATE TABLE #MasterList (CustId INT, srecommend INT)
CREATE TABLE #AgentList (CustId INT, srecommend INT, mrecommend INT)
CREATE TABLE #MemberList (CustId INT, srecommend INT, mrecommend INT, recommend INT, ugroup VARCHAR(3))
CREATE TABLE #MemberGroupList (CustId INT, srecommend INT, mrecommend INT, recommend INT, ugroup VARCHAR(3))
CREATE TABLE #WrongList(custid INT, roleid TINYINT, RuleID TINYINT)

INSERT INTO #SuperList (CustId)
SELECT DISTINCT c.srecommend
FROM dbo.vw_customer c WITH (NOLOCK)
WHERE c.roleid = 2 AND c.site = 'CN88' 
	AND c.custid IN (35555535,35556895,35557578,35577336,35592307,35604829,35619371,35647982,35652895,35653247,35683456,35683468,35684892,35684995,35685151,35685152,
	35685162,35686788,35686817,35687680,35689076,35705826,35706345,35707871,35708104,35709885,35709955,35709995,35711346,35721695,35721702,35721734,
	35721816,35721886,35722072,35722457,35722803,35724788,35726699,35738837,35741976,35742111,35742126,35742150,35742176,35742991,35743882,35808901,
	35808920,35816195,35834616,35852135,35852151,35900089,35918845,35919012,35919144,35920202,35937864,35938348,35938475,35940655,35940750,35940852,
	35940946,35950347,35961055,35970122,35970801,35970956,35971773,35977593,36004637,36018368,36020546,36035862,36063980,36065522,36067023,36067041,
	36080455,36084178,36084883,36088392,36119161,36176038,36222911,36470526,36471037,36540899,36569181,36593750,36648509,36649049,36651418,
	36678456,36716092,36716783,36732589,36751271,36791627)

INSERT INTO #MasterList (CustId, srecommend)
SELECT DISTINCT c.mrecommend, srecommend
FROM dbo.vw_customer c WITH (NOLOCK)
WHERE c.roleid = 2 AND c.site = 'CN88'
	AND c.custid IN (35555535,35556895,35557578,35577336,35592307,35604829,35619371,35647982,35652895,35653247,35683456,35683468,35684892,35684995,35685151,35685152,
	35685162,35686788,35686817,35687680,35689076,35705826,35706345,35707871,35708104,35709885,35709955,35709995,35711346,35721695,35721702,35721734,
	35721816,35721886,35722072,35722457,35722803,35724788,35726699,35738837,35741976,35742111,35742126,35742150,35742176,35742991,35743882,35808901,
	35808920,35816195,35834616,35852135,35852151,35900089,35918845,35919012,35919144,35920202,35937864,35938348,35938475,35940655,35940750,35940852,
	35940946,35950347,35961055,35970122,35970801,35970956,35971773,35977593,36004637,36018368,36020546,36035862,36063980,36065522,36067023,36067041,
	36080455,36084178,36084883,36088392,36119161,36176038,36222911,36470526,36471037,36540899,36569181,36593750,36648509,36649049,36651418,
	36678456,36716092,36716783,36732589,36751271,36791627)

INSERT INTO #AgentList (CustId, srecommend, mrecommend)
SELECT c.custid, srecommend, mrecommend
FROM dbo.vw_customer c WITH (NOLOCK)
WHERE c.roleid = 2 AND c.site = 'CN88'
	AND c.custid IN (35555535,35556895,35557578,35577336,35592307,35604829,35619371,35647982,35652895,35653247,35683456,35683468,35684892,35684995,35685151,35685152,
	35685162,35686788,35686817,35687680,35689076,35705826,35706345,35707871,35708104,35709885,35709955,35709995,35711346,35721695,35721702,35721734,
	35721816,35721886,35722072,35722457,35722803,35724788,35726699,35738837,35741976,35742111,35742126,35742150,35742176,35742991,35743882,35808901,
	35808920,35816195,35834616,35852135,35852151,35900089,35918845,35919012,35919144,35920202,35937864,35938348,35938475,35940655,35940750,35940852,
	35940946,35950347,35961055,35970122,35970801,35970956,35971773,35977593,36004637,36018368,36020546,36035862,36063980,36065522,36067023,36067041,
	36080455,36084178,36084883,36088392,36119161,36176038,36222911,36470526,36471037,36540899,36569181,36593750,36648509,36649049,36651418,
	36678456,36716092,36716783,36732589,36751271,36791627)

INSERT INTO #MemberList (CustId, srecommend, mrecommend, recommend, ugroup)
SELECT c.custid, srecommend, mrecommend, recommend, c.ugroup
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.CS_CustSettingMode cm WITH (NOLOCK) ON c.custid = cm.CustId
WHERE c.roleid = 1 AND c.site = 'CN88' AND cm.IsGroupComm = 0
	AND c.recommend IN (35555535,35556895,35557578,35577336,35592307,35604829,35619371,35647982,35652895,35653247,35683456,35683468,35684892,35684995,35685151,35685152,
	35685162,35686788,35686817,35687680,35689076,35705826,35706345,35707871,35708104,35709885,35709955,35709995,35711346,35721695,35721702,35721734,
	35721816,35721886,35722072,35722457,35722803,35724788,35726699,35738837,35741976,35742111,35742126,35742150,35742176,35742991,35743882,35808901,
	35808920,35816195,35834616,35852135,35852151,35900089,35918845,35919012,35919144,35920202,35937864,35938348,35938475,35940655,35940750,35940852,
	35940946,35950347,35961055,35970122,35970801,35970956,35971773,35977593,36004637,36018368,36020546,36035862,36063980,36065522,36067023,36067041,
	36080455,36084178,36084883,36088392,36119161,36176038,36222911,36470526,36471037,36540899,36569181,36593750,36648509,36649049,36651418,
	36678456,36716092,36716783,36732589,36751271,36791627)

SELECT ci.custid, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount, mc.ValueId
INTO #SuperComm
FROM #SuperList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SELECT ci.custid, ci.srecommend, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount, mc.ValueId
INTO #MasterComm
FROM #MasterList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SELECT ci.custid, ci.srecommend, ci.mrecommend, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount, mc.ValueId
INTO #AgentComm
FROM #AgentList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SET @GroupASuperDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #SuperComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'A' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)	
								
SET @GroupBSuperDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #SuperComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'B' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)			
		
SET @GroupCSuperDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #SuperComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'C' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)		
SET @GroupDSuperDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #SuperComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'D' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)	

SET @GroupAMasterDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #MasterComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'A' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)	
								
SET @GroupBMasterDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #MasterComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'B' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)			
		
SET @GroupCMasterDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #MasterComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'C' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)		
SET @GroupDMasterDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #MasterComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'D' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)	

SET @GroupAAgentDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #AgentComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'A' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)	
								
SET @GroupBAgentDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #AgentComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'B' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)			
		
SET @GroupCAgentDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #AgentComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'C' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)		
SET @GroupDAgentDiscount_XML =(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										comm.ValueId	AS '@val'
								FROM #AgentComm comm
									INNER JOIN dbo.CS_ByteSeq bs WITH (NOLOCK) ON bs.SportType = comm.SportType AND bs.BetType = comm.BetType AND bs.IsLive = comm.IsLive
									LEFT JOIN dbo.CS_GroupConfig gc WITH (NOLOCK) ON gc.SportType = comm.SportType AND gc.BetType = comm.BetType AND gc.IsLive = comm.IsLive AND gc.GroupId = comm.GroupId
								WHERE bs.Type = 'DiscountMember'
									AND (gc.GroupName = 'D' OR gc.GroupId IS NULL)
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)	
UPDATE cm
SET cm.SuperDiscount = scomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN customer c WITH (NOLOCK) ON c.custid = cm.AgentId
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @GroupASuperDiscount_XML) scomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @GroupAMasterDiscount_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @GroupAAgentDiscount_XML) acomm		
WHERE c.custid IN (SELECT custid FROM #AgentList) AND cm.uGroup = 'A' AND c.roleid = 2

UPDATE cm
SET cm.SuperDiscount = scomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN customer c WITH (NOLOCK) ON c.custid = cm.AgentId
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @GroupBSuperDiscount_XML) scomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @GroupBMasterDiscount_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @GroupBAgentDiscount_XML) acomm	
WHERE c.custid IN (SELECT custid FROM #AgentList) AND cm.uGroup = 'B' AND c.roleid = 2

UPDATE cm
SET cm.SuperDiscount = scomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN customer c WITH (NOLOCK) ON c.custid = cm.AgentId
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @GroupCSuperDiscount_XML) scomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @GroupCMasterDiscount_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @GroupCAgentDiscount_XML) acomm	
WHERE c.custid IN (SELECT custid FROM #AgentList) AND cm.uGroup = 'C' AND c.roleid = 2

UPDATE cm
SET cm.SuperDiscount = scomm.binaryStr_new,
	cm.MasterDiscount = mcomm.binaryStr_new,
	cm.AgentDiscount = acomm.binaryStr_new
FROM dbo.CS_CustGroupDiscount_Member cm WITH (ROWLOCK)
	INNER JOIN customer c WITH (NOLOCK) ON c.custid = cm.AgentId
	CROSS APPLY dbo.f_SetBinaryValues(cm.SuperDiscount, @GroupDSuperDiscount_XML) scomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.MasterDiscount, @GroupDMasterDiscount_XML) mcomm	
	CROSS APPLY dbo.f_SetBinaryValues(cm.AgentDiscount, @GroupDAgentDiscount_XML) acomm	
WHERE c.custid IN (SELECT custid FROM #AgentList) AND cm.uGroup = 'D' AND c.roleid = 2

UPDATE cs 
SET cs.IsGroupComm = 1
FROM dbo.CS_CustSettingMode cs WITH (ROWLOCK)
	INNER JOIN #MemberList memc WITH (NOLOCK) ON memc.CustId = cs.CustId
	
DELETE cs 
FROM dbo.CS_CustDiscount_Member cs WITH (ROWLOCK)
	INNER JOIN #MemberList ci WITH (NOLOCK) ON ci.custid = cs.CustId
