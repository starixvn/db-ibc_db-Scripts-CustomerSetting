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
     VALUES
           ('StakeLevel_GG'
           ,'9'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,NULL
           ,NULL
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1'
           ,'Level 1')
GO


