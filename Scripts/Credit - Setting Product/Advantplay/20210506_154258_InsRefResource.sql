/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210506
	Task:  add RefResource for AdvantPlay RedmineID:#154258
	DB: DBPRO/bodb02
*/
DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 27

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 27, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')