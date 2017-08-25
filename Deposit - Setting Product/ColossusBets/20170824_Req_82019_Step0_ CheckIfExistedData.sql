/*
	Created: Winnie
	Date: 2017-08-24
	Task: check if existing colossus settings for Leon& Sungame
	DB: DBCUST/CustDB
*/ 

	DECLARE @Sporttype INT
	SELECT @Sporttype=204
	SELECT DISTINCT c.CustID,currency
	FROM dbo.Dep_AgentCommRate cg WITH(NOLOCK)		
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE c.roleid IN(2,3,4) AND SportType = @Sporttype AND srecommend IN (SELECT custid FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
															WHERE cs.site IN  ('Leon','Sungame'))

	SELECT DISTINCT c.CustID,currency
	FROM dbo.Dep_CustCommRate cg WITH(NOLOCK)		
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE c.roleid =1 AND SportType = @Sporttype AND srecommend IN (SELECT custid FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
															WHERE cs.site IN  ('Leon','Sungame'))

