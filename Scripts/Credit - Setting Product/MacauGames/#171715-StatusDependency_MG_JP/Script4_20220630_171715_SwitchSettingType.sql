/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220630@Eden
	Task: Switch setting type from 13 to 21 for JP,MC [redmine : 171715]
	DB: DBCUST/CUSTDB
*/

UPDATE c 
SET c.SettingStatus = 0
FROM ProductSettingDetail c WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 22 
	AND SettingType = 21

DELETE
FROM ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 22 
	AND SettingType = 13

DELETE t
FROM dbo.ProductSettingSystemDisplay t WITH(ROWLOCK)
WHERE ProductID = 22
	AND SettingType = 13

/*
SELECT *
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 
	AND SettingType IN(13,21) 

SELECT *
FROM dbo.ProductSettingSystemDisplay t WITH(ROWLOCK)
WHERE ProductID = 22
	AND SettingType = 13
*/