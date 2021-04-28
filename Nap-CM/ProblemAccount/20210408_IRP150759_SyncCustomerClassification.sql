/*
	Created: 20210408@Johnson
	Task: Sync customer classification from CTS
	DB: DBCUST/CustDB
*/
--deploy these tables on DBCUST/CustDB
-- then setup replication for table ProblemAccountClassification & CategoryConfig
-- under pub DBCUST_CustSetting
CREATE TABLE ProblemAccountClassification (custid INT NOT NULL, 
	IsReviewed BIT, 
	ModifiedDate DATETIME
	CONSTRAINT [PK_ProblemAccountClassification] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]
GO

CREATE NONCLUSTERED INDEX [IX_ProblemAccountClassification_ModifiedDate] ON [dbo].[ProblemAccountClassification] 
(
	[ModifiedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
GO

CREATE TABLE CategoryConfig (CategoryID SMALLINT NOT NULL, 
	CategoryName VARCHAR(100)
	CONSTRAINT [PK_CategoryConfig] PRIMARY KEY CLUSTERED 
	(
		[CategoryID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

-----------------------------------------------------------
--setup on dbcust only for this table
CREATE TABLE CustCategoryHistory (LogID BIGINT IDENTITY(1,1) NOT NULL,
	custid INT NOT NULL, 
	CategoryID SMALLINT NULL, 
	CustomerClass SMALLINT NULL,
	CreatedDate DATETIME
	CONSTRAINT [PK_CustCategoryHistory] PRIMARY KEY CLUSTERED 
	(
		[LogID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]
GO


CREATE NONCLUSTERED INDEX [IX_CustCategoryHistory_CreatedDate] ON [dbo].[CustCategoryHistory] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
GO
--end setup DBCUST/CustDB
-------------------------------------------------------------------------------------


--Setup structure store old data for CustCategoryHistory 
--at DBLOG.bodb_CustomerLog
USE bodb_CustomerLog
GO

ALTER DATABASE bodb_CustomerLog
ADD FILEGROUP CustCategoryHistory;
GO

ALTER DATABASE bodb_CustomerLog
ADD FILE
(
    NAME = CustCategoryHistory,
	--local path
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\CustCategoryHistory_1.ndf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10240KB 
)
TO FILEGROUP CustCategoryHistory;
GO

CREATE TABLE CustCategoryHistory_Old (LogID BIGINT NOT NULL,
	custid INT NOT NULL, 
	CategoryID SMALLINT NULL, 
	CustomerClass SMALLINT NULL,
	CreatedDate DATETIME,
	UpdatedTime DATETIME
	CONSTRAINT [PK_CustCategoryHistory] PRIMARY KEY CLUSTERED 
	(
		[LogID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [CustCategoryHistory]
) ON [CustCategoryHistory]
