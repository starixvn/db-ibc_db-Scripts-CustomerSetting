/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: 20221202@Tacy
	Task: Deposit - Delete reference setting: GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust.CustDB
*/ 

DELETE a 
FROM SportBettypeSettingMatrix a  WITH(ROWLOCK) 
WHERE a.Sporttype IN (219, 236) AND isLicensee=1