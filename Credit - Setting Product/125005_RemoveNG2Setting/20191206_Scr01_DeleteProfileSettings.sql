/*
	Created: Johnson
	Date: 2019-12-06
	Task: delete profile setting for sport 18C of NG2		
*/

--step 1: run these script on DBCUST.CustDB
DELETE ProductSettingDetail WITH(UPDLOCK,ROWLOCK) 
WHERE SportType = 216


DELETE ProductBetSetting  WITH(UPDLOCK,ROWLOCK)
WHERE Sporttype = 216
GO

-----------------------------------------------------------
--Step 2: Run this script on DBPRO.bodb02
DELETE SportBettypeMatrix where sporttype = 216
