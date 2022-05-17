/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Special remarks renovation [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

CREATE TABLE #CustBatch (CustId INT)
SELECT DISTINCT a.CustID, 0 AS IsFinished
INTO  #CustList
FROM crmCustomerRemark a WITH(NOLOCK)
INNER JOIN bodb02.dbo.Customer b(NOLOCK) on a.CustID = b.custid
WHERE NOT EXISTS(SELECT TOP 1 1 FROM bodb02.dbo.Dep_CustSuper(NOLOCK) WHERE CustID = b.srecommend)

WHILE (1=1)
BEGIN
	UPDATE TOP (4000) t
	SET IsFinished = 1
	OUTPUT deleted.custid INTO #CustBatch
	FROM #CustList t
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK
	
	INSERT INTO crmCustomerRemarkNew(CustID,Remark,CreatedDate)
	SELECT c.CustID,Remark , GETDATE() AS CreatedDate
	FROM crmCustomerRemark c WITH(NOLOCK)
		INNER JOIN #CustBatch t ON c.custid = t.CustId
	WHERE c.Remark	IS NOT NULL AND c.Remark <> '' AND c.Remark <> '<br>'
	ORDER BY c.RemarkID 

	DELETE FROM #CustBatch

	WAITFOR DELAY '00:00:02'
END

DROP TABLE #CustList
DROP TABLE #CustBatch