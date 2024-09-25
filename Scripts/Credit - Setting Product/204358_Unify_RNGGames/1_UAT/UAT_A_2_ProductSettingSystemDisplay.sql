/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date:12/06/2024
	Task: Inital Data ProductSettingSystemDisplay  [#204358] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (
			SELECT TOP 1 1 FROM ProductSettingSystemDisplay WITH (NOLOCK) WHERE ProductID = 44 AND SettingType = 21
		  )
BEGIN
	INSERT INTO ProductSettingSystemDisplay 
		(
			SystemID
		    , ProductID
		    , SettingType
		    , DisplayMode
		)
		 SELECT 8 , 44 , 21 , 3  
	 UNION SELECT 9 , 44 , 21 , 3  
	 UNION SELECT 7 , 44 , 21 , 3  
	 UNION SELECT 6 , 44 , 21 , 3  
	 UNION SELECT 5 , 44 , 21 , 3  
 END
