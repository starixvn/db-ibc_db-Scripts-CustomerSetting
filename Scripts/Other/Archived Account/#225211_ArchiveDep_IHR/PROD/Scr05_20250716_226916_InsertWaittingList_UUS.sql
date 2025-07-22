/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20250716@Tacy
    Task: archive members UUS : [#226916]

        Athena000UUS011904495
        Athena000UUS011904497
        Athena000UUS011904498
        Athena000UUS011904504
        Athena000UUS011904512
        Athena000UUS011904513
        Athena000UUS011904520
        Athena000UUS011904521
        Athena000UUS011905161
        Athena000UUS011905162
        Athena000UUS011905163
        Athena000UUS011905164
        Athena000UUS011905165

    DB: DBCUST/CustDB
*/ 

---------------------------Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------
USE CustDB
GO
--Check LinkedServer
SELECT TOP 1 1 AS CheckLinkedServer FROM _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1 UNION ALL
SELECT TOP 1 1						FROM _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1

IF @@ERROR <> 0
	RETURN

--TRUNCATE TABLE Dep_Customer_Archived_Config -- avoid scan current agent on PRODUCTION config

--> Delete waiting agents before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'

DELETE d
OUTPUT deleted.CustID, dbo.f_GetDateTime2()
INTO Dep_Customer_Archived_Del_InHouse (CustID, RepUpdateTime)
FROM  Dep_Customer_Archived d WITH(ROWLOCK)  
	INNER JOIN #TempDeleted t
		ON t.CustID = d.CustID

-- Add List UUS
SELECT   c.[CustID]
		,[ArchivedDate] = GETDATE()
		,[Username] =  c.username
		,[Username2] = c.username2
		,[Recommend] = c.recommend
		,[ClosingBalance] = CAST(0 AS MONEY)
		,[CustIDBalanceDummy] = bal.custid
		,[Status] = 'waiting'
		,ag.username AS Agent
		,s.SiteDBGroupID
		,s.site
		,s.CustDBGroupID
INTO #Member
FROM Customer c WITH(NOLOCK)
	LEFT JOIN Customer bal WITH(NOLOCK) 
		ON bal.recommend = c.recommend
		AND bal.username like '%ClearBal'
	INNER JOIN Customer ag WITH(NOLOCK) ON c.recommend = ag.custid
	INNER JOIN Site s WITH(NOLOCK) ON s.site = c.site
WHERE c.username IN (
                         'Athena000UUS011904495'
                        ,'Athena000UUS011904497'
                        ,'Athena000UUS011904498'
                        ,'Athena000UUS011904504'
                        ,'Athena000UUS011904512'
                        ,'Athena000UUS011904513'
                        ,'Athena000UUS011904520'
                        ,'Athena000UUS011904521'
                        ,'Athena000UUS011905161'
                        ,'Athena000UUS011905162'
                        ,'Athena000UUS011905163'
                        ,'Athena000UUS011905164'
                        ,'Athena000UUS011905165'
                    )
	AND c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

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

DELETE d
OUTPUT deleted.CustID, dbo.f_GetDateTime2()
INTO Dep_Customer_Archived_Del_InHouse (CustID, RepUpdateTime)
FROM  Dep_Customer_Archived d WITH(ROWLOCK)  
	INNER JOIN #Member t
		ON t.CustID = d.CustID

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status],RepUpdateTime)
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status],dbo.f_GetDateTime2()
FROM #Member
WHERE CustIDBalanceDummy<>0


DROP TABLE #Member, #TempDeleted
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Run SSIS package ArchiveDepCust_FullStep.dtsx -------------------------------