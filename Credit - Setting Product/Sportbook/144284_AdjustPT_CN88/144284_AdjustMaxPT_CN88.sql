/*
	Created by: Winfred
	Date: 20201027
	Task: Update Super Min& Max PT and Headline PT for CN88 [redmine : 144284]
	DB: DBCUST/CustDB

	Update MaxPT when MinPT = MaxPT
*/
USE CustDB
GO

DECLARE @MaxPT_New TINYINT = 90
DECLARE @MaxPT_XML XML

CREATE TABLE #SuperList (CustId INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, L4 TINYINT)

INSERT INTO #SuperList (CustId, sporttype, bettype, IsLive, L4)
SELECT c.custid, spt.sporttype, spt.bettype, spt.isLive, spt.MaxPT 
FROM Customer c WITH (NOLOCK) 
	INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = c.custid
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) spt
WHERE c.roleid = 4 AND c.site = 'CN88'
	AND c.currency <> 20
	AND s.IsInternal = 0
	AND c.custid in ( 39811468, 40004332, 45684368)
	AND spt.sporttype = 1 
	AND spt.bettype = 1
				
SET @MaxPT_XML =(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								@MaxPT_New		AS '@val'
						FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
						WHERE bs.Type = 'PTSetting' AND bs.sporttype = 1 AND bs.bettype = 1
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)				

SELECT * FROM #SuperList --WHERE custid = 39811468

------------------UPDATE-------------------------------------------------------------------

--Update l4 of Super
UPDATE cs
SET cs.MaxPT = maxpt.binaryStr_new,
	cs.MaxPT2 = maxpt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK)
	INNER JOIN #SuperList s ON s.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MaxPT, @MaxPT_XML) maxpt

DROP TABLE #SuperList