/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20231002@Winfred
	DB: DBCUST/CustDB, DBTP-bodb02
	Task:  Allow to offer Parlay Boost on rule setting and add in house replication
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]

	* Only Run SIT
*/

CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOfferDetail_PolicyID] ON [dbo].[CustomerClassUtilityOfferDetail] ( [PolicyID] ASC, [isDeleted] ASC )
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassUtilityOfferDetail_UAT_PolicyID] ON [dbo].[CustomerClassUtilityOfferDetail_UAT] ( [PolicyID] ASC, [isDeleted] ASC )
GO

ALTER TABLE dbo.CustomerClassUtilityOfferDetail  
DROP CONSTRAINT PK_CustomerClassUtilityOfferDetail;   
GO  

sp_rename 'dbo.CustomerClassUtilityOfferDetail.Site', 'SiteID', 'COLUMN';
GO

ALTER TABLE dbo.CustomerClassUtilityOfferDetail
ADD CONSTRAINT PK_CustomerClassUtilityOfferDetail PRIMARY KEY(
		[Currency] ASC,
		[CustomerClass] ASC,
		[SiteID] ASC, 
		[PolicyID] ASC
	)
GO 

ALTER TABLE dbo.CustomerClassUtilityOfferDetail_UAT  
DROP CONSTRAINT PK_CustomerClassUtilityOfferDetail_UAT;   
GO  

sp_rename 'dbo.CustomerClassUtilityOfferDetail_UAT.Site', 'SiteID', 'COLUMN';
GO

ALTER TABLE dbo.CustomerClassUtilityOfferDetail_UAT
ADD CONSTRAINT PK_CustomerClassUtilityOfferDetail_UAT PRIMARY KEY(
		[Currency] ASC,
		[CustomerClass] ASC,
		[SiteID] ASC, 
		[PolicyID] ASC
	)
GO 