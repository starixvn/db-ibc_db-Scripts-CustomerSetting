/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/AgencyCashService
*/
USE [AgencyCashService]
GO
/*Site*/
CREATE VIEW [dbo].[Site]
AS
	SELECT   siteid 
		, site 
		, type 
		, spreada 
		, spreadb 
		, spreadc 
		, spreadd 
		, spreade 
		, spreadf 
		, ServerID 
		, isLicensee 
		, isActive 
		, isDeposit 
		, SpecialGroup 
		, BlockNewCust 
		, UnblockTime 
		, IsChinaView 
		, RepUpdateTime 
		, SiteDBGroupID 
		, SiteLabel 
		, SpecialPlatfrom 
		, CustDBGroupID 
		, SiteType 
	FROM GlobCustDB.dbo.Site
GO

/*DomainManagement*/
CREATE VIEW [dbo].[DomainManagement]
AS
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

--Grant Permission
GRANT SELECT ON dbo.Site TO wsv_CashService;

GRANT SELECT ON dbo.DomainManagement TO wsv_CashService;

--GRANT SELECT ON dbo.Custinfo TO wsv_CashService;
--REVOKE SELECT ON dbo.Custinfo TO wsv_CashService;

--Grant Permission
--USE GlobCustDB
--GRANT SELECT ON dbo.Site TO wsv_CashService;
--GRANT SELECT ON dbo.DomainManagement TO wsv_CashService;