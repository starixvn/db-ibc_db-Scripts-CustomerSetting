/*
	Created: 20200416@Tiara
	Date: 20200416
	Task: Update setting type for Allbet, SA, SexyGaming from 7 to 17 [Redmine: #131171]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE P
SET P.SettingType = 17
FROM ProductSettingDetail P WITH (ROWLOCK, UPDLOCK)
WHERE P.SettingType = 7 AND P.SportType IN (211,243,244)