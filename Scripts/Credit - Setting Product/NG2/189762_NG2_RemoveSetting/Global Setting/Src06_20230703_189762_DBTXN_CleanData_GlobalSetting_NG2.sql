/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: DBTXN/bodb02
*/ 
DELETE a 
FROM Sport_Bettype_Reference a  WITH(ROWLOCK) 
WHERE a.Sporttype BETWEEN 213 and 218


DELETE a 
FROM Sport_Bettype_Reference_Setting a WITH(ROWLOCK)
WHERE a.Sporttype BETWEEN 213 and 218
