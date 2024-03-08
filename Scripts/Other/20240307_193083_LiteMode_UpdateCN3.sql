/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20240307@Tacy
	Task: update RefResource [RedmineId: #193083]
	DB: DBPRO/bodb02
*/

UPDATE RefResource WITH(ROWLOCK, UPDLOCK)
SET Resource_vn = CASE WHEN Resource_en IN ('Live') THEN N'Trực tiếp' ELSE  N'Không trực tiếp' END,
	RepUpdateTime = SYSDATETIME()
WHERE refid='DummySport'
AND Resource_en IN ('Live','Non Live')
GO