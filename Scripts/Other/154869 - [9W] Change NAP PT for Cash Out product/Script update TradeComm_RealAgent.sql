/*<info serverAlias="DBCUST-CustDB"></info>*/
 /*
	Created: 20210511@Tina
	Task: [9W] Change NAP PT for Cash Out product [RedmineID:#154869]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

CREATE TABLE #AgentUPD (AgentID INT)


INSERT INTO #AgentUPD(AgentID)
SELECT td.AgentID
FROM TradeComm td WITH (NOLOCK)
	INNER JOIN custInfo ci WITH (NOLOCK) ON td.AgentID = ci.custid
	INNER JOIN Dep_CustSuper ds WITH (NOLOCK) ON ci.srecommend = ds.custid
WHERE ds.[site] = '9W' 


UPDATE td SET td.Licenseecomm = 0.015
FROM TradeComm td WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #AgentUPD ci WITH (NOLOCK) ON td.AgentID = ci.AgentID
WHERE td.IsBA = 0