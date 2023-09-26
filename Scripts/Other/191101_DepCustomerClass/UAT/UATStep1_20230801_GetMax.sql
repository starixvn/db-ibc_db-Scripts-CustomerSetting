/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: Winfred
	Date: 20230802
	Task:  Initial table Dep customer class UAT RedmineID:#191101
	DB: DBLOG/bodb_CustomerLog
	Step 1 : Get Max Log and Max Cust
*/

USE [bodb_CustomerLog]
GO

DECLARE @max_custid INT, @MaxLogID BIGINT

SET @max_custid = (SELECT MAX(CustID) FROM bodb02.dbo.custInfo WITH(NOLOCK))
SET @MaxLogID = (SELECT MAX(LogID) FROM UserLog_UserControl WITH(NOLOCK) WHERE logdate > '2023-01-01')

SELECT @max_custid AS max_custid,  @MaxLogID AS MaxLogID

