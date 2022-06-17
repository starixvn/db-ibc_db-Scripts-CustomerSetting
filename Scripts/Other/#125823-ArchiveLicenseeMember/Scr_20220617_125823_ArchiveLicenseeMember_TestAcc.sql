/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220617
    Task: archive some UUS members : [#125823]
		SampleSite$webtest01	65163073
		SampleSite$webtest02	65163080
		SampleSite$webtest03	65163095
		SampleSite$webtest04	65163098
		SampleSite$webtest05	65163103
		SampleSite$webtest06	65163107
		SampleSite$webtest07	65163113
		SampleSite$webtest08	65163116
		SampleSite$webtest09	65163120
		SampleSite$webtest10	65163124
		SampleSite$webtest11	65163126
		SampleSite$webtest12	65163129
		SampleSite$webtest13	65163134
		SampleSite$webtest14	65163136
		SampleSite$webtest15	65163139
		SampleSite$webtest16	65163143
		SampleSite$webtest17	65163147
		SampleSite$webtest18	65163150
		SampleSite$webtest19	65163156
		SampleSite$webtest20	65163161



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
WHERE c.custid IN (
	 65163073	--SampleSite$webtest01
	,65163080	--SampleSite$webtest02
	,65163095	--SampleSite$webtest03
	,65163098	--SampleSite$webtest04
	,65163103	--SampleSite$webtest05
	,65163107	--SampleSite$webtest06
	,65163113	--SampleSite$webtest07
	,65163116	--SampleSite$webtest08
	,65163120	--SampleSite$webtest09
	,65163124	--SampleSite$webtest10
	,65163126	--SampleSite$webtest11
	,65163129	--SampleSite$webtest12
	,65163134	--SampleSite$webtest13
	,65163136	--SampleSite$webtest14
	,65163139	--SampleSite$webtest15
	,65163143	--SampleSite$webtest16
	,65163147	--SampleSite$webtest17
	,65163150	--SampleSite$webtest18
	,65163156	--SampleSite$webtest19
	,65163161	--SampleSite$webtest20
)
AND c.currency = 20

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

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status])
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status]
FROM #Member

--SELECT * FROM [Dep_Customer_Archived](NOLOCK) WHERE status = 'waiting'

DROP TABLE #Member
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Clear balance (SQL job run at DBTXN) -------------------------------
--> Run Job : Archive Deposit Member - Step 2: Clear Balance and CustInfo

---------------------------Step 3 : Archive Setting  (SQL job run at DB05) -------------------------------
--> Run Job : Archive Deposit Member - Step 3:Archive CustSetting
