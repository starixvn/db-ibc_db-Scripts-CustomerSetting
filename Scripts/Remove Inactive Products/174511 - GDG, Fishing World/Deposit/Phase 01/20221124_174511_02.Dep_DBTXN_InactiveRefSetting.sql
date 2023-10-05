/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: 20221128@Tacy
	Task: Deposit - inactive reference setting: GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBTXN.bodb02
*/ 

UPDATE a 
SET a.isActive = 0
FROM [dbo].[Sport_Bettype_Reference] a  WITH(UPDLOCK,ROWLOCK) 
WHERE a.Sporttype IN (219, 236) AND isLicensee=1


UPDATE a 
SET a.isActive = 0
FROM [dbo].[Sport_Bettype_Reference_Setting] a  WITH(UPDLOCK,ROWLOCK) 
WHERE a.Sporttype IN (219, 236) AND isLicensee=1