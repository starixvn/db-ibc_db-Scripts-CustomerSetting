/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200918@Eden
	Task: Update VR0_Date for Agents with status = 2 [RM#141927]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

UPDATE v
SET v.VR0_Date = l.logdate
FROM [dbo].[VRAgentAutoAdjustment] v WITH(ROWLOCK)
	INNER JOIN dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK) ON v.AgentID = l.custid
WHERE v.Status = 2
	AND l.ActionID = 822