/*
	Created: 20200706@Eden
	Task: Delete data of Basketball from Sport_Bettype_Reference_VirtualRate [Redmine: #134978]
	DB: DBTXN/bodb02
*/
USE bodb02
GO
DELETE vr
FROM dbo.Sport_Bettype_Reference_VirtualRate vr WITH(ROWLOCK) 
WHERE sporttype = 2