/*
	Created: 6@Johnson
	Task: update disable for IBCBet LC for INDOBS for newly customers
	DB: DBCUST/CUSTDB	
*/

CREATE TABLE #tblCust
(
	CustID INT PRIMARY KEY CLUSTERED,
	IsFinished BIT DEFAULT(0)
)	

DECLARE @max_custid INT, 	
	@xmlStrBitmapDisabled VARCHAR(MAX), 
	@xmlBitmapDisabled XML

SELECT @max_custid = xxx

--Create XML string that contains bitmap order of all products 
SET @xmlBitmapDisabled = (
		SELECT (
					SELECT P.bitmapOrder AS '@b'
							, 0	AS '@s'
					FROM dbo.ProductStatusProfile P WITH (NOLOCK)
					WHERE sporttype IN (242--IBCBet LC
										)		
					FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)				

SELECT @xmlStrBitmapDisabled = CONVERT(VARCHAR(MAX),@xmlBitmapDisabled)

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT custid 
FROM Acc_CustGroup WITH(NOLOCK)
where groupname = 'indobs'	

INSERT INTO #tblCust (CustID)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND Enabled = 1
	AND custid > @max_custid

DECLARE @MemberBatch table(CustId INT)

WHILE(1=1)
BEGIN
	UPDATE TOP (5000) t 		 
	SET IsFinished = 1
	OUTPUT INSERTED.CustID INTO @MemberBatch
	FROM #tblCust t
	WHERE IsFinished = 0
 
	IF @@ROWCOUNT = 0
		BREAK
	
	UPDATE cs
	SET bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrBitmapDisabled)))		
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
		INNER JOIN @MemberBatch ci ON cs.CustID = ci.CustID

	DELETE @MemberBatch
	
	WAITFOR DELAY '0:0:0.28'
END

--Drop all temp tables
DROP TABLE #tblCust	