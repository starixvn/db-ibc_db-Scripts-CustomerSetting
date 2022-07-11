/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220617
    Task: archive UUS members of SampleSiteUUS: [#175312]

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
		 65163126	--SampleSiteUUS24001
		,65163129	--SampleSiteUUS24002
		,65163134	--SampleSiteUUS24003
		,65163136	--SampleSiteUUS24004
		,65163139	--SampleSiteUUS24005
		,65163143	--SampleSiteUUS24006
		,65163147	--SampleSiteUUS24007
		,65163150	--SampleSiteUUS24008
		,65163156	--SampleSiteUUS24009
		,65163161	--SampleSiteUUS24010
		,65546432	--SampleSiteUUS24011
		,65546459	--SampleSiteUUS24012
		,65546474	--SampleSiteUUS24013
		,65546526	--SampleSiteUUS24014
		,65546537	--SampleSiteUUS24015
		,65546544	--SampleSiteUUS24016
		,65546559	--SampleSiteUUS24017
		,65546601	--SampleSiteUUS24018
		,65546607	--SampleSiteUUS24019
		,65546609	--SampleSiteUUS24020
		,65546641	--SampleSiteUUS24021
		,65546643	--SampleSiteUUS24022
		,65546645	--SampleSiteUUS24023
		,65546647	--SampleSiteUUS24024
		,65546648	--SampleSiteUUS24025
		,65546650	--SampleSiteUUS24026
		,65546652	--SampleSiteUUS24027
		,65546653	--SampleSiteUUS24028
		,65546655	--SampleSiteUUS24029
		,65546658	--SampleSiteUUS24030
		,65546659	--SampleSiteUUS24031
		,65546661	--SampleSiteUUS24032
		,65546663	--SampleSiteUUS24033
		,65546664	--SampleSiteUUS24034
		,65546666	--SampleSiteUUS24035
		,65546668	--SampleSiteUUS24036
		,65546669	--SampleSiteUUS24037
		,65546670	--SampleSiteUUS24038
		,65546672	--SampleSiteUUS24039
		,65546673	--SampleSiteUUS24040
		,65546676	--SampleSiteUUS24041
		,65546678	--SampleSiteUUS24042
		,65546679	--SampleSiteUUS24043
		,65546684	--SampleSiteUUS24044
		,65546687	--SampleSiteUUS24045
		,65546689	--SampleSiteUUS24046
		,65546690	--SampleSiteUUS24047
		,65546693	--SampleSiteUUS24048
		,65546694	--SampleSiteUUS24049
		,65546695	--SampleSiteUUS24050
		,65546696	--SampleSiteUUS24051
		,65546697	--SampleSiteUUS24052
		,65546699	--SampleSiteUUS24053
		,65546701	--SampleSiteUUS24054
		,65546702	--SampleSiteUUS24055
		,65546705	--SampleSiteUUS24056
		,65546709	--SampleSiteUUS24057
		,65546713	--SampleSiteUUS24058
		,65546714	--SampleSiteUUS24059
		,65546716	--SampleSiteUUS24060
		,65546718	--SampleSiteUUS24061
		,65546725	--SampleSiteUUS24062
		,65546729	--SampleSiteUUS24063
		,65546731	--SampleSiteUUS24064
		,65546735	--SampleSiteUUS24065
		,65546737	--SampleSiteUUS24066
		,65546738	--SampleSiteUUS24067
		,65546739	--SampleSiteUUS24068
		,65546741	--SampleSiteUUS24069
		,65546742	--SampleSiteUUS24070
		,65546745	--SampleSiteUUS24071
		,65546747	--SampleSiteUUS24072
		,65546749	--SampleSiteUUS24073
		,65546751	--SampleSiteUUS24074
		,65546753	--SampleSiteUUS24075
		,65546755	--SampleSiteUUS24076
		,65546756	--SampleSiteUUS24077
		,65546759	--SampleSiteUUS24078
		,65546760	--SampleSiteUUS24079
		,65546762	--SampleSiteUUS24080
		,65546765	--SampleSiteUUS24081
		,65546766	--SampleSiteUUS24082
		,65546767	--SampleSiteUUS24083
		,65546771	--SampleSiteUUS24084
		,65546772	--SampleSiteUUS24085
		,65546777	--SampleSiteUUS24086
		,65546781	--SampleSiteUUS24087
		,65546782	--SampleSiteUUS24088
		,65546787	--SampleSiteUUS24089
		,65547070	--SampleSiteUUS24090
		,65547071	--SampleSiteUUS24091
		,65547074	--SampleSiteUUS24092
		,65547077	--SampleSiteUUS24093
		,65547079	--SampleSiteUUS24094
		,65547082	--SampleSiteUUS24095
		,65547084	--SampleSiteUUS24096
		,65547086	--SampleSiteUUS24097
		,65547088	--SampleSiteUUS24098
		,65547091	--SampleSiteUUS24099
		,65547093	--SampleSiteUUS24100
		,65547099	--SampleSiteUUS24101
		,65547100	--SampleSiteUUS24102
		,65547103	--SampleSiteUUS24103
		,65547104	--SampleSiteUUS24104
		,65547110	--SampleSiteUUS24105
		,65547111	--SampleSiteUUS24106
		,65547113	--SampleSiteUUS24107
		,65547114	--SampleSiteUUS24108
		,65547115	--SampleSiteUUS24109
		,65547117	--SampleSiteUUS24110
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

DELETE c
FROM #Member t
INNER JOIN [Dep_Customer_Archived] c WITH(ROWLOCK,UPDLOCK)
	ON t.custid = c.CustID

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status])
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status]
FROM #Member t

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
