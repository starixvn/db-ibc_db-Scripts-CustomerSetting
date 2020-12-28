/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201228@Eden
	Task: get report for CSD [RM#144903]	
		--Step 1 : Create Procedure
		--Step 2 : exec Procedure to insert data to ArchivedMasterAgent_Stage3 table
	DB: DBCUST/CustDB
*/
--Step 1 : Create Procedure
USE CustDB
GO
CREATE PROCEDURE [Acc_Archive_GetDeletedCustomers]
AS
/*
	Task: Get customer list after stage 3 
	Created: Eden@20201228
	Database: DBCUST.CustDB

	Revisions:
		- 20201228@Eden: Created
		
	Param:
	Example:
		EXEC [Acc_Archive_GetDeletedCustomers]
*/
BEGIN
	TRUNCATE TABLE ArchivedMasterAgent_Stage3

	SELECT DISTINCT custid 
	INTO #Masterlist
	FROM tmpCustGroupLevelArchived WITH(NOLOCK) 
	WHERE GroupLevelName IN ('M1','M0')
	
	SELECT DISTINCT recommend AS CustID
	INTO #AgentList
	FROM tmpCustArchived WITH(NOLOCK) 
	WHERE IsFinished = 1 AND ISNULL(ErrMsg,'') = ''

	INSERT INTO ArchivedMasterAgent_Stage3(CustID,username,Level)
	SELECT s.CustID,
		c.username,
		'Agent' AS [Level]
	FROM #AgentList s 
		INNER JOIN custInfo c WITH(NOLOCK) ON s.CustID = c.custid
	WHERE c.roleid = 2
		AND c.Enabled = 0
		AND NOT EXISTS( SELECT 1 FROM #Masterlist WHERE custid = c.mrecommend)
	UNION ALL 
	SELECT s.CustID,
		c.username,
		'Master' AS [Level]
	FROM #Masterlist s 
		INNER JOIN custInfo c WITH(NOLOCK) ON s.CustID = c.custid
	WHERE c.roleid = 3
		AND c.Enabled = 0

	DROP TABLE #AgentList
	DROP TABLE #Masterlist
END

GO
--Step 2 : exec Procedure
EXEC Acc_Archive_GetDeletedCustomers
GO