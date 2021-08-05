/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210805@Johnson
	Task: update bet limit for licensee Happy8	
	DB: DBCust/CustDB
*/
ALTER PROCEDURE [dbo].Acc_ExecRep_Cust_19
	@custids VARCHAR(MAX)	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	
	CREATE TABLE #tblCust (custid1 INT PRIMARY KEY, custid2 INT)
	
	DECLARE @xml XML = CAST (@custids as XML)
	
	INSERT INTO #tblCust(custid1,custid2)
	SELECT T.c.query('.').value('(r/@id1)[1]', 'int') AS id1,
	T.c.query('.').value('(r/@id2)[1]', 'int') AS id2
	FROM   @xml.nodes('/Root/r') T(c)  
	
	UPDATE cs2
	SET cs2.maxpermatch = cs1.maxpermatch,
		cs2.maxpermatch2 = cs1.maxpermatch2,
		cs2.maxpermatch3 = cs1.maxpermatch3,
		cs2.maxpermatch5 = cs1.maxpermatch5,
		cs2.maxpermatch8 = cs1.maxpermatch8,
		cs2.maxpermatch10 = cs1.maxpermatch10,
		cs2.maxpermatch11 = cs1.maxpermatch11,
		cs2.maxpermatch1MP = cs1.maxpermatch1MP,
		cs2.maxpermatch99 = cs1.maxpermatch99,
		cs2.MaxPerMatch99MP = cs1.MaxPerMatch99MP
	FROM custinfo cs2 WITH(ROWLOCK)
		INNER JOIN #tblCust t ON cs2.custid = t.custid2
		INNER JOIN custinfo cs1 WITH(NOLOCK) ON cs1.custid = t.custid1													
	
	IF dbo.f_CheckRepTable('Dep_CustSetting') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN			
	
	UPDATE cs2
	SET cs2.minbet = cs1.minbet,
		cs2.maxbet = cs1.maxbet
	FROM Dep_CustSetting cs2 WITH(ROWLOCK)
		INNER JOIN #tblCust t ON cs2.custid = t.custid2
		INNER JOIN Dep_CustSetting cs1 WITH(NOLOCK) ON cs1.custid = t.custid1
													AND cs1.sporttype = cs2.sporttype
													AND cs1.bettype = cs2.bettype
													AND cs1.islive = cs2.islive
	
	UPDATE cs2
	SET cs2.minbet = cs1.minbet,
		cs2.maxbet = cs1.maxbet,
		cs2.maxpermatch = cs1.maxpermatch
	FROM Dep_CustBetSetting_Member cs2 WITH(ROWLOCK)
		INNER JOIN #tblCust t ON cs2.custid = t.custid2
		INNER JOIN Dep_CustBetSetting_Member cs1 WITH(NOLOCK) ON cs1.custid = t.custid1
													AND cs1.sporttype = cs2.sporttype
													AND cs1.bettype = cs2.bettype																								
	WHERE cs2.sporttype = 43
	
	DROP TABLE #tblCust
END

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #tmpCust (custidM88 INT PRIMARY KEY, custidH8 INT, isFinished BIT DEFAULT 0)

declare @string varchar(max) =
'41847751CC50723153,
39024073CC49271648,
41939668CC49237496,
41939814CC49271887,
38951028CC49237561'

SELECT val
INTO #temp
FROM dbo.f_SplitString(@string, ',')
OPTION (MAXRECURSION 0)

SELECT LEFT(LTRIM(val), CHARINDEX('CC', val) - 1) AS custidM88, RIGHT (val, len (val) - (CHARINDEX('CC', val) + 1) ) AS custidH8
INTO #tblCust2
FROM #temp

INSERT INTO #tmpCust(custidM88,custidH8)
select replace (replace(replace(custidM88,char(9),''),char(13),''),char(10),'') as custidM88, replace (replace(replace(custidH8,char(9),''),char(13),''),char(10),'') as custidH8
from #tblCust2


DECLARE @custids VARCHAR(MAX) = ''
DECLARE @tmp TABLE (custidM88 INT,custidH8 INT)

WHILE(1=1)
BEGIN		
	DELETE @tmp	
	
	UPDATE TOP(500) t	
	SET isFinished = 1
	OUTPUT DELETED.custidM88, DELETED.custidH8 INTO @tmp(custidM88,custidH8)
	FROM #tmpCust t
	WHERE isFinished = 0
	
	IF @@rowcount = 0
		BREAK;
		
	SELECT @custids =(
		SELECT custidM88 as '@id1', custidH8 '@id2'
		FROM @tmp
		FOR XML PATH('r'), ROOT('Root')
	)
	
	EXEC Acc_ExecRep_Cust_19 @custids = @custids,
							@target = 'REPLICATED'--change target = 'DBCUST' if run on DBCUST
	
	WAITFOR DELAY '0:0:0.028'						
	
END
--END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------


