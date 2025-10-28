/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) - Changed Product name [#240871] 
	DB: DBPRO-bodb02
*/

---- Intg_GameGroup 
--EXEC Intg_GameGroup_Insert_Test @SportType   =115
--					, @ProductName ='Vertex Play'
--					, @BetTypeStart=16900
--					, @BetTypeEnd  =16999
--					, @GroupID	   =26
--					, @SiteType	   =1
--					, @TransGroupID=3
--					, @IsTest	   =FALSE
--					, @Lv3Mode	   =3
--					, @VendorID	   =116


--EXEC Intg_GameGroup_Insert_Test @SportType   =115
--					, @ProductName ='Vertex Play'
--					, @BetTypeStart=16900
--					, @BetTypeEnd  =16999
--					, @GroupID	   =104
--					, @SiteType	   =2
--					, @TransGroupID=3
--					, @IsTest	   =FALSE
--					, @Lv3Mode	   =3
--					, @VendorID	   =116

IF EXISTS (SELECT TOP 2 2 FROM Intg_GameGroup WITH (NOLOCK) WHERE SportType = 115)
BEGIN
	UPDATE igg
		SET ProductName  = N'VertexPlay'
	FROM Intg_GameGroup igg WITH (ROWLOCK, UPDLOCK)
	WHERE SportType = 115
END