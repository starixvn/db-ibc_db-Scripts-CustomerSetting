/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220404
    Task: archive some UUS members : [#125823]
				 62451611 --Athena000UUS011905184
				,62451616 --Athena000UUS011905186
				,62451621 --Athena000UUS011905188
				,62451627 --Athena000UUS011905190
				,62451634 --Athena000UUS011905192
				,62451586 --Athena000UUS011905176
				,62451646 --Athena000UUS011905195
				,62451662 --Athena000UUS011905197
				,62451671 --Athena000UUS011905199
				,62451679 --Athena000UUS011905201
				,62451685 --Athena000UUS011905203
				,62451687 --Athena000UUS011905204
				,62451595 --Athena000UUS011905179
				,62451600 --Athena000UUS011905181
				,62451607 --Athena000UUS011905183
				,62451576 --Athena000UUS011905175
				,62451612 --Athena000UUS011905185
				,62451617 --Athena000UUS011905187
				,62451624 --Athena000UUS011905189
				,62451630 --Athena000UUS011905191
				,62451636 --Athena000UUS011905193
				,62451640 --Athena000UUS011905194
				,62451649 --Athena000UUS011905196
				,62451667 --Athena000UUS011905198
				,62451676 --Athena000UUS011905200
				,62451683 --Athena000UUS011905202
				,62451589 --Athena000UUS011905177
				,62451591 --Athena000UUS011905178
				,62451599 --Athena000UUS011905180
				,62451604 --Athena000UUS011905182
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
	 62451611 --Athena000UUS011905184
	,62451616 --Athena000UUS011905186
	,62451621 --Athena000UUS011905188
	,62451627 --Athena000UUS011905190
	,62451634 --Athena000UUS011905192
	,62451586 --Athena000UUS011905176
	,62451646 --Athena000UUS011905195
	,62451662 --Athena000UUS011905197
	,62451671 --Athena000UUS011905199
	,62451679 --Athena000UUS011905201
	,62451685 --Athena000UUS011905203
	,62451687 --Athena000UUS011905204
	,62451595 --Athena000UUS011905179
	,62451600 --Athena000UUS011905181
	,62451607 --Athena000UUS011905183
	,62451576 --Athena000UUS011905175
	,62451612 --Athena000UUS011905185
	,62451617 --Athena000UUS011905187
	,62451624 --Athena000UUS011905189
	,62451630 --Athena000UUS011905191
	,62451636 --Athena000UUS011905193
	,62451640 --Athena000UUS011905194
	,62451649 --Athena000UUS011905196
	,62451667 --Athena000UUS011905198
	,62451676 --Athena000UUS011905200
	,62451683 --Athena000UUS011905202
	,62451589 --Athena000UUS011905177
	,62451591 --Athena000UUS011905178
	,62451599 --Athena000UUS011905180
	,62451604 --Athena000UUS011905182
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
