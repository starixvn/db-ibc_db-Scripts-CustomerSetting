/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240117@Helios
	Task: SIT - Support clean up data Setting MEMBER of AgentID = 24958237 for QC Testing [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/


	CREATE TABLE #Tmp_CustList
	(
		CustID	INT
	)


	INSERT INTO #Tmp_CustList (CustID)
	SELECT c.custid
	FROM Customer c WITH (NOLOCK)
	WHERE c.recommend = 24958237
	AND c.roleid = 1


	DELETE s
	FROM custSetting s WITH (ROWLOCK)
	INNER JOIN #Tmp_CustList tcl ON s.custid = tcl.CustID

	DELETE s
	FROM custOverride s WITH (ROWLOCK)
	INNER JOIN #Tmp_CustList tcl ON s.custid = tcl.CustID

	DELETE s
	FROM CustCommRate s WITH (ROWLOCK)
	INNER JOIN #Tmp_CustList tcl ON s.custid = tcl.CustID



	
	DROP TABLE #Tmp_CustList
