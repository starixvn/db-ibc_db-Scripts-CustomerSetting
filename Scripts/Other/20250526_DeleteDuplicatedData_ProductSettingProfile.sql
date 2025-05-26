/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Dave@20250526
	Task: Delete duplicated data in table ProductSettingProfile
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

DELETE dbo.ProductSettingProfile WHERE ProductSettingID in (383,384, 385, 386, 387);
/*duplicate with 377, 378, 379, 380, 381*/

INSERT INTO dbo.ProductSettingProfile_Del_InHouse(ProductSettingID, RepUpdateTime)
VALUES (383, GETDATE()),(384, GETDATE()),(385, GETDATE()),(386, GETDATE()),(387, GETDATE());
