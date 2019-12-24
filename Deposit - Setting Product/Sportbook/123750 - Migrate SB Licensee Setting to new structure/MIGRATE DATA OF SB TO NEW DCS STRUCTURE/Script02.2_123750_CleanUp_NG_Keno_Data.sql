/*
	Created: Eden
	Date: 20191029
	Task: Cleanup data New tables for Number Games and Keno [RM:#123750]
	DB: DBCust/CustDB
*/

DELETE FROM Dep_CustBetSetting_Agent WITH(ROWLOCK) WHERE Sporttype IN (161,202) 
DELETE FROM Dep_CustBetSetting_Member WITH(ROWLOCK) WHERE Sporttype IN (161,202)
DELETE FROM Dep_CustBetSettingGame_Agent WITH(ROWLOCK) WHERE Sporttype IN (161,202) 
DELETE FROM Dep_CustBetSettingGame_Member WITH(ROWLOCK) WHERE Sporttype IN (161,202)
DELETE FROM Dep_CustPTSetting_Agent WITH(ROWLOCK) WHERE Sporttype IN (161,202)  
DELETE FROM Dep_CustPTSetting_Member WITH(ROWLOCK) WHERE Sporttype IN (161,202) 
DELETE FROM Dep_CustDiscountSetting_Agent WITH(ROWLOCK) WHERE Sporttype IN (161,202)   
DELETE FROM Dep_CustDiscountSetting_Member WITH(ROWLOCK) WHERE Sporttype IN (161,202)  