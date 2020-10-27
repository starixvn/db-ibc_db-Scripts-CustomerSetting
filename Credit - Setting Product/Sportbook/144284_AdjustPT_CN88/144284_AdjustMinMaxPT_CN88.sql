/*
	Created by: Winfred
	Date: 20201027
	Task: Update Super Min& Max PT and Headline PT for CN88 [redmine : 144284]
	DB: DBCUST/CustDB

	- Update N4,L4
	- IF S3_old < N4 -  MinM2A2 THEN N4 -  MinM2A2 ELSE S3_old END
*/
USE CustDB
GO

DECLARE @MinPT_New TINYINT = 75,@MaxPT_New TINYINT = 90
DECLARE @MinPT_XML XML,@MaxPT_XML XML

CREATE TABLE #SuperList (CustId INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, L4 TINYINT)
CREATE TABLE #MasterList (CustId INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT,S3 INT, MinM2A2 INT, S3_New INT, SuperPT_XML XML)

INSERT INTO #SuperList (CustId, sporttype, bettype, IsLive, L4)
SELECT c.custid, spt.sporttype, spt.bettype, spt.isLive, spt.MaxPT 
FROM Customer c WITH (NOLOCK) 
	INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = c.custid
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) spt
WHERE c.roleid = 4 AND c.site = 'CN88'
	AND c.currency <> 20
	AND s.IsInternal = 0
	and c.custid in ( 
		35889027, 35889031, 35889032, 35889034, 37435487, 37435509, 37435511, 37435517, 37435519, 37435523, 37435530, 37435532, 37435535, 
		37435540, 37465692, 37465701, 37465762, 37465766, 37465774, 37465781, 37465788, 37465792, 37465799, 37465807, 37477742, 37477743, 
		37477749, 37477963, 37477969, 37477975, 37478659, 37479058, 37479065, 37479076, 37479082, 37479087, 37479094, 37480556, 37480558, 
		37480564, 37480568, 37480576, 37480578, 37480594, 37480600, 37480615, 37480621, 37496659, 37542526, 37542599, 37542659, 37542698, 
		37542743, 37610871, 37614577, 37623612, 37681863, 37718393, 37840083, 37867365, 37921567, 37952976, 38003231, 38013325, 38013335, 
		38014135, 38014145, 38023795, 38056983, 38089933, 38091269, 38091399, 38141155, 38157957, 38157978, 38157997, 38158179, 38160616, 
		38173142, 38230315, 38262537, 38331029, 38354512, 38358343, 38398482, 38408900, 38466134, 38502242, 38533879, 38547487, 38553616, 
		38556665, 38568595, 38591799, 38604756, 38624313, 38628420, 38645612, 38669127, 38674165, 38690081, 38708029, 38708749, 38736168, 
		38801418, 38826558, 39019665, 39053653, 39129192, 39138828, 39143153, 39150209, 39243010, 39265485, 39265547, 39265551, 39265565, 
		39265657, 39265684, 39278793, 39310961, 39339836, 39357747, 39390535, 39394324, 39420049, 39429006, 39454200, 39457178, 39473678, 
		39473701, 39485954, 39497920, 39498325, 39499882, 39500503, 39500578, 39507083, 39516899, 39522291, 39522387, 39522397, 39536584, 
		39538588, 39544392, 39553882, 39557609, 39560241, 39560359, 39560395, 39560426, 39560586, 39560596, 39560607, 39573456, 39592177, 
		39592228, 39595706, 39596417, 39636101, 39645814, 39645878, 39646015, 39646679, 39682847, 39687131, 39689350, 39719028, 39719306, 
		39742559, 39746765, 39802627, 39872627, 39872767, 39872778, 39877448, 39877812, 39900361, 39911289, 39913307, 39934259, 39950540, 
		39978754, 39978833, 39978879, 39988954, 40004597, 40045036, 40047101, 40126710, 40135568, 40163460, 40195057, 40197474, 40197490, 
		40229384, 40241002, 40244666, 40273212, 40273244, 40289578, 40289619, 40339339, 40352116, 40355483, 40400927, 40425075, 40425157, 
		40446832, 40502205, 40560625, 40560660, 40572100, 40572178, 40861566, 40862209, 40890993, 40903435, 40925851, 40946282, 40946352, 
		40946385, 40946406, 40953783, 40974867, 41015323, 41022198, 41074098, 41145681, 41149467, 41158752, 41264238, 41268128, 41379800, 
		41400607, 41414960, 41475946, 41514316, 41514335, 41542091, 41616837, 41623048, 41636843, 41754736, 41783721, 41792075, 41959578, 
		42099562, 42099905, 42111851, 42111872, 42111881, 42111897, 42113544, 42155389, 42292883, 43938527, 44502534, 44502550, 45300144, 
		45417844, 45417870, 45417885, 45418050, 45435963, 45462062, 45738560)

	
INSERT INTO #MasterList (CustId, srecommend, sporttype, bettype, IsLive,S3,  MinM2A2)
SELECT c.custid, c.srecommend, mpt.sporttype, mpt.bettype, mpt.isLive, mpt.SuperPT,  MIN(apt.MasterPT+apt.AgentPT)
FROM Customer c WITH (NOLOCK) 
	INNER JOIN Customer a WITH (NOLOCK) ON a.mrecommend = c.custid
	INNER JOIN #SuperList s WITH (NOLOCK) ON c.srecommend = s.custid
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) mpt
	CROSS APPLY dbo.f_CS_GetPT_Agent(a.CustId) apt 
WHERE c.roleid = 3 AND a.roleid = 2 AND c.site = 'CN88'
	AND mpt.sporttype = apt.sporttype AND mpt.bettype = apt.bettype AND mpt.isLive = apt.isLive
GROUP BY c.custid, c.srecommend, mpt.sporttype, mpt.bettype, mpt.isLive, mpt.SuperPT

UPDATE ml 
SET ml.S3_New = CASE WHEN ml.S3 < @MinPT_New - ml.MinM2A2 THEN @MinPT_New - ml.MinM2A2 ELSE ml.S3 END
FROM #MasterList ml


SET @MinPT_XML =(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								@MinPT_New		AS '@val'
						FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
						WHERE bs.Type = 'PTSetting' 
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)
				
SET @MaxPT_XML =(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								@MaxPT_New		AS '@val'
						FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
						WHERE bs.Type = 'PTSetting' 
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)				

UPDATE ml 
SET ml.SuperPT_XML = (
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ml.S3_New		AS '@val'
								FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = ml.sporttype AND bs.BetType = ml.BetType AND bs.IsLive = ml.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)
FROM #MasterList ml



SELECT * FROM #SuperList --WHERE custid = 35555477
SELECT * FROM #MasterList --WHERE srecommend = 35555477

------------------UPDATE-------------------------------------------------------------------

--Update n4,l4 of Super
UPDATE cs
SET cs.MinPT = minpt.binaryStr_new,
	cs.MinPT2 = minpt.binaryStr_new,
	cs.MaxPT = maxpt.binaryStr_new,
	cs.MaxPT2 = maxpt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK)
	INNER JOIN #SuperList s ON s.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MinPT, @MinPT_XML) minpt
	CROSS APPLY dbo.f_SetBinaryValues(cs.MaxPT, @MaxPT_XML) maxpt
	
--Update s3 of Master
UPDATE cs
SET cs.SuperPT = spt.binaryStr_new,
	cs.SuperPT2 = spt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	INNER JOIN #MasterList ml ON ml.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) spt
WHERE ml.sporttype = 1 AND ml.bettype = 1

UPDATE cs
SET cs.SuperPT = spt.binaryStr_new,
	cs.SuperPT2 = spt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	INNER JOIN #MasterList ml ON ml.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) spt
WHERE ml.sporttype = 9998 AND ml.bettype = 81

--Update s3 of Member
UPDATE cs
SET cs.SuperPT = mpt.binaryStr_new,
	cs.SuperPT2 = mpt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.AgentId
	INNER JOIN #MasterList ml ON ml.CustId = ci.mrecommend
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) mpt
WHERE ci.roleid = 2
	AND ml.sporttype = 1 AND ml.bettype = 1

UPDATE cs
SET cs.SuperPT = mpt.binaryStr_new,
	cs.SuperPT2 = mpt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.AgentId
	INNER JOIN #MasterList ml ON ml.CustId = ci.mrecommend
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) mpt
WHERE ci.roleid = 2
	AND ml.sporttype = 9998 AND ml.bettype = 81

DROP TABLE #SuperList
DROP TABLE #MasterList