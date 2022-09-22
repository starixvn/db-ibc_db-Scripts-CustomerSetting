/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task:	 Macau Game - Rename the setting page into RNG Slot and hide all bet limit setting RefResource [Redmine: 174513]
	DB:		 DBPRO/bodb02
*/ 
USE bodb02
GO

DELETE FROM dbo.RefResource WITH(ROWLOCK,UPDLOCK) WHERE RefId='DummySport' AND ResourceId IN('9906')

INSERT INTO RefResource(RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
SELECT 'DummySport', '9906','RNG Slot',N'RNG老虎机',N'RNG老虎機',N'RNG สล็อต' 

SELECT * FROM dbo.RefResource WITH(NOLOCK) WHERE RefId='DummySport' AND ResourceId IN('9906')