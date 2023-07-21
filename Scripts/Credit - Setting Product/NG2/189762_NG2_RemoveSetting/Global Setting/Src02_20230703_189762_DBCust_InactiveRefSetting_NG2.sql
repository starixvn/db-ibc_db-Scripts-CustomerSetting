/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: DBCust/CustDB
*/ 

UPDATE a 
SET a.isActive = 0
FROM [dbo].[SportBettypeSettingMatrix] a  WITH(UPDLOCK,ROWLOCK) 
WHERE a.Sporttype BETWEEN 213 AND 218
