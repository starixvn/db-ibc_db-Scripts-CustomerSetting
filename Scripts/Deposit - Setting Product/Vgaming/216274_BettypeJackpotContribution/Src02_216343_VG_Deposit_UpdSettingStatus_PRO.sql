/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250103@Virgil
	Task: Vgaming - Integrate Bettype Jackpot Contribution (Remove code using VendorGlobalSetting) [RedmineID: #216274]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT = 171,
		@Bettype   SMALLINT	= 3898

UPDATE Y
SET SettingStatus = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
WHERE ProductSettingID = 102
	AND SportType = @Sporttype
	AND BetType = @Bettype

GO
