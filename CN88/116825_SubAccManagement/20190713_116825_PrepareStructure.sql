/*
	Created: 20190715@Elodie	
	Task: Add CS_SubAccManagement table 
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/
USE CustDB
GO

CREATE TABLE CS_SubAccManagement
(
	SubAccId		INT NOT NULL,
	DownlineId		INT NOT NULL
CONSTRAINT [PK_CS_SubAccManagement] PRIMARY KEY CLUSTERED 
(
	SubAccId ASC,
	DownlineId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

