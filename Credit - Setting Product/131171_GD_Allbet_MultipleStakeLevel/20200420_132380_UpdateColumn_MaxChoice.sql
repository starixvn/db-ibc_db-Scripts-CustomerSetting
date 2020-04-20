/*
	Created: 20200417@Tiara
	Date: 20200417
	Task: Update column MaxChoice for Allbet, SA, Sexy Gaming [Redmine: #131853]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO


UPDATE P
SET P.MaxChoice = 5
FROM ProductSettingDetail P WITH (NOLOCK)
WHERE P.SportType IN (211,243,244) AND P.SettingType = 17