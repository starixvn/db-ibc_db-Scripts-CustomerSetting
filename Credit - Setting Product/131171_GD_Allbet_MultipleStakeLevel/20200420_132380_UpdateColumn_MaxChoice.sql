/*
	Created: 20200417@Tiara
	Date: 20200417
	Task: Update column MaxChoice for Allbet, SA, Sexy Gaming [Redmine: #131853]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO


UPDATE P
SET P.MaxChoice = 3
FROM ProductSettingDetail P WITH (ROWLOCK, UPDLOCK)
WHERE P.SportType = 211 AND P.SettingType = 17


UPDATE P
SET P.MaxChoice = 5
FROM ProductSettingDetail P WITH (ROWLOCK, UPDLOCK)
WHERE P.SportType = 244 AND P.SettingType = 17


UPDATE P
SET P.MaxChoice = 6
FROM ProductSettingDetail P WITH (ROWLOCK, UPDLOCK)
WHERE P.SportType = 243 AND P.SettingType = 17