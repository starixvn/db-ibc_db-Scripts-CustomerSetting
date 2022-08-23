/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220728
    Task: archive members: [#175813]
		25419466,25544810,43788723,49238185,49283667,49387235,50310019,50390265,50491256,50587594,50595759
		,50702996,50807646,50895598,50907171,51153767,51228941,51251040,51272900,51450360,51509257,51696833
		,51841875,51858763,51868814,52043808,52221635,52348921,52496306,52552102,52561426,52567986,52734611
		,52759392,52894110,53185196,53192678,53194080,53341257,53410425,53490562,53734996,53893185

		Step 1 : Insert members to waiting list (DBCUST/CUSTDB)
		Step 2 : Archive Deposit Member - Step 2: Clear Balance and CustInfo (DBTXN) - job
		Step 3 : Archive Deposit Member - Step 3: Archive CustSetting (DB05) - job
    DB: DBCUST/CustDB
*/ 

---------------------------Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------
USE CustDB
SELECT   c.[CustID]
		,[ArchivedDate] = GETDATE()
		,[Username] =  c.username
		,[Username2] = c.username2
		,[Recommend] = c.recommend
		,[ClosingBalance] = CAST(0 AS MONEY)
		,[CustIDBalanceDummy] = bal.custid
		,[Status] = 'waiting'
INTO #Member
FROM Customer c WITH(NOLOCK)
	INNER JOIN Customer bal WITH(NOLOCK) 
		ON bal.recommend = c.recommend
		AND bal.username like '%ClearBal'
WHERE c.custid IN (25419466,25544810,43788723,49238185,49283667,49387235,50310019,50390265,50491256,50587594,50595759
	,50702996,50807646,50895598,50907171,51153767,51228941,51251040,51272900,51450360,51509257,51696833
	,51841875,51858763,51868814,52043808,52221635,52348921,52496306,52552102,52561426,52567986,52734611
	,52759392,52894110,53185196,53192678,53194080,53341257,53410425,53490562,53734996,53893185)

--Update ClosingBalance
UPDATE #Member 
SET [ClosingBalance] = b.MemberBalance
FROM #Member
INNER JOIN (
	SELECT custid, ISNULL(SUM(winlost-actual_stake+playercomm),0) as MemberBalance
	FROM DBACC.bodb02.dbo.transfer WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #Member)
	GROUP BY custid
	) b ON #Member.custid = b.custid

DELETE c
FROM #Member t
INNER JOIN [Dep_Customer_Archived] c WITH(ROWLOCK,UPDLOCK)
	ON t.custid = c.CustID
WHERE t.ClosingBalance = 0

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status])
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status]
FROM #Member t
WHERE t.ClosingBalance = 0

--SELECT * FROM [Dep_Customer_Archived](NOLOCK) WHERE status = 'waiting'

DROP TABLE #Member
GO

/*
SELECT * FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0 AND CustIDBalanceDummy = 0
*/
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Clear balance (SQL job run at DBTXN) -------------------------------
--> Run Job : Archive Deposit Member - Step 2: Clear Balance and CustInfo

---------------------------Step 3 : Archive Setting  (SQL job run at DB05) -------------------------------
--> Run Job : Archive Deposit Member - Step 3:Archive CustSetting
