/*<info serverAlias="DBAGE-bodb_AGE"></info>*/
/*
	Created: 20250515@Dave
	Task: Credit - Saba Soccer Marble Spinner [Redmine: #223130]
	DB: DBAGE.bodb_AGE
*/
USE [bodb_AGE]
GO

UPDATE dbo.SystemSettings
SET VValue = '42,74,108,113,122,151,252'
WHERE VName = 'SabaLeagueGroupAll';

