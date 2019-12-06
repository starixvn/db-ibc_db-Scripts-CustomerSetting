/*
	Created: Winnie
	Date: 20191028
	Task: Insert RR RedmineID:#122351
	DB: DBPRO/bodb02
*/
 
DELETE FROM RefResource WHERE ResourceId='247' AND RefId='PG_GT'

INSERT INTO RefResource(RefId,ResourceId,Resource_en)
SELECT 'PG_GT','247','SpadeGaming'

USE [bodb02]
GO

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
           ,[Sort1]
           ,[Sort2]
           ,[Resource_el]
           ,[Resource_vn]
           ,[Resource_pl]
           ,[Resource_id]
           ,[Resource_hi]
           ,[Resource_mm]
           ,[Resource_fr]
           ,[Resource_ru]
           ,[Resource_pt]
           ,[Resource_de])
 SELECT
			TOP 1
			[RefId]
           ,12
           ,[Resource_en]
           ,[Resource_ch]
           ,[Resource_cs]
           ,[Resource_jp]
           ,[Resource_it]
           ,[Resource_th]
           ,[Resource_ko]
           ,[Resource_es]
           ,[Sort1]
           ,[Sort2]
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
		   FROM [RefResource]
where Resource_en='Level 1'

