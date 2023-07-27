/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230922@Johnson
	Task: update ProductSettingProfile
	DB: DBCUST/CustDB
*/

UPDATE ProductSettingProfile WITH(ROWLOCK)
SET Child_DisplayOrder = Child_DisplayOrder + 1
WHERE GroupID = 2
	AND GroupType = 153
GO	

UPDATE ProductSettingProfile WITH(ROWLOCK)
SET GroupID = 2
	,SubGroupID = CASE WHEN SettingType = 18 THEN 2 ELSE SubGroupID END
	,Child_DisplayOrder =  CASE WHEN SettingType = 18 THEN 1 ELSE Child_DisplayOrder END
WHERE sporttype = 224 
	AND SettingType IN (8,18)
GO

UPDATE ProductSettingProfile WITH(ROWLOCK)
SET MaxPT = 93
WHERE GroupID = 1
	AND GroupType = 153
GO	
	