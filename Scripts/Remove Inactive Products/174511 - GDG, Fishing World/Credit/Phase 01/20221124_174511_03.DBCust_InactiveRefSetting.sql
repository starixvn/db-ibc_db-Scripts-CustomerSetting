/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: 20221128@Tacy
	Task: Credit - inactive reference setting: GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 

UPDATE a 
SET a.isActive = 0, RepUpdateTime = SYSDATETIME()
FROM [dbo].[SportBettypeSettingMatrix] a  WITH(UPDLOCK,ROWLOCK) 
WHERE a.Sporttype IN (219, 236) AND isLicensee=0