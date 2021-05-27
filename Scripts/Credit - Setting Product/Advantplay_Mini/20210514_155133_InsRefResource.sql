/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Winfred
	Date:	20210514
	Task:	Insert RefResource for AdvantPlay Mini - Credit RedmineID:#155133
	DB: DBPRO/bodb02
*/
DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 29

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 29, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')