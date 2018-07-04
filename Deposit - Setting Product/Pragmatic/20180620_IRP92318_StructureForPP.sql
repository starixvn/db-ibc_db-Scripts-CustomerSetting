/*
	Created: Johnson
	Date: 20180620
	Task: add new column for Product3rd
	DB: DBLIC/bodb_licensee
*/

USE bodb_licensee
GO

ALTER TABLE dbo.Product3rd ADD ApplyDCS BIT NULL DEFAULT 0 
GO

UPDATE dbo.Product3rd WITH(UPDLOCK,ROWLOCK)
SET ApplyDCS = CASE WHEN Productid IN (22,24,21,5,27,28,32) THEN 1 ELSE 0 END