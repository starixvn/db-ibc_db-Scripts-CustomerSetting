/*
	Created: Johnson
	Date: 2017-09-07
	Task: delete old virtual sports setting for deposit customers
	DB: DBCust/CustDB
*/

--check credit setting
SELECT COUNT(1)
FROM dbo.CustSetting3rd cs WITH(NOLOCK) 
WHERE cs.sporttype BETWEEN 180 AND 186
	
SELECT COUNT(1)
FROM dbo.CustOverride3rd cs WITH(NOLOCK) 
WHERE cs.sporttype BETWEEN 180 AND 186
----------------------------------------------------------------------


---Check deposit setting
SELECT COUNT(1)
FROM dbo.Dep_CustSetting3rd cs WITH(NOLOCK) 
WHERE cs.sporttype BETWEEN 180 AND 186
	
	