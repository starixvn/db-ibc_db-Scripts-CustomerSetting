/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220823@Tacy
	Task: Update Dangerous setting's member follow upline [redmine:#176518]
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]	
			@CustList VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCustDanger (
			custid	INT PRIMARY KEY, 
			danger	BIGINT,
			danger2 BIGINT, 
			danger3 BIGINT, 
			Danger4 BIGINT, 
			Danger5 BIGINT,
			isBA	BIT
	)

	DECLARE @tmpCust TABLE (
			custid INT PRIMARY KEY,
			danger	BIGINT,
			danger2 BIGINT, 
			danger3 BIGINT, 
			Danger4 BIGINT, 
			Danger5 BIGINT,
			isBA	BIT
	)

	IF @CustList IS NULL OR @CustList='' RETURN

	DECLARE @xml XML = CAST (@CustList as XML)
	
	INSERT INTO #tblCustDanger (custid, danger, danger2, danger3, Danger4, Danger5, isBA)
	SELECT	t.c.value('@custid[1]','int'),
			t.c.value('@danger[1]','bigint'),
			t.c.value('@danger2[1]','bigint'),
			t.c.value('@danger3[1]','bigint'),
			t.c.value('@danger4[1]','bigint'),
			t.c.value('@danger5[1]','bigint'),
			t.c.value('@isBA[1]','bit')
	FROM @xml.nodes('Root/r')as t(c)
	
	WHILE(1=1)
	BEGIN
		DELETE @tmpCust

		DELETE TOP(5000) t
		OUTPUT deleted.custid, deleted.danger, deleted.danger2, deleted.danger3, deleted.danger4, deleted.danger5, deleted.isBA
		INTO @tmpCust(custid, danger, danger2, danger3, Danger4, Danger5, isBA)
		FROM #tblCustDanger t

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE ci
		SET ci.danger=CASE WHEN ci.danger=0 OR (ci.danger<>0 AND isBA=1)THEN t.danger ELSE ci.danger END,
			ci.danger2=CASE WHEN ci.danger2=0 THEN t.danger2 ELSE ci.danger2 END,
			ci.danger3=CASE WHEN ci.danger3=0 THEN t.danger3 ELSE ci.danger3 END,
			ci.danger4=CASE WHEN ci.danger4=0 THEN t.danger4 ELSE ci.danger4 END,
			ci.danger5=CASE WHEN ci.danger5=0 THEN t.danger5 ELSE ci.danger5 END
		FROM custInfo ci WITH (UPDLOCK, ROWLOCK)
			INNER JOIN @tmpCust t ON ci.custid = t.custid

		WAITFOR DELAY '0:0:0.1'
	END

	DROP TABLE #tblCustDanger
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

--Update:
DECLARE @CustList VARCHAR (MAX)=NULL;

CREATE TABLE #tblCustDanger (
		custid	INT PRIMARY KEY, 
		danger	BIGINT,
		danger2 BIGINT, 
		danger3 BIGINT, 
		Danger4 BIGINT, 
		Danger5 BIGINT,
		isBA	BIT DEFAULT 0
)

DECLARE @tmpCust TABLE (
		custid INT PRIMARY KEY,
		danger	BIGINT,
		danger2 BIGINT, 
		danger3 BIGINT, 
		Danger4 BIGINT, 
		Danger5 BIGINT,
		isBA	BIT
)
		
-- BA Member:
INSERT INTO #tblCustDanger (custid, danger, danger2, danger3, Danger4, Danger5, isBA)
SELECT ba.CustId, ag.danger, ag.danger2, ag.danger3, ag.Danger4, ag.Danger5,1
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN Dep_CustBAActive ba WITH (NOLOCK) ON ba.CustId=ci.custid
	INNER JOIN custInfo ag WITH (NOLOCK) ON ag.custid=ci.recommend
WHERE ci.roleid=1

-- Deposit Member:
INSERT INTO #tblCustDanger (custid, danger, danger2, danger3, Danger4, Danger5)
SELECT ci.CustId, ag.danger, ag.danger2, ag.danger3, ag.Danger4, ag.Danger5
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN Dep_CustSuper s WITH (NOLOCK) ON s.CustId=ci.srecommend
	INNER JOIN custInfo ag WITH (NOLOCK) ON ag.custid=ci.recommend
WHERE ci.roleid=1
AND NOT EXISTS (SELECT 1 FROM #tblCustDanger t WHERE t.custid=ci.custid)
AND (ci.danger=0 OR ci.danger2=0 OR ci.danger3=0 OR ci.Danger4=0 OR ci.Danger5=0)

-- Call sp execrep to update:
WHILE(1=1)
BEGIN
	DELETE @tmpCust

	DELETE TOP(20000) t
	OUTPUT deleted.custid, deleted.danger, deleted.danger2, deleted.danger3, deleted.danger4, deleted.danger5, deleted.isBA
	INTO @tmpCust(custid, danger, danger2, danger3, Danger4, Danger5, isBA)
	FROM #tblCustDanger t

	IF @@ROWCOUNT = 0
		BREAK;

	SET @CustList = CAST((
							SELECT	custid	as	'@custid',
									danger	as	'@danger',
									danger2 as	'@danger2',
									danger3 as	'@danger3',
									danger4 as	'@danger4',
									danger5 as	'@danger5',
									isBA	as	'@isBA'
							FROM @tmpCust
							FOR XML PATH('r'),ROOT('Root')
						) AS VARCHAR(MAX))

	EXEC [dbo].[Acc_CustomerInfo_Execrep_09] @CustList=@CustList
END

DROP TABLE #tblCustDanger