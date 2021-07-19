/*
	Created: 20190805@Elodie	
	Task: Prepare structure for problem account 
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

DELETE dbo.ProblemAccountReason

INSERT INTO ProblemAccountReason (ReasonID, ReasonName)	
VALUES (1, 'Abnormal(M)'),
	(2, 'Group Betting(M)'),
	(3, 'Hedging(M)'),
	(4, 'Arbitrage(M)'),
	(5, 'Fixed Game(M)'),
	(6, 'Others(M)'),
	(27, 'Abnormal'),
	(28, 'Group Betting'),
	(29, 'Hedging'),
	(30, 'Arbitrage'),
	(31, 'Fixed Game')

