/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241120@Virgil
	Task: GPI Live Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #213485]
	DB: DBCUST-CustDB
	Note: Adjust Child_DisplayOrder order of Profile
*/
USE CustDB
GO

--// Product Setting Profile //--
--+ YEEBET
UPDATE psp
SET Child_DisplayOrder = 26,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM dbo.ProductSettingProfile psp WITH(ROWLOCK,UPDLOCK)
WHERE ProductSettingID = 246		
	AND SportType = 159
	AND BetType = 3151

--+ ON Casino
UPDATE psp
SET Child_DisplayOrder = 27,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM dbo.ProductSettingProfile psp WITH(ROWLOCK,UPDLOCK)
WHERE ProductSettingID = 373
	AND SportType = 138
	AND BetType = 11850

GO