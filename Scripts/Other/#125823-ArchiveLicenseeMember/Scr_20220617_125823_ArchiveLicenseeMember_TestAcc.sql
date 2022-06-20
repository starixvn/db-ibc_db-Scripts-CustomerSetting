/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220617
    Task: archive UUS members of SampleSite: [#125823]
		custid		username			username2
		53553810	Test1607UUS01001	Test1607$qatest01
		53553811	Test1607UUS01002	Test1607$qatest02
		53553813	Test1607UUS01003	Test1607$qatest03
		53553815	Test1607UUS01004	Test1607$qatest04
		53553817	Test1607UUS01005	Test1607$qatest05
		53553818	Test1607UUS01006	Test1607$qatest06
		53553819	Test1607UUS01007	Test1607$qatest07
		53553820	Test1607UUS01008	Test1607$qatest08
		53553822	Test1607UUS01009	Test1607$qatest09
		53553823	Test1607UUS01010	Test1607$qatest10
		53553824	Test1607UUS01011	Test1607$qatest11
		53553825	Test1607UUS01012	Test1607$qatest12
		53553826	Test1607UUS01013	Test1607$qatest13
		53553827	Test1607UUS01014	Test1607$qatest14
		53553828	Test1607UUS01015	Test1607$qatest15
		60105845	Test1607UUS01026	Test1607$autotest01
		60105846	Test1607UUS01027	Test1607$autotest02
		60105847	Test1607UUS01028	Test1607$autotest03
		60105849	Test1607UUS01029	Test1607$autotest04
		60105850	Test1607UUS01030	Test1607$autotest05

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
		 53553810	--Test1607UUS01001	Test1607$qatest01
		,53553811	--Test1607UUS01002	Test1607$qatest02
		,53553813	--Test1607UUS01003	Test1607$qatest03
		,53553815	--Test1607UUS01004	Test1607$qatest04
		,53553817	--Test1607UUS01005	Test1607$qatest05
		,53553818	--Test1607UUS01006	Test1607$qatest06
		,53553819	--Test1607UUS01007	Test1607$qatest07
		,53553820	--Test1607UUS01008	Test1607$qatest08
		,53553822	--Test1607UUS01009	Test1607$qatest09
		,53553823	--Test1607UUS01010	Test1607$qatest10
		,53553824	--Test1607UUS01011	Test1607$qatest11
		,53553825	--Test1607UUS01012	Test1607$qatest12
		,53553826	--Test1607UUS01013	Test1607$qatest13
		,53553827	--Test1607UUS01014	Test1607$qatest14
		,53553828	--Test1607UUS01015	Test1607$qatest15
		,60105845	--Test1607UUS01026	Test1607$autotest01
		,60105846	--Test1607UUS01027	Test1607$autotest02
		,60105847	--Test1607UUS01028	Test1607$autotest03
		,60105849	--Test1607UUS01029	Test1607$autotest04
		,60105850	--Test1607UUS01030	Test1607$autotest05
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

/*
SELECT * FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0 AND CustIDBalanceDummy = 0
*/
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Clear balance (SQL job run at DBTXN) -------------------------------
--> Run Job : Archive Deposit Member - Step 2: Clear Balance and CustInfo

---------------------------Step 3 : Archive Setting  (SQL job run at DB05) -------------------------------
--> Run Job : Archive Deposit Member - Step 3:Archive CustSetting
