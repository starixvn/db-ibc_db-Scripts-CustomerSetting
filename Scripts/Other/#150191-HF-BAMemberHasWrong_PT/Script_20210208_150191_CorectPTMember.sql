/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201002@Eden
	Task: Correct SB PT fof BobbetRMB0167059 - BA member [RM#142142]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
UPDATE c
SET c.apositiontaking = 0
FROM dep_custsetting c WITH(ROWLOCK) 
	INNER JOIN Dep_CustBAActive b WITH(NOLOCK) ON c.custid = b.CustId
WHERE c.custid = 40956522