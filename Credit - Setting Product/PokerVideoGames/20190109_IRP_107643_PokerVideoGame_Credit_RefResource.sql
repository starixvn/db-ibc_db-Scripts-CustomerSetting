/*
	Created: Winnie
	Task: Copy Setting for newly created customer
	DB: DBTXN/bodb02
	Date: 20190110
*/ 
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
			[RefId]
           ,9
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
	FROM [RefResource] WHERE [RefId]='StakeLevel_GG' AND [ResourceId]=6

GO


