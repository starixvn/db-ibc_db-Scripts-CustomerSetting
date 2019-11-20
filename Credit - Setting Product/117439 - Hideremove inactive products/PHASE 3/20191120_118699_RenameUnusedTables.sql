/*	
	Created: 20191120Eden
	Task: Rename unsused table
	Redmine: https://nexdev.net/issues/118699
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/

EXEC sp_rename 'AgentCommRate','DEL_AgentCommRate'
EXEC sp_rename 'CustCommRate ','DEL_CustCommRate'
EXEC sp_rename 'P2PGameSetting ','DEL_P2PGameSetting'
EXEC sp_rename 'P2PGroupComm ','DEL_P2PGroupComm'
GO
