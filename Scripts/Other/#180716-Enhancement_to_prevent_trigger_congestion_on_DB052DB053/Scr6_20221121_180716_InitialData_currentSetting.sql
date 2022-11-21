/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20221121@Eden
	Task: Initial data for current setting [#180716]
	DB: DBAGE/bodb02
*/
USE bodb02
GO

INSERT INTO dbo.[CustWLMonitored_Setting](custid,recommend)
SELECT s.custid, ci.recommend
FROM DBCUST.CUSTDB.dbo.Dep_WLMonitored_Player s WITH(NOLOCK)
	INNER JOIN custInfo ci WITH(NOLOCK) ON s.custid = ci.custid
	LEFT JOIN [CustWLMonitored_Setting] c WITH(NOLOCK)
		ON s.CustID = c.CustID AND ci.recommend = c.recommend
WHERE c.CustID IS NULL

INSERT INTO dbo.[CustWLMonitored_Setting](custid,recommend)
SELECT s.custid, s.AgentID
FROM DBCUST.CUSTDB.dbo.WLMonitored_Player s WITH(NOLOCK)
	LEFT JOIN [CustWLMonitored_Setting] c WITH(NOLOCK)
		ON s.CustID = c.CustID AND s.AgentID = c.recommend
WHERE c.CustID IS NULL

INSERT INTO dbo.[CustWLMonitored_Setting](custid,recommend)
SELECT 0, s.AgentID
FROM DBCUST.CUSTDB.dbo.WLMonitored_Global s WITH(NOLOCK)
	LEFT JOIN [CustWLMonitored_Setting] c WITH(NOLOCK)
		ON c.CustID = 0 AND s.AgentID = c.recommend
WHERE c.CustID IS NULL
