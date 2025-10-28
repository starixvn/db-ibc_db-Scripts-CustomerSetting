/*<info serverAlias="DBCUST-CustDB"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBCust/CustDB
*/
USE [CustDB];
GO
CREATE VIEW [dbo].[SportBettypeSettingMatrix_UAT]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, isLicensee 
		, isLive 
		, Site 
		, isActive 
		, SportTypeRefPT 
		, BetTypeRefPT 
		, isLivePT 
		, TablePT 
		, SportTypeRefComm 
		, BetTypeRefComm 
		, TableComm 
		, SportTypeRefBetSetting 
		, BetTypeRefBetSetting 
		, TableBetSetting 
		, IsLiveComm 
		, IsLiveBetSetting 
		, TableBettrans 
		, SporttypeRefWinlossLimit 
		, BettypeRefWinlossLimit 
		, RealProductId 
		, isDeleted 
		, RepUpdateTime 
		, ProductID 
	FROM GlobCustDB.dbo.SportBettypeSettingMatrix_UAT;
GO
