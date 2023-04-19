/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221223@Tacy
	Task: Update new sites (yUT, y789, y889, yOther) for NEW customers belong to Healines - PRO
		 https://nexdev.net/issues/181596 [RedmineID: #181596]

	Revision:
		- 20230418@Tacy: BUG - get headline site='789y' --> Correct: sitelabel = '789y'

	Database: DBCUST/CustDB
*/
/*
	- @site='yUT', @Headline_List='ZU01'
	- @site='y789', @Headline_List='ET789HL'
	- @site='y889', @Headline_List='BC1,SD67,DTF233,8U01,V3901,8K01,DTE113,DTE131,ET889HL,DTE249,XU1,9S'
	- @site='yOther'
*/
IF OBJECT_ID('tempdb..#Cust_Headline') IS NOT NULL
	DROP TABLE	#Cust_Headline;

IF OBJECT_ID('tempdb..#Customer') IS NOT NULL
	DROP TABLE	#Customer;

IF OBJECT_ID('tempdb..#Customer_tmp') IS NOT NULL
	DROP TABLE	#Customer;

CREATE TABLE #Cust_Headline (
		custid			INT PRIMARY KEY, 
		roleid			TINYINT, 
		headline		VARCHAR(100),
		newSite			VARCHAR(50)
)

CREATE TABLE #Customer (
		custid			INT PRIMARY KEY, 
		roleid			TINYINT, 
		newSite			VARCHAR(50)
)

CREATE TABLE #Customer_tmp (
		custid			INT PRIMARY KEY, 
		roleid			TINYINT, 
		newSite			VARCHAR(50)
)

DECLARE @max_custid INT, @Batch INT

SET @Batch=2000

SELECT @max_custid = xxx

INSERT INTO #Cust_Headline (custid, roleid, headline, newSite)
SELECT  ca.custid, c.roleid, ch.username headline,		CASE	WHEN ch.username='ZU01'				THEN 'yUT'              --Group 1
				WHEN ch.username='ET789HL'			THEN 'y789'             --Group 3
				WHEN ch.username IN ('BC1','SD67','DTF233','8U01','V3901','8K01','DTE113','DTE131','ET889HL','DTE249','XU1','9S')
                                                    THEN 'y889'             --Group 2
                                                    ELSE 'yOther'			--Group 4		END AS newSite FROM custAccount ca WITH (NOLOCK)						INNER JOIN customer  c WITH (NOLOCK) ON c.custid=ca.custid			INNER JOIN Site s WITH (NOLOCK) ON s.site=c.site	LEFT JOIN CustGroupHeadline h WITH (NOLOCK) ON h.GroupID = ca.groupID					LEFT JOIN Customer ch WITH (NOLOCK) ON ch.custid = h.CustID				WHERE s.SiteLabel='789y'	--BUG: c.site='789y'						AND c.currency<>20					AND ca.groupID<>0
--Get all customers with CustID > @max_custid:--roleid=4INSERT INTO #Customer(custid, newSite, roleid)SELECT c.custid, hl.newSite, c.roleidFROM Customer c WITH (NOLOCK)INNER JOIN #Cust_Headline hl ON c.srecommend=hl.custIDWHERE hl.roleid=4	AND c.custid > @max_custid--roleid=3INSERT INTO #Customer(custid, newSite, roleid)SELECT c.custid, hl.newSite, c.roleidFROM Customer c WITH (NOLOCK)INNER JOIN #Cust_Headline hl ON c.mrecommend=hl.custIDWHERE hl.roleid=3	AND c.custid > @max_custid--roleid=2INSERT INTO #Customer(custid, newSite, roleid)SELECT c.custid, hl.newSite, c.roleidFROM Customer c WITH (NOLOCK)INNER JOIN #Cust_Headline hl ON c.recommend=hl.custIDWHERE hl.roleid=2	AND c.custid > @max_custid--roleid=1INSERT INTO #Customer(custid, newSite, roleid)SELECT c.custid, hl.newSite, c.roleidFROM Customer c WITH (NOLOCK)INNER JOIN #Cust_Headline hl ON c.custid=hl.custIDWHERE hl.roleid=1	AND c.custid > @max_custid
--Update Site:
WHILE EXISTS (SELECT 1 FROM #Customer)
BEGIN
	DELETE FROM #Customer_tmp

	DELETE TOP (@Batch) #Customer 
	OUTPUT deleted.custid, deleted.newSite, deleted.roleid
	INTO #Customer_tmp(custid, newSite, roleid)

	IF @@ROWCOUNT = 0
		BREAK;
	
	UPDATE c
	SET site = t.newSite
	FROM CustAgent c WITH(UPDLOCK, ROWLOCK)
	INNER JOIN #Customer_tmp t ON t.custid=c.custid
	WHERE t.roleid=2

	UPDATE c
	SET site = t.newSite
	FROM Customer c WITH(UPDLOCK, ROWLOCK)
	INNER JOIN #Customer_tmp t ON t.custid=c.custid
END

DROP TABLE #Cust_Headline, #Customer, #Customer_tmp

GO