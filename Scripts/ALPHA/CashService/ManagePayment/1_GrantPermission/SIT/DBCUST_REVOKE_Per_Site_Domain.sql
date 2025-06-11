/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]   
	DB: DBCUST-CustDB
*/

REVOKE SELECT ON OBJECT::dbo.[Site] TO wsv_CashService;
REVOKE SELECT ON OBJECT::dbo.[Site] TO asv_CashService;

REVOKE SELECT ON OBJECT::dbo.[DomainManagement] TO wsv_CashService;
REVOKE SELECT ON OBJECT::dbo.[DomainManagement] TO asv_CashService;

ALTER VIEW [dbo].[DomainManagement]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]
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
	FROM GlobCustDB.dbo.DomainManagement
GO