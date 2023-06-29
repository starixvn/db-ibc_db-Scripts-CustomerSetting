/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20/06/2023
	Created: Helios 
	Task: MG-RNG - Integrate the product for deposit sites
	DB: DBCUST/CUSTDB
*/


UPDATE 
[dbo].[Dep_ProductSettingDetail]
SET SettingStatus=0
WHERE ProductSettingID IN (171,172,173)
AND SportType = 155
AND BetType IN (8400,8699)
