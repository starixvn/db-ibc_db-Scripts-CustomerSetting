/*
	Created: Eden
	Date: 2019/10/21
	Task: Delete setting for Microgame (LC & RNG), SLI Live Casino
	DB: DBCUST/CUSTDB
*/	
--> ProductGlobalSetting
DELETE
FROM ProductGlobalSetting WITH (ROWLOCK,UPDLOCK)
WHERE Sporttype IN (203,205,162) --Microgame (LC & RNG), SLI Live Casino

