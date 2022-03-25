/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created by: Eden@20220301
	Task: Insert RefResource for dummy sport 9901 , 9902[#RM:167898]
	DB: DBPRO/bodb02
*/

USE bodb02
GO
DELETE FROM dbo.RefResource WHERE RefId='DummySport' AND ResourceId IN('9901','9902')

INSERT INTO RefResource(RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_th)
SELECT 'DummySport', '9901','Saba Soccer',N'沙巴足球',N'沙巴足球',N'ฟุตบอล Saba' UNION ALL
SELECT 'DummySport', '9902','Saba Basketball',N'沙巴篮球',N'沙巴籃球',N'บาสเกตบอล Saba'

SELECT * FROM dbo.RefResource WHERE RefId='DummySport' AND ResourceId IN('9901','9902')