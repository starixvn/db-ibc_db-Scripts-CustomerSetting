/*	
	Created: 20191120Eden
	Task: Rename unsused table (ROLLBACK)
	Redmine: https://nexdev.net/issues/118699
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/

EXEC sp_rename 'DEL_AgentCommRate','AgentCommRate'	
EXEC sp_rename 'DEL_CustCommRate','CustCommRate'	
--EXEC sp_rename 'DEL_P2PGameSetting','P2PGameSetting'
--EXEC sp_rename 'DEL_P2PGroupComm','P2PGroupComm'	
--EXEC sp_rename 'DEL_P2PDefaultSetting','P2PDefaultSetting'	
GO
