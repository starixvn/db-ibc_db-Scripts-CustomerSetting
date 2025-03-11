/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBPRO-bodb02,DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBPRO-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related: ProductSiteConfig			
*/
CREATE TYPE [dbo].[TVP_ReplProductSiteConfig] AS TABLE (
	[SiteID] [INT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[RefProductID] [TINYINT] NOT NULL
	,[AffectedDate] [DATE] NOT NULL
	,[Environment] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductSiteConfig] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




