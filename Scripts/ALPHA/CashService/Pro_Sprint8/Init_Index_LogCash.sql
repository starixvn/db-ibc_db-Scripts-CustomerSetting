/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" viewers=""></info>*/
/*
      Task:         Alpha - Agency Cash Service - Create Index for Cash_UserLog_RunSP [#235266]
      DB:           DBLOG-bodb_CustomerLog
      Created:      20250815@Helios
*/

--BASE ON TABLE : UserLog_RunSP

-- Clustered index
CREATE CLUSTERED INDEX IX_Cash_UserLog_RunSP
ON dbo.Cash_UserLog_RunSP (custid, logdate);

-- Nonclustered index: ActionID, custid, include logdate
CREATE NONCLUSTERED INDEX IX_Cash_ActionID_Custid
ON dbo.Cash_UserLog_RunSP (ActionID, custid) 
INCLUDE (logdate);

-- Nonclustered index: spname, custid, include logdate
--CREATE NONCLUSTERED INDEX IX_Cash_SPname_Custid
--ON dbo.Cash_UserLog_RunSP (spname, custid)
--INCLUDE (logdate);

-- Nonclustered index: logid
--CREATE NONCLUSTERED INDEX IF_Cash_LogID
--ON dbo.Cash_UserLog_RunSP (logid);