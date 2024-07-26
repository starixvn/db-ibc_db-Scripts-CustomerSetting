/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240223
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBCUST/CustDB
*/

ALTER TABLE Cust_LastBetFilter ADD IsNotify BIT NOT NULL DEFAULT(0) WITH VALUES

