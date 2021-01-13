/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210113@Eden
	Task: Reactive WHD Super [RM#130032]	
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

UPDATE c
SET c.closed = 0,
	c.Enabled = 1
FROM Custinfo c WITH(ROWLOCK)
WHERE c.username = 'WHD' 
	AND c.custid = 18901606