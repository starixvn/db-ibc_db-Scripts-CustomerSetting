USE [CustDB]
GO

/*
	Created: 20190408Percy
	DB: DBCUST.CustDB
	Task: Update transfer option of CustSuper/CustMaster/CustAgent
*/

CREATE TABLE #tmpCust (CustId INT)
DECLARE @CustIdXML XML, @CustIdList VARCHAR(MAX)

-- CustSuper
SELECT s.custid
INTO #tmpCustSuper
FROM dbo.CustSuper s WITH (NOLOCK)
	INNER JOIN dbo.Acc_ClearBalanceList ac WITH (NOLOCK) ON s.custid = ac.custid
WHERE s.TransferOption <> 0

WHILE EXISTS (SELECT 1 FROM #tmpCustSuper)
BEGIN
	DELETE TOP (3000) #tmpCustSuper OUTPUT DELETED.CustId INTO #tmpCust

	SELECT @CustIdXML = (SELECT custid AS '@c' FROM #tmpCust FOR XML PATH('r'), TYPE)

	SELECT @CustIdList = CAST(@CustIdXML AS VARCHAR(MAX))
	EXEC dbo.Acc_CustomerInfo_Execrep_09 @CustIdList = @CustIdList, @tableName = 'CustSuper'

	TRUNCATE TABLE #tmpCust
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #tmpCustSuper
-- End CustSuper

-- CustMaster
SELECT m.custid
INTO #tmpCustMaster
FROM dbo.CustMaster m WITH (NOLOCK)
	INNER JOIN dbo.custInfo c WITH (NOLOCK) ON m.custid = c.custid
	INNER JOIN dbo.Acc_ClearBalanceList ac WITH (NOLOCK) ON c.srecommend = ac.custid
WHERE m.TransferOption <> 0
	AND c.roleid = 3

WHILE EXISTS (SELECT 1 FROM #tmpCustMaster)
BEGIN
	DELETE TOP (3000) #tmpCustMaster OUTPUT DELETED.CustId INTO #tmpCust

	SELECT @CustIdXML = (SELECT custid AS '@c' FROM #tmpCust FOR XML PATH('r'), TYPE)

	SELECT @CustIdList = CAST(@CustIdXML AS VARCHAR(MAX))
	EXEC dbo.Acc_CustomerInfo_Execrep_09 @CustIdList = @CustIdList, @tableName = 'CustMaster'

	TRUNCATE TABLE #tmpCust
	WAITFOR DELAY '00:00:0.100'
END
DROP TABLE #tmpCustMaster
-- End CustMaster

-- CustAgent
SELECT a.custid
INTO #tmpCustAgent
FROM dbo.CustAgent a WITH (NOLOCK)
	INNER JOIN dbo.custInfo c WITH (NOLOCK) ON a.custid = c.custid
	INNER JOIN dbo.Acc_ClearBalanceList ac WITH (NOLOCK) ON c.srecommend = ac.custid
WHERE a.TransferOption <> 0
	AND c.roleid = 2

WHILE EXISTS (SELECT 1 FROM #tmpCustAgent)
BEGIN
	DELETE TOP (3000) #tmpCustAgent OUTPUT DELETED.CustId INTO #tmpCust

	SELECT @CustIdXML = (SELECT custid AS '@c' FROM #tmpCust FOR XML PATH('r'), TYPE)

	SELECT @CustIdList = CAST(@CustIdXML AS VARCHAR(MAX))
	EXEC dbo.Acc_CustomerInfo_Execrep_09 @CustIdList = @CustIdList, @tableName = 'CustAgent'

	TRUNCATE TABLE #tmpCust
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #tmpCustAgent
-- End CustAgent

DROP TABLE #tmpCust