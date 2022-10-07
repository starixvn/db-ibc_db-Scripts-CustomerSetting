/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: Johnson@20221003
	Task: Insert RefResource for dummy sport 9907[Redmine:#175659]
	DB: DBPRO/bodb02
*/

USE bodb02
GO
DELETE FROM dbo.RefResource WITH(ROWLOCK,UPDLOCK) WHERE RefId='DummySport' AND ResourceId IN('9907')

INSERT INTO RefResource(RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
SELECT 'DummySport', '9907','Saba Cricket',N'沙巴板球',N'沙巴板球',N'Saba Cricket'


SELECT * FROM dbo.RefResource WITH(NOLOCK) WHERE RefId='DummySport' AND ResourceId IN('9907')
