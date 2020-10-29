/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201029
    Task: #143764-Adjust_new_pt_for_789y_UpdateMaxPT [#143764]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE s 
SET s.MaxPT = 90 
FROM ProductSettingDetail s WITH(ROWLOCK, UPDLOCK)
WHERE SettingType = 1
	AND ProductID = 23