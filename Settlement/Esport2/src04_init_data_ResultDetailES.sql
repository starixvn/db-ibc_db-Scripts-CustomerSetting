/*
	Created: Vicky
	Task: moving data of esport to new table ResultDetailES
	DB: DBPRO/bodb02
	Date: 20180912
*/
USE [bodb02]
GO

INSERT INTO ResultDetailES(Matchid, ResourceID, HomeValue, AwayValue, ResultStatusID, SettlementStatusID, CreateBy, CreateDate, LastModifyBy, LastModifyDate)
SELECT Matchid, '00', finalhomescore, finalawayscore

	, CASE WHEN eventstatus = 'running' THEN 0 ELSE 5 END AS ResultStatusID
		
	, CASE  WHEN eventstatus = 'completed' AND betstatus LIKE 'Refund%' THEN 1
			WHEN eventstatus = 'completed' THEN 4
			ELSE 0 END
		AS SettlementStatusID
	,creator, kickofftime, creator, changetime
FROM Match
WHERE Sporttype = 43 AND eventstatus <> 'running'
	AND matchid NOT EXISTS (SELECT matchid FROM ResultDetailES)
	
	
	

INSERT INTO ResultDetailES14(Matchid, ResourceID, HomeValue, AwayValue, ResultStatusID, SettlementStatusID, CreateBy, CreateDate, LastModifyBy, LastModifyDate)
SELECT Matchid, '00', finalhomescore, finalawayscore

	, CASE WHEN eventstatus = 'running' THEN 0 ELSE 5 END AS ResultStatusID
		
	, CASE  WHEN eventstatus = 'completed' AND betstatus LIKE 'Refund%' THEN 1
			WHEN eventstatus = 'completed' THEN 4
			ELSE 0 END
		AS SettlementStatusID
	,creator, kickofftime, creator, changetime
FROM Match
WHERE Sporttype = 43 AND eventstatus <> 'running'
	AND matchid NOT EXISTS (SELECT matchid FROM ResultDetailES14)	
	
	