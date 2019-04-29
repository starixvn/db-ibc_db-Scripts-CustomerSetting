/*
	Created: Elodie
	Date: 2019-04-29
	Task: adjust virtual rate 
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

CREATE TABLE #masters (custid INT)
CREATE TABLE #AffectedList (custid INT, roleid TINYINT)
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)	
DECLARE @NewValue TABLE (seqNo TINYINT, NewBitmap BINARY(64))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

--get master list EnableVR = 1 and VR = -85
INSERT INTO #masters(custid)
SELECT DISTINCT ci.custid
FROM Dep_CustSuper s WITH(NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.srecommend = s.custid
	INNER JOIN dbo.CustVirtualSetting cvs WITH (NOLOCK) ON cvs.custid = ci.custid
WHERE ci.VirtualMultiplier = 1
	AND ci.roleid = 3
	AND cvs.bitmapVirtual LIKE '%[' + CAST(CAST(15 AS BINARY(1)) AS VARCHAR) + ']%'
	AND ci.username NOT LIKE '%ACC%'
	AND ci.currency <> 20
	AND ci.custid <= @max_custid

-- 1137 affected rows
INSERT INTO #AffectedList (custid, roleid)
SELECT ci.custid, roleid
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN #masters m ON ci.mrecommend = m.custid
WHERE ci.roleid IN (2,1)
	AND ci.VirtualMultiplier = 0
	AND ci.username NOT LIKE '%Cashout%'
	AND ci.username NOT LIKE '%ClearBal%'
	AND ci.username NOT LIKE '%BetTrade%'
	AND ci.custid <= @max_custid
	
INSERT INTO @NewValue (seqNo, NewBitmap)
SELECT	seqNo,
		(
			SELECT TOP 1 bitmap
			FROM dbo.f_GenerateVirtualSetting_multiple(0x00, CONVERT(VARCHAR(MAX), virtualXML))
		) AS bitmapVirtual
FROM (
	SELECT DISTINCT seqNo
	FROM ProfileVirtualSetting WITH(NOLOCK)
) pvs
CROSS APPLY (
	SELECT (
		SELECT	(
					SELECT	ipvs.profileID			AS '@p',
							vr.virtualMultiplier	AS '@v'
					FROM	ProfileVirtualSetting	AS ipvs WITH(NOLOCK)
					CROSS APPLY (
						SELECT CAST(0.15 AS SMALLMONEY) AS virtualMultiplier
					) vr
					WHERE	ipvs.seqNo = pvs.seqNo
					FOR XML PATH ('r'), 
					TYPE
				)
		FOR XML PATH ('root'), 
		TYPE
	) AS virtualXML
) p	

-- 1137 affected rows
UPDATE ci 
SET	ci.VirtualMultiplier = 1
FROM dbo.custInfo ci WITH(ROWLOCK,UPDLOCK)	
	INNER JOIN #AffectedList a ON a.custid = ci.custid		

WHILE (1 = 1)
BEGIN
	DELETE @tmpCust
		
	DELETE TOP (1500) t
	OUTPUT DELETED.custid
	INTO @tmpCust 
	FROM #AffectedList t
		
	IF @@rowcount = 0 
		BREAK;
			
	UPDATE	cvs 
	SET		cvs.bitmapVirtual =	nv.NewBitmap
	FROM dbo.CustVirtualSetting AS cvs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @tmpCust a ON a.custid = cvs.custid		
		INNER JOIN @NewValue nv ON nv.seqNo = cvs.seqNo				
		
	WAITFOR DELAY '00:00:00.01'
END
	
DROP TABLE #masters
DROP TABLE #AffectedList