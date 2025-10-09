/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBPRO-bodb02
*/

-- Intg_GameGroup 
EXEC Intg_GameGroup_Insert_Test @SportType   =115
					, @ProductName ='Vertex Play'
					, @BetTypeStart=16900
					, @BetTypeEnd  =16999
					, @GroupID	   =26
					, @SiteType	   =1
					, @TransGroupID=3
					, @IsTest	   =FALSE
					, @Lv3Mode	   =3
					, @VendorID	   =116


EXEC Intg_GameGroup_Insert_Test @SportType   =115
					, @ProductName ='Vertex Play'
					, @BetTypeStart=16900
					, @BetTypeEnd  =16999
					, @GroupID	   =104
					, @SiteType	   =2
					, @TransGroupID=3
					, @IsTest	   =FALSE
					, @Lv3Mode	   =3
					, @VendorID	   =116