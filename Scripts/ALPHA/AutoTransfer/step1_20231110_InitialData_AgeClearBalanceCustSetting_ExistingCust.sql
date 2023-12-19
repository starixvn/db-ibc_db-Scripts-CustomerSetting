/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke	
	Date: 20231110
	Task:  Alpha - Enhance auto transfer function (phase 2) [Redmine: #195135]
	DB: DBCUST/CustDB
*/
DECLARE @max_custid INT = xxx,
		@batchSize SMALLINT = 5000

CREATE TABLE #custTransfer(fromcustid INT, tocustid INT, transferoption TINYINT, transferoption_string VARCHAR(8), scheduleoption TINYINT DEFAULT (254), PRIMARY KEY(fromcustid, tocustid))
CREATE TABLE #batchTransfer(fromcustid INT, tocustid INT, scheduleoption TINYINT)

INSERT INTO #custTransfer(fromcustid, tocustid, transferoption)
	SELECT a.FromCustID, a.ToCustID, cs.TransferOption
	FROM Age_ClearBalanceCust_Setting a WITH (NOLOCK)
		INNER JOIN CustSuper cs WITH (NOLOCK) ON a.FromCustID = cs.custid
	WHERE a.ToCustID <= @max_custid
UNION ALL
	SELECT a.FromCustID, a.ToCustID, cm.TransferOption
	FROM Age_ClearBalanceCust_Setting a WITH (NOLOCK)
		INNER JOIN CustMaster cm WITH (NOLOCK) ON a.FromCustID = cm.custid
	WHERE a.ToCustID <= @max_custid
UNION ALL
	SELECT a.FromCustID, a.ToCustID, ca.TransferOption
	FROM Age_ClearBalanceCust_Setting a WITH (NOLOCK)
		INNER JOIN CustAgent ca with (NOLOCK) ON a.FromCustID = ca.custid
	WHERE a.ToCustID <= @max_custid

CREATE NONCLUSTERED INDEX idx_TransferOption ON #custTransfer(TransferOption)

UPDATE t 
SET t.transferoption_string = dbo.f_Decimal_Binary(transferoption)
FROM #custTransfer t
WHERE t.transferoption > 0

UPDATE t 
SET t.scheduleoption =	CAST(SUBSTRING(transferoption_string,1,1) AS TINYINT)*POWER(2,1)
						+ CAST(SUBSTRING(transferoption_string,2,1) AS TINYINT)*POWER(2,2)
						+ CAST(SUBSTRING(transferoption_string,3,1) AS TINYINT)*POWER(2,3)
						+ CAST(SUBSTRING(transferoption_string,4,1) AS TINYINT)*POWER(2,4)
						+ CAST(SUBSTRING(transferoption_string,5,1) AS TINYINT)*POWER(2,5)
						+ CAST(SUBSTRING(transferoption_string,6,1) AS TINYINT)*POWER(2,6)
						+ CAST(SUBSTRING(transferoption_string,7,1) AS TINYINT)*POWER(2,7)
FROM #custTransfer t
WHERE t.transferoption > 0

WHILE (1 = 1)
BEGIN
	DELETE #batchTransfer

	DELETE TOP (@batchSize) t 
		OUTPUT deleted.fromcustid, deleted.tocustid, deleted.scheduleoption 
		INTO #batchTransfer(fromcustid, tocustid, scheduleoption)
	FROM #custTransfer t	

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE t
	SET t.scheduleoption = bt.scheduleoption
	FROM Age_ClearBalanceCust_Setting t WITH (ROWLOCK)
		INNER JOIN #batchTransfer bt ON t.fromcustid = bt.fromcustid AND t.tocustid = bt.tocustid
END
DROP TABLE #batchTransfer, #custTransfer