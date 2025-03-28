/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Count Data For Init Script [#221908] 
	DB: DBCust/CustDB
*/

SELECT  'BetLimitControlCustSetting' AS TableName , COUNT(blccs.CustID) AS Count
FROM BetLimitControlCustSetting blccs WITH (NOLOCK)
LEFT JOIN Customer c ON blccs.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'RobotList' AS TableName, COUNT(a.CustID) AS Count
FROM RobotList a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'VRAgentAutoAdjustment' AS TableName, COUNT(a.AgentID) AS Count
FROM VRAgentAutoAdjustment a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.AgentID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'VRCustAutoAdjustment' AS TableName, COUNT(a.CustID) AS Count
FROM VRCustAutoAdjustment a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'VRCustLockStatus' AS TableName, COUNT(a.CustID) AS Count
FROM VRCustLockStatus a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'VRCustSetting' AS TableName, COUNT(a.CustID) AS Count
FROM VRCustSetting a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'VRMemberBigStake' AS TableName, COUNT(a.CustID) AS Count
FROM VRMemberBigStake a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'VRSettingManualUpdAcc' AS TableName, COUNT(a.CustID) AS Count
FROM VRSettingManualUpdAcc a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'WinLimit_CustGameMonitoring' AS TableName, COUNT(a.CustID) AS Count
FROM WinLimit_CustGameMonitoring a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'WinLimit_CustGameMonitoring_History' AS TableName, COUNT(a.CustID) AS Count
FROM WinLimit_CustGameMonitoring_History a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL

UNION ALL

SELECT 'WinLimit_CustGameStatus' AS TableName, COUNT(a.CustID) AS Count
FROM WinLimit_CustGameStatus a WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON a.CustID = c.custid
WHERE c.custid IS NULL;
