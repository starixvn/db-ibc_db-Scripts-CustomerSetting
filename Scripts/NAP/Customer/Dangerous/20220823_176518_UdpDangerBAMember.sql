/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220823@Tacy
	Task: Update Danger's BA member follow upline [redmine:#176518]
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]	
			@CustList VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCustDanger (custid INT PRIMARY KEY, danger BIGINT)
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, danger BIGINT)

	IF @CustList IS NULL OR @CustList='' RETURN

	DECLARE @xml XML = CAST (@CustList as XML)
	
	INSERT INTO #tblCustDanger (custid, danger)
	SELECT	t.c.value('@custid[1]','int'),
			t.c.value('@danger[1]','bigint')
	FROM @xml.nodes('Root/r')as t(c)

	WHILE(1=1)
	BEGIN
		DELETE TOP(5000) t
		OUTPUT DELETED.custid, DELETED.danger
		INTO @tmpCust(custid,danger)
		FROM #tblCustDanger t
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE ci
		SET ci.danger=t.danger
		FROM custInfo ci WITH (UPDLOCK, ROWLOCK)
			INNER JOIN @tmpCust t ON ci.custid = t.custid

		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.1'
	END
	
	DROP TABLE #tblCustDanger
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

--Update:
DECLARE @CustList VARCHAR (MAX)=NULL;

CREATE TABLE #tblCustDanger (custid INT PRIMARY KEY, danger BIGINT)
	
INSERT INTO #tblCustDanger (custid, danger)
SELECT ba.CustId, ag.danger
FROM custInfo ci WITH (UPDLOCK, ROWLOCK)
	INNER JOIN Dep_CustBAActive ba WITH (NOLOCK) ON ba.CustId=ci.custid
	INNER JOIN custInfo ag WITH (NOLOCK) ON ag.custid=ci.recommend

SET @CustList = CAST((
						SELECT	custid as '@custid',
								danger as '@danger'
						FROM #tblCustDanger
						FOR XML PATH('r'),ROOT('Root')
					) AS VARCHAR(MAX))

EXEC [dbo].[Acc_CustomerInfo_Execrep_09] @CustList=@CustList
