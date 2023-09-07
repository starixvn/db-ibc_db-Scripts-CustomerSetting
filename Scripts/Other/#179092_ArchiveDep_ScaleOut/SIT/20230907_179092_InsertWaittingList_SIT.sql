/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20230907
    Task: archive members on SIT : [#179092]
		Athena000$VNTest9Jun1
		Athena000$VNTest9Jun2
		Athena000$VNTest6Aug20201
		Athena000$VNTest6Aug20202
		Athena000$VNTest6Aug20203
    DB: DBCUST/CustDB
*/ 

---------------------------Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------
USE CustDB
SELECT   c.[CustID]
		,[ArchivedDate] = GETDATE()
		,[Username] =  c.username
		,[Username2] = c.username2
		,[Recommend] = c.recommend
		,[ClosingBalance] = 0
		,[CustIDBalanceDummy] = bal.custid
		,[Status] = 'waiting'
INTO #Member
FROM Customer c WITH(NOLOCK)
	INNER JOIN Customer bal WITH(NOLOCK) 
		ON bal.recommend = c.recommend
		AND bal.username like '%ClearBal'
WHERE c.username2 IN (
	 'Athena000$VNTest9Jun1'
	,'Athena000$VNTest9Jun2'
	,'Athena000$VNTest6Aug20201'
	,'Athena000$VNTest6Aug20202'
	,'Athena000$VNTest6Aug20203'
)

--Update ClosingBalance
UPDATE #Member 
SET [ClosingBalance] = b.MemberBalance
FROM #Member
INNER JOIN (
	SELECT custid, ISNULL(SUM(winlost-actual_stake+playercomm),0) as MemberBalance
	FROM DBACC.bodb02.dbo.bettrans WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #Member)
	GROUP BY custid
	) b ON #Member.custid = b.custid

INSERT INTO [dbo].[Dep_Customer_Archived]([CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status])
SELECT [CustID],[ArchivedDate],[Username],[Username2],[Recommend],[ClosingBalance],[CustIDBalanceDummy],[Status]
FROM #Member

DROP TABLE #Member
GO
---------------------------END Step 1 (DBCUST/CUSTDB) : Insert members to waiting list -------------------------------

---------------------------Step 2 : Run SSIS package ArchiveDepCust_FullStep.dtsx -------------------------------