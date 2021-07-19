/*<info serverAlias="DBTXN-bodb02" executers="bodbAdminNet" viewers="" isFunction="0" isNested="0"></info>*/

ALTER PROC NAP_CWL_ProductOffer_Initialize_Settings 
	@ProductID                INT
   , @RepresentativeBettype    INT
AS
/*
	    Creator:	20191028@Robert
	    Task:	Initial settings for #122849 - CWL - create new table WinLimit_ProductOffer
	    Database:	DBTXN.bodb02
	
	    Revisions:
		    - 20191028@Robert:	Initial settings for #122849 - CWL - create new table WinLimit_ProductOffer
		
	    Parameter's Explaination:
		    - @Example:			
		
	    Developer's Notes:		
*/
    BEGIN
	   SET NOCOUNT ON;
	   IF EXISTS
			   (
				  SELECT TOP 1 1
				  FROM dbo.WinLimit_ProductOffer WITH(NOLOCK)
				  WHERE ProductID = @ProductID
					   AND BetType = @RepresentativeBettype
			   )

		  UPDATE p
			    SET 
				   p.IsActive_Company = 1
		  FROM dbo.WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
		  WHERE p.ProductID = @ProductID
			   AND BetType = @RepresentativeBettype;
		  ELSE

		  INSERT INTO dbo.WinLimit_ProductOffer(ProductID
									   , BetType
									   , IsActive_SMA
									   , IsActive_Company)
			    SELECT @ProductID AS ProductId
				    , @RepresentativeBettype AS BetType
				    , 0 AS IsActive_SMA
				    , 1 AS IsActive_Company;
    END;