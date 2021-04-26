/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20210426@Eden
	Task: Insert RefResource = 24 for VGaming [#RM:153938]
	DB: DBPRO/bodb02
*/

USE bodb02
GO

INSERT INTO RefResource(RefId, ResourceId, Resource_en, Resource_ch, Resource_cs, Resource_jp, Resource_it, Resource_th, Resource_ko, Resource_es, Sort1, Sort2, Resource_el, Resource_vn, Resource_pl, Resource_id, Resource_hi, Resource_mm, Resource_fr, Resource_ru, Resource_pt, Resource_de)
SELECT RefId, '24', Resource_en, Resource_ch, Resource_cs, Resource_jp, Resource_it, Resource_th, Resource_ko, Resource_es, Sort1, Sort2, Resource_el, Resource_vn, Resource_pl, Resource_id, Resource_hi, Resource_mm, Resource_fr, Resource_ru, Resource_pt, Resource_de
FROM RefResource WITH (NOLOCK)
WHERE RefId='StakeLevel_GG' AND ResourceId='1'

SELECT * FROM dbo.RefResource WHERE RefId='StakeLevel_GG' AND ResourceId='24'