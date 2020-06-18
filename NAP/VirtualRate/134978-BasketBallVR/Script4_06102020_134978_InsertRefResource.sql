/*
	Created: 20200610@Eden
	Task: Insert RefResource for VR Bettype label [Redmine: #134978]
	DB: DBTXN/bodb02
*/
USE bodb02
GO
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_1','FT HDP')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_7','1H HDP')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_603','SPECIAL')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_609','Q HDP')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_3','FT OU')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_8','1H OU')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_401','TEAM OU')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_610','Q OU')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_2','OE')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_20','MNL')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_21','1H MNL')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_606','RACE')
INSERT INTO dbo.RefResource(RefId,ResourceId,Resource_en) VALUES( 'VirtualRateLabel','2_612','Q MNL')
GO
SELECT * FROM dbo.RefResource WITH(NOLOCK) WHERE RefId = 'VirtualRateLabel'
