/*	
	Created: 20191120Eden
	Task: Drop unsused table
	Redmine: https://nexdev.net/issues/118699
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
DROP TABLE DEL_AgentCommRate
DROP TABLE DEL_CustCommRate 

--P2P table was removed from Publication
DROP TABLE DEL_P2PGameSetting
DROP TABLE DEL_P2PGroupComm
DROP TABLE DEL_P2PDefaultSetting
GO