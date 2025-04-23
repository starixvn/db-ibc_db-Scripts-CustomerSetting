/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
	Created: 20250415@Tacy	
	Task: ARCHIVE - tbl [Customer] - Add [newCurrency]
	DB: DBARCCUST-Bodb_Archive_Customer_Licensee
	
	Revisions:
		- 20250415@Tacy: Created [RedmineID: #222339]
*/
USE Bodb_Archive_Customer_Licensee
GO

-- Step 1: Add the new column 'newCurrency' to the table
ALTER TABLE [dbo].[Customer] ADD newCurrency SMALLINT NULL;
GO