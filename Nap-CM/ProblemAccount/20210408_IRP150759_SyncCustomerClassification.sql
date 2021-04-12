/*
	Created: 20210408@Johnson
	Task: Sync customer classification from CTS
	DB: DBCUST/CustDB
*/

CREATE TABLE ProblemAccountClassification (custid INT NOT NULL, 
	IsReviewed BIT NULL, 
	ModifiedDate DATETIME NULL
	CONSTRAINT [PK_ProblemAccountClassification] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
