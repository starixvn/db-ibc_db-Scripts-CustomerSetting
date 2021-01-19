/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210119@Eden
	Task: Disable WHD Super [RM#130032]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

UPDATE c
SET c.closed = 1,
	c.Enabled = 0
FROM Custinfo c WITH(ROWLOCK)
WHERE c.username = 'WHD' 
	AND c.custid = 18901606