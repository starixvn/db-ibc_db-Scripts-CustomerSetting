--/*<info serverAlias="DBCUST-CustDB"></info>*/
--/*
--	Date: 20230117
--	Created: Helios 
--	Task: Jili Games - Update SettingStatus Dep_ProductSettingDetail [redmine : #182869]
--	DB: DBCUST/CUSTDB
--*/

UPDATE 
[dbo].[Dep_ProductSettingDetail]
SET SettingStatus=0
WHERE ProductSettingID IN ('156','157','158')
AND SportType = 158
AND BetType = 5100

