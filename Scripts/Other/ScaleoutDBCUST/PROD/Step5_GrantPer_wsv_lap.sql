/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: @Helios
	Date: 2024-10-08
	Task: Grant Permission account wsv_lap  [Redmine: #206823]  
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB

GRANT SELECT ON CustInfoMini TO wsv_lap

GRANT SELECT ON Exchange TO wsv_lap
