/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: 20221202@Tacy
	Task: Credit - Delete reference setting: GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust.CustDB
*/ 

UPDATE a 
SET a.isDeleted=1, RepUpdateTime = SYSDATETIME()
FROM [dbo].[SportBettypeSettingMatrix] a  WITH(UPDLOCK,ROWLOCK) 
WHERE a.Sporttype IN (219, 236) AND isLicensee=0 AND isDeleted=0