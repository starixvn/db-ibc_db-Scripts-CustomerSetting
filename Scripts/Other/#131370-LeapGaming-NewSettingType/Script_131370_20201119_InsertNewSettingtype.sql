/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201119
    Task: Insert new setting type for bet limit [#131370]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail) VALUES (20, 'Bet Setting', 'GameBetSetting')
