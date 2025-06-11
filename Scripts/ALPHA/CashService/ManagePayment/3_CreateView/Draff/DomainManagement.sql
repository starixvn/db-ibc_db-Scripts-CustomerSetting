/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  ALTER VIEW DomainManagement [223896]  
	DB: DBCUST/CustDB
*/

--DROP VIEW IF EXISTS [CustInfoExtra];

USE CustDB
GO
ALTER VIEW [dbo].[DomainManagement]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]
		- 20250321@Helios: Agency Cash Service [Redmine: #223896]


*/
	SELECT   DomainID 
		, Domain 
		, System 
		, Site 
		, BrandName 
		, Status 
		, ExpiredDate 
		, LastUpdateTime 
		, RestrictedCountries 
		, Remark 
		, isDeleted 
		, RepUpdateTime 
		, OfferType
	FROM GlobCustDB.dbo.DomainManagement
GO

