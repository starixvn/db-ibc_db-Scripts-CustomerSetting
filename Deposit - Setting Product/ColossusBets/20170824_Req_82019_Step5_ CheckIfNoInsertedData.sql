DECLARE @Sporttype INT
CREATE TABLE #tempBettype(bettype INT, Rate DECIMAL(9,8))

SELECT @Sporttype=204

INSERT INTO #tempBettype(bettype,Rate)
VALUES (18001,0.1215)
INSERT INTO #tempBettype(bettype,Rate)
VALUES (18002,0.45)

SELECT c.Custid,bettype,Rate
INTO #tempSMA
FROM dbo.custInfo c WITH(NOLOCK) 
	CROSS APPLY #tempBettype
WHERE roleid IN(2,3,4) AND srecommend IN (	SELECT custid 
											FROM dbo.Dep_CustSuper cs WITH(NOLOCK)       
											WHERE cs.site IN ('Leon','Sungame','SSSSEA'))

SELECT c.Custid,bettype,Rate
INTO #tempMember
FROM dbo.custInfo c WITH(NOLOCK) 
CROSS APPLY #tempBettype
WHERE roleid =1 AND srecommend IN (	SELECT custid 
									FROM dbo.Dep_CustSuper cs WITH(NOLOCK)       
									WHERE cs.site IN ('Leon','Sungame','SSSSEA'))

SELECT * 
FROM #tempSMA t
	LEFT JOIN dbo.Dep_AgentCommRate cg WITH(NOLOCK) ON t.custid=cg.CustID AND t.bettype=cg.BetType AND cg.SportType = @Sporttype
WHERE cg.CustID IS NULL
	

SELECT * 
FROM #tempMember t
	LEFT JOIN dbo.Dep_CustCommRate cg WITH(NOLOCK) ON t.custid=cg.CustID AND t.bettype=cg.BetType AND cg.SportType = @Sporttype
WHERE cg.CustID IS NULL
	