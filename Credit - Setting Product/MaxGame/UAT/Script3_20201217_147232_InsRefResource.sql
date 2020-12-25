/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Eden@20201216
	Task: Add RefResource for Max Game [RM:#147232]
	DB: DBPRO/bodb02
*/
--DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 19

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 19, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')