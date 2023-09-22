/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20230728@Helios
	Task: Add RefResource for Dummy Sport  [#189389]
	DB: DBPRO/bodb02
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	DELETE 
	FROM RefResource WITH (ROWLOCK)
	WHERE RefId = 'DummySport' 
	AND ResourceId = '9911' 
	AND Resource_en = 'Live Casino'

	INSERT INTO dbo.RefResource ([RefId]
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
			   ,[Resource_de]
			   ,[IsDeleted]
			   ,[RepUpdateTime])

	SELECT 'DummySport'
		  ,9911
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
		  ,[IsDeleted]
		  ,SYSDATETIME() 
	FROM RefResource WITH (NOLOCK) where ResourceID = '41' AND Resource_en = 'Live Casino'