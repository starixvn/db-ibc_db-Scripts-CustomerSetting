/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250828@Virgil
	Task: Revise core function report to use SportBettypeMatrix [Redmine: #235369]
	DB: DBPRO-bodb02
*/

ALTER TABLE dbo.SportBettypeMatrix
ADD ExtraInfo VARCHAR(1000) NULL;