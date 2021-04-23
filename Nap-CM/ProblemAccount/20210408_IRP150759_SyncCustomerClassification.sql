/*
	Created: 20210408@Johnson
	Task: Sync customer classification from CTS
	DB: DBCUST/CustDB
*/

CREATE TABLE ProblemAccountClassification (custid INT NOT NULL, 
	IsReviewed BIT, 
	ModifiedDate DATETIME
	CONSTRAINT [PK_ProblemAccountClassification] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]
GO


CREATE TABLE CategoryConfig (CategoryID SMALLINT NOT NULL, 
	CategoryName VARCHAR(100)
	CONSTRAINT [PK_CategoryConfig] PRIMARY KEY CLUSTERED 
	(
		[CategoryID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE CustCategoryHistory (LogID BIGINT IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
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

