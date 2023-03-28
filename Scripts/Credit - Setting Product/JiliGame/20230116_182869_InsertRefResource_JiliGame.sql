/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20230116@Helios
	Task:  add RefResource for Jili Games [RedmineID:#182869]
	DB: DBPRO/bodb02
*/

DELETE FROM RefResource WITH(ROWLOCK) WHERE RefId = 'StakeLevel_GG' AND ResourceId IN (41,43)

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES 
('StakeLevel_GG', 41, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1'),
('StakeLevel_GG', 43, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')
