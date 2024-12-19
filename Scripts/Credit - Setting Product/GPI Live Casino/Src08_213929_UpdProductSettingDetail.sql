/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241205@Virgil
	Task: GPI Live Casino - Add Setting to ProductSettingDetail [RedmineID: #213485]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

-- ON Casino
DECLARE @Sporttype SMALLINT = 138,
		@Bettype   SMALLINT = 11850

UPDATE Y
SET Y.SettingStatus = 0,
	Y.RepUpdateTime = dbo.f_GetDateTime2()
FROM ProductSettingDetail Y WITH(ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype 
	AND BetType = @Bettype

GO
