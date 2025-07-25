/*<info serverAlias="DBCUST-CustDB,IRS_DBSIC-CustDB,IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250724@Johnson	
	Task: Potential Winning Limit - Phase 3 - Sprint 1 (Include Parlay) [redmine:#233805]
	DB: DBCUST-CustDB
*/
ALTER TABLE [dbo].[CustPotentialWinLimit] ADD OfferOption TINYINT NULL
GO