/*
	Created: Eden@20210111
	Task: Insert RefResource - new level for SabaClub [#147941]
	DB: DBPRO/bodb02
*/
USE bodb02
GO
INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 20, 'Level 2',N'階級2', N'阶级2', N'เลเวล 2')
