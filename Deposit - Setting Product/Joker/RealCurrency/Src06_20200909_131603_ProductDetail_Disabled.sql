/*
	Created: Winfred
	Date: 20200909
	Task: Update Product Setting Detail (DISABLED)  [Joker] - deposit RedmineID:#131603
	DB: DBCUST/CustDB
*/
PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=234
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
