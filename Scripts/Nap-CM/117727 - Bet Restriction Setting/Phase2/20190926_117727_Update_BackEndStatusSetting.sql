/*
	Created by: Eden
	Date: 20190912
	Task: Update BacEndStatus for Setting
	RM: #117727
	DB: DBCUST/CustDB
*/
USE CustDB
UPDATE BetRestriction_Setting WITH(ROWLOCK,UPDLOCK) 
SET BackEndStatus = 0 --PROD
WHERE SportType = 1
