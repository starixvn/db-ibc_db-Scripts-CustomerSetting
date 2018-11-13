/*
	Created: 20181113@Winnie
	Task: Add new key column to the table Dep_CustBetLimit_Special, and add this table into pub CustDB_DR_sync .RedmineID:#101526
	DB: DBCUST/CustDB,DB06,DBTP/bodb02. 
*/
ALTER TABLE dbo.Dep_CustBetLimit_Special 
ADD Keyid INT IDENTITY(1,1)
GO

-- add new primary key constraint on new column   
ALTER TABLE dbo.Dep_CustBetLimit_Special 
ADD CONSTRAINT PK_Dep_CustBetLimit_Special
PRIMARY KEY NONCLUSTERED (Keyid)
GO


