/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20231002@Winfred
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name] IN ('CustomerClassUtilityOffer','CustomerClassUtilityOfferDetail','CustomerClassUtilityOffer_UAT','CustomerClassUtilityOfferDetail_UAT')
GO

