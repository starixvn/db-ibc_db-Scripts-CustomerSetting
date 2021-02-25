/*
	Created: 20210224@Tina
	Task: Insert RefResource for Habanero
	Redmine: https://nexdev.net/issues/145459
	DB: DBPRO/bodb02
*/
USE [bodb02]
GO

DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 21

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
VALUES ('StakeLevel_GG', 21, 'Level 1',N'階級1', N'阶级1', N'เลเวล 1')