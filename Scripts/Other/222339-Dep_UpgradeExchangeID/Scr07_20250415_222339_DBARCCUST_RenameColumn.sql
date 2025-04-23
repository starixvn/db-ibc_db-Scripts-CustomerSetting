/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
	Created: 20250415@Tacy	
	Task: ARCHIVE - tbl [Customer] - Rename current & new column 
	DB: DBARCCUST-Bodb_Archive_Customer_Licensee
	
	Revisions:
		- 20250415@Tacy: Created [RedmineID: #222339]
*/
USE Bodb_Archive_Customer_Licensee
GO

-- Step 3: Swap the old and new column names
-- Rename the old column 'Currency' to 'oldCurrency'
EXEC sp_rename '[dbo].[Customer].[Currency]', 'oldCurrency', 'COLUMN';
GO

-- Rename the new column 'newCurrency' to 'Currency'
EXEC sp_rename '[dbo].[Customer].[newCurrency]', 'Currency', 'COLUMN';
GO

-- Step 4: Drop 'oldCurrency'
ALTER TABLE [dbo].[Customer] DROP COLUMN oldCurrency;
GO