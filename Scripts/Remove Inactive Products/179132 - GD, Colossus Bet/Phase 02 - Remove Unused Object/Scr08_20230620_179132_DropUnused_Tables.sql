/*<info serverAlias="DBCUST-CustDB, DBACC-bodb02, DBTP-bodb02"></info>*/
/*	
	Created: 20230620@Tacy
	Task: Rename unused Tables
			Dep_AgentCommRate
			Dep_CustCommRate
	Redmine: https://nexdev.net/issues/179132
	DB: DBCUST-CustDB, DBACC-bodb02, DBTP-bodb02
*/
USE CustDB
GO 

--Drop unused Tables
DROP TABLE Dep_AgentCommRate
DROP TABLE Dep_CustCommRate 
GO