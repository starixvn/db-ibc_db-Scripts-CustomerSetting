/*
	Created by: Elodie
	Date: 20200115
	Task: Adjust wrong MinPT for CN88
	DB: DBCUST/CustDB	
*/
USE CustDB
GO

DECLARE @MinPT_New TINYINT = 85
DECLARE @MinPT_XML XML

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

------------------UPDATE--------------------------------------------
--Update MinPT of Super
UPDATE cs
SET cs.MinPT = minpt.binaryStr_new,
	cs.MinPT2 = minpt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK)
	CROSS APPLY dbo.f_SetBinaryValues(cs.MinPT, @MinPT_XML) minpt
WHERE custid IN (39811468,40004332) --TP193, TP211

