/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: 20221202@Tacy
	Task: Deposit - Delete reference setting: GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBTXN.bodb02
*/ 

DELETE a 
FROM Sport_Bettype_Reference a  WITH(ROWLOCK) 
WHERE a.Sporttype IN (219, 236) AND isLicensee=1


DELETE a 
FROM Sport_Bettype_Reference_Setting a WITH(ROWLOCK)
WHERE a.Sporttype IN (219, 236) AND isLicensee=1