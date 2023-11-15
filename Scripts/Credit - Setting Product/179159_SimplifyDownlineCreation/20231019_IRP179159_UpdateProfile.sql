/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231019@Johnson
	Task: update ProductSettingType
	DB: DBCUST/CustDB
*/


INSERT INTO [dbo].[ProductSettingType]
           ([SettingType]
           ,[SettingName]
           ,[SettingNameDetail])
SELECT 159,'GT Stake Level','Stake Level Group'		

UPDATE ProductSettingType
SET SettingName = 'GT Commission'
WHERE SettingType = 150