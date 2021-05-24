/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/ 
/*
	Created: 20210512@Eden
	Task: Delete testing log of VREngine function [RM#136423]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO
DELETE
FROM dbo.UserLog_RunSP WITH(ROWLOCK,UPDLOCK)
WHERE custid = 0 AND actionid in (833,834,835)
