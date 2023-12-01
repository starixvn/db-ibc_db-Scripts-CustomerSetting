/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20231201@Johnson
	Task: Add RefResource
	DB: DBPRO/bodb02
*/
;WITH T AS(
SELECT 'SubGroup' RefId,'5' ResourceId,'Other RNG Casino' Resource_en
)
INSERT INTO [dbo].[RefResource]
           ([RefId]
           ,[ResourceId]
           ,[Resource_en]
           ,[Resource_ch]
           ,[Resource_cs]
           ,[Resource_jp]
           ,[Resource_it]
           ,[Resource_th]
           ,[Resource_ko]
           ,[Resource_es]     
           ,[Resource_el]
           ,[Resource_vn]
           ,[Resource_pl]
           ,[Resource_id]
           ,[Resource_hi]
           ,[Resource_mm]
           ,[Resource_fr]
           ,[Resource_ru]
           ,[Resource_pt]
           ,[Resource_de]
           ,[IsDeleted]
           ,[RepUpdateTime])
SELECT RefID, ResourceId, Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,Resource_en,0,GETDATE()
FROM T		
