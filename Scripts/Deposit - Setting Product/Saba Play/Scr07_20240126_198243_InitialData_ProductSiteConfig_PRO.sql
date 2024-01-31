/*<info serverAlias="DBCUST-CustDB, DBTXN-CustDB, DBAGE-bodb02, DBACC-bodb02, DBTP-bodb02"></info>*/
/*
	Created: Tacy@20240126 
	Task: Initial data into table ProductSiteConfig [redmine: #198243]
	DB: All servers belong to publications:
		CustDB_DBTrans_CustInfo -> ReplicatedServers@custdb
		CustDB_Login_Exchange	-> ReplicatedServers@bodb02
*/
INSERT INTO ProductSiteConfig ([SiteID], [ProductID], [RefProductID])
SELECT siteid, 66,82
FROM [Site] WITH (NOLOCK)
WHERE [site] NOT IN ('SWSite','ATHENA000')
GO