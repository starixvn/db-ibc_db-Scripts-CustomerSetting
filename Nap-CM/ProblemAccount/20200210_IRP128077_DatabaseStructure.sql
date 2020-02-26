/*
	Created: 20200210@Johnson	
	Task: Prepare structure for problem account for deposit	
*/
--step 1: run this script at DBCUST/bodb_Licensee 
--add new column into  table Licensees
USE bodb_Licensee
GO

ALTER TABLE Licensees ADD IsAcknowledgement BIT NULL
GO

--Step 2: run this script at @DBCUST/CustDB & DBACC/bodb02
--Then add table Dep_CustVIP into replication pub CustDB_CustSetting

--script create table Dep_CustVIP
CREATE TABLE Dep_CustVIP (
	CustID INT NOT NULL,
	ModifiedDate DATETIME NULL,
	UserID INT NULL
CONSTRAINT [PK_Dep_CustVIP] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]
GO

--Step 3:deploy this script on DBCUST/CustDB only
--add new column to mark player has void tickets
ALTER TABLE ProblemAccount ADD isMarkVoid BIT NULL DEFAULT 0
GO

ALTER TABLE ProblemAccount ADD Matchid1 INT NULL
GO

ALTER TABLE ProblemAccount ADD Matchid2 INT NULL
GO




