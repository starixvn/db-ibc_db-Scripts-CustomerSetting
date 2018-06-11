/*
	Created: Winnie
	Date: 2018-06-11
	Task: check if existing colossus settings for VCBA RedmineID: #96741
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
						WHERE cs.site ='VCBA' AND cs.currency IN (20,13))

SELECT DISTINCT c.CustID,currency
FROM dbo.Dep_CustCommRate cg WITH(NOLOCK)		
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
WHERE c.roleid = 1 AND SportType = @Sporttype 
	AND srecommend IN (	SELECT custid 
						FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
						WHERE cs.site  ='VCBA' AND cs.currency IN (20,13))
