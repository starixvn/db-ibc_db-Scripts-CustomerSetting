/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date:12/06/2024
	Task: Delete Data Redundant ProductSettingSystemDisplay  [#204358] 
	DB: DBCust/CustDB
*/

IF EXISTS (SELECT 1 FROM ProductSettingSystemDisplay WITH (NOLOCK) WHERE ProductID = 5)
BEGIN
	DELETE FROM ProductSettingSystemDisplay WITH (ROWLOCK) WHERE ProductID = 5
END

IF EXISTS (SELECT 1 FROM ProductSettingSystemDisplay WITH (NOLOCK) WHERE ProductID = 44 AND SettingType = 6)
BEGIN
	DELETE FROM ProductSettingSystemDisplay WITH (ROWLOCK) WHERE ProductID = 44 AND SettingType = 6
END