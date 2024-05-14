/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240515@Johnson
	Task:Update CWL [redmine: #204108]
	DB: DBCUST/CUSTDB	
*/ 

UPDATE WinLimit_CustGameStatus WITH(rowlock) 
SET IsBlockedTransfer = 0,
	IsBlockedPlaceBet = 0	
where custid=18424992 