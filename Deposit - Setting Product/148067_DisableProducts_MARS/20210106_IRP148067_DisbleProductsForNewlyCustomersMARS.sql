/*
	Created: 20210106@Johnson
	Task: Disable RNG Keno, Lottery, Table Game, Virtual Games, Arcadia status for newly customers MARSSuperRMB
	RedmineID: #148067			
*/ 

CREATE TABLE #tblMembers			(CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT 0)
CREATE TABLE #Dummy					(CustID INT PRIMARY KEY CLUSTERED)
	
DECLARE @max_custid INT, 		
		@srecommend INT = 31607887 --MARSSuperRMB

SELECT @max_custid = xxx --input maxcustid here

-- get dummy member
INSERT INTO #Dummy(CustID)
SELECT CustID 
FROM Custinfo WITH(NOLOCK) 
WHERE srecommend=@srecommend 
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

INSERT INTO #tblMembers (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend = @srecommend 
	AND roleid = 1  
	AND custid > @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

--Update keno status 
UPDATE g 
SET isdisabled = 1
FROM dbo.CustGameType g WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblMembers)
	AND GameTypeID = 1

DECLARE @xmlStrDisabled XML

SET @xmlStrDisabled = (
			SELECT (
					SELECT bitmapOrder	AS '@b'
						, 1	AS '@s'
					FROM (SELECT 6 as bitmapOrder --Lottery
					UNION SELECT 9  --Arcadia
					UNION SELECT 11 --Virtual Games
					UNION SELECT 16 --Table Game
					)t
					FOR XML PATH('r')
						, TYPE
					)
			FOR XML PATH('root')
				, TYPE
			)
			
UPDATE cs
SET	bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrDisabled)))	
FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
WHERE custid IN (SELECT custid FROM #tblMembers)

DROP TABLE #Dummy
DROP TABLE #tblMembers	