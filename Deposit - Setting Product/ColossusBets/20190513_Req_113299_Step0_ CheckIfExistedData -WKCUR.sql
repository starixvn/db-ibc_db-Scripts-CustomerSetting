/*
	Created: Winnie
	Date: 2019-05-13
	Task: check if existing colossus settings for WKCUR RedmineID: #113299
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO 

DECLARE @Sporttype SMALLINT

SELECT @Sporttype = 204

SELECT DISTINCT c.CustID,currency
FROM dbo.Dep_AgentCommRate cg WITH(NOLOCK)		
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
WHERE c.roleid IN (2,3,4) AND SportType = @Sporttype 
	AND srecommend IN (	SELECT custid 
						FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
						WHERE cs.site ='WKCUR' AND cs.currency IN (4,13,20,51))

SELECT DISTINCT c.CustID,currency
FROM dbo.Dep_CustCommRate cg WITH(NOLOCK)		
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
WHERE c.roleid = 1 AND SportType = @Sporttype 
	AND srecommend IN (	SELECT custid 
						FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
						WHERE cs.site  ='WKCUR' AND cs.currency IN (4,13,20,51))
