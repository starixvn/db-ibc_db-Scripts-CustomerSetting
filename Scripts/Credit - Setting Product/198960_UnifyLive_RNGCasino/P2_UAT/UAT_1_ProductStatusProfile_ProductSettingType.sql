/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Setting ProductStatusProfile , ProductSettingType [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

	
	-------------------------1.ProductStatusProfile------------------------------------

	IF NOT EXISTS (SELECT 1 FROM ProductStatusProfile WITH (NOLOCK) WHERE Sporttype = 9918)
	BEGIN
		INSERT INTO ProductStatusProfile 
		(
			Sporttype
		    , Bettype
		    , bitmapOrder
		)
		SELECT 9918 , 4601 , 43
	END

	-------------------------2.ProductSettingType------------------------------------
	IF NOT EXISTS (SELECT 1 FROM ProductSettingType WITH (NOLOCK) WHERE SettingType = 160)
	BEGIN
		INSERT INTO ProductSettingType 
		(
			SettingType
		    , SettingName
		    , SettingNameDetail
		)
		SELECT 160,'Product Status','Product Status'
	END

	
