/*
	Created: 20190515@Elodie	
	Task: Add CS_CustomerStatus table 
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/
USE CustDB
GO

CREATE TABLE CS_CustomerStatus
(
	CustId			INT NOT NULL,
	InactiveInfo	TINYINT NOT NULL,
	SuspendedInfo	TINYINT NOT NULL,
	ViewOnlyInfo	TINYINT NOT NULL
CONSTRAINT [PK_CS_CustomerStatus] PRIMARY KEY CLUSTERED 
(
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO