/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210802
	Task: update Dep_ProductSettingDetail
	DB: DBCust/CustDB
*/

--step 1: run this script @DBCust/CustDB
UPDATE Dep_ProductSettingDetail WITH(UPDLOCK)
SET SettingStatus =0
WHERE ProductSettingID IN (SELECT ProductSettingID from Dep_ProductSetting with(NOLOCK) where ProductID in (43,21)
)
GO

--step 2: run this script @DBLIC/bodb_Licensee

INSERT INTO LicenseeProduct3rd(LicenseeID,ProductID,Comm,Winloss,EffectiveDate)
SELECT 26,	15,	1,	0,	'1900-01-01 00:00:00'
UNION SELECT 26, 25,	0,	1,	'1900-01-01 00:00:0'
UNION SELECT 26, 31,	1,	0,	'1900-01-01 00:00:0'