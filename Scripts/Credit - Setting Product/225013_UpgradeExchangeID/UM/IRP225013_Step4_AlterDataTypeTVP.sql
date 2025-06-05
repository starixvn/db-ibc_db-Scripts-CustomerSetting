/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250428@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
*/
--run on DBCustRepl-ReplCustDB,IRS_DBTP-bodb02
DROP PROCEDURE IF EXISTS Repl_PutCustomer_Dist 
GO

--run on IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
DROP PROCEDURE IF EXISTS Repl_PutCustomer 
GO

DROP TYPE [dbo].[TVP_ReplCustomer]
GO

/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomer] AS TABLE (
	[custid] [INT] NOT NULL
	,[firstname] [NVARCHAR](50) NULL
	,[lastname] [NVARCHAR](50) NULL
	,[address] [NVARCHAR](80) NULL
	,[postal] [NVARCHAR](50) NULL
	,[city] [NVARCHAR](50) NULL
	,[state] [NVARCHAR](50) NULL
	,[country] [NVARCHAR](50) NULL
	,[phone] [NVARCHAR](50) NULL
	,[mobilephone] [NVARCHAR](50) NULL
	,[fax] [NVARCHAR](50) NULL
	,[email] [NVARCHAR](50) NULL
	,[birthday] [SMALLDATETIME] NULL
	,[refcode1] [NVARCHAR](50) NULL
	,[refcode2] [NVARCHAR](50) NULL
	,[remark] [NVARCHAR](50) NULL
	,[creatdate] [SMALLDATETIME] NULL
	,[creator] [INT] NOT NULL
	,[username] [VARCHAR](30) NOT NULL
	,[currency] [SMALLINT] NULL
	,[userpwd] [VARCHAR](40) NULL
	,[lastlogged] [SMALLDATETIME] NULL
	,[pwdexpiry] [DATETIME] NULL
	,[roleid] [TINYINT] NULL
	,[mrecommend] [INT] NULL
	,[recommend] [INT] NULL
	,[ugroup] [VARCHAR](3) NULL
	,[logincount] [TINYINT] NULL
	,[on_sessionid] [INT] NULL
	,[site] [VARCHAR](10) NULL
	,[iplogin] [NVARCHAR](20) NULL
	,[important] [BIT] NULL
	,[srecommend] [INT] NULL
	,[username2] [VARCHAR](50) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomer] TO [repl_ap] AS [dbo]
GO
