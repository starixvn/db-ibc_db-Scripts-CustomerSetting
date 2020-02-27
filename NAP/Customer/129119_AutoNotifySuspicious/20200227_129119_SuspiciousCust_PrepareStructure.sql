/*
	Created: 20200227@Elodie	
	Task: Prepare structure for auto notify suspicious
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

--DROP TABLE SuspiciousCust
CREATE TABLE SuspiciousCust
(
	CustID			INT NOT NULL,
	NotifyStatus1	TINYINT NOT NULL,
	NotifyStatus2	TINYINT NOT NULL
CONSTRAINT [PK_SuspiciousCust] PRIMARY KEY CLUSTERED 
(
	CustID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO
