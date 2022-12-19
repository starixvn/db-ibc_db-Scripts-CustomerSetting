/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 20221117
	Task: Alter column SubType
	DB: DBCUST/CustDB
*/
USE CustDB
GO

ALTER TABLE ProductSettingDetail ADD SubType TINYINT NULL
GO
ALTER TABLE ProductSettingDetail_UAT ADD SubType TINYINT NULL