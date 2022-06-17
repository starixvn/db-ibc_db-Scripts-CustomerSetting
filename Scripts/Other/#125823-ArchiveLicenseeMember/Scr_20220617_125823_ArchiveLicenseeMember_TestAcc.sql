/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220617
    Task: archive some UUS members : [#125823]
		CustID		Username			Username2
		60101581	SampleSiteUUS01149	SampleSite$autotest01
		60101582	SampleSiteUUS01150	SampleSite$autotest02
		60101583	SampleSiteUUS01151	SampleSite$autotest03
		60101584	SampleSiteUUS01152	SampleSite$autotest04
		60101585	SampleSiteUUS01153	SampleSite$autotest05
		35195578	SampleSiteUUS01001	SampleSite$qatest01
		35195579	SampleSiteUUS01002	SampleSite$qatest02
		35195580	SampleSiteUUS01003	SampleSite$qatest03
		35195581	SampleSiteUUS01004	SampleSite$qatest04
		35195582	SampleSiteUUS01005	SampleSite$qatest05
		35195583	SampleSiteUUS01006	SampleSite$qatest06
		35195584	SampleSiteUUS01007	SampleSite$qatest07
		35195585	SampleSiteUUS01008	SampleSite$qatest08
		35195586	SampleSiteUUS01009	SampleSite$qatest09
		35195587	SampleSiteUUS01010	SampleSite$qatest10
		35195588	SampleSiteUUS01011	SampleSite$qatest11
		35195589	SampleSiteUUS01012	SampleSite$qatest12
		35195590	SampleSiteUUS01013	SampleSite$qatest13
		35195591	SampleSiteUUS01014	SampleSite$qatest14
		35195592	SampleSiteUUS01015	SampleSite$qatest15





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
		60101581	--SampleSiteUUS01149	SampleSite$autotest01
		,60101582	--SampleSiteUUS01150	SampleSite$autotest02
		,60101583	--SampleSiteUUS01151	SampleSite$autotest03
		,60101584	--SampleSiteUUS01152	SampleSite$autotest04
		,60101585	--SampleSiteUUS01153	SampleSite$autotest05
		,35195578	--SampleSiteUUS01001	SampleSite$qatest01
		,35195579	--SampleSiteUUS01002	SampleSite$qatest02
		,35195580	--SampleSiteUUS01003	SampleSite$qatest03
		,35195581	--SampleSiteUUS01004	SampleSite$qatest04
		,35195582	--SampleSiteUUS01005	SampleSite$qatest05
		,35195583	--SampleSiteUUS01006	SampleSite$qatest06
		,35195584	--SampleSiteUUS01007	SampleSite$qatest07
		,35195585	--SampleSiteUUS01008	SampleSite$qatest08
		,35195586	--SampleSiteUUS01009	SampleSite$qatest09
		,35195587	--SampleSiteUUS01010	SampleSite$qatest10
		,35195588	--SampleSiteUUS01011	SampleSite$qatest11
		,35195589	--SampleSiteUUS01012	SampleSite$qatest12
		,35195590	--SampleSiteUUS01013	SampleSite$qatest13
		,35195591	--SampleSiteUUS01014	SampleSite$qatest14
		,35195592	--SampleSiteUUS01015	SampleSite$qatest15
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
