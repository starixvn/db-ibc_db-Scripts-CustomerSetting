/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20231002@Winfred
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
          - 20231002@Winfred: NAP CM Customer Class - Support for Non-Sports [RedmineID: #186116] 
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name] IN ('CustomerClassNonSports','CustomerClassNonSportsDetail','CustomerClassNonSports_UAT','CustomerClassNonSportsDetail_UAT')
GO

