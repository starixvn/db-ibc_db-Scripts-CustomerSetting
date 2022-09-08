/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Tacy
	Date: 20220908
	Task:  add RefResource for SEALEntertainment [RedmineID:#176209]
	DB: DBPRO/bodb02
*/
DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 39

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 39, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')