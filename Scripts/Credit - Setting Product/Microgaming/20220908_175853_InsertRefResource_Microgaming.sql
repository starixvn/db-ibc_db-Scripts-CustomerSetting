/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Tacy
	Date: 20220908
	Task:  add RefResource for Microgaming [RedmineID:#175853]
	DB: DBPRO/bodb02
*/
DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 40

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 40, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')