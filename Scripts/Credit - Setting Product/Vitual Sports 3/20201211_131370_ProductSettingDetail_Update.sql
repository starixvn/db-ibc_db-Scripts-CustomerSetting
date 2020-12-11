/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201211
	Task: Update SettingLevel Product [Leap Gaming Virtual Sports] RedmineID:#131370
	DB: DBCust/CustDB
*/

USE CustDB
GO

 
IF EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductSettingDetail psd WITH(NOLOCK)
				WHERE 	psd.ProductID = 5 
					AND SportType  = 231 
					AND BetType = 5301
					AND SettingType = 20 
					AND SettingLevel <> 2			
			)
	BEGIN
		
		UPDATE ProductSettingDetail WITH (ROWLOCK, UPDLOCK) 
		SET SettingLevel = 2
		WHERE ProductID = 5 
					AND SportType  = 231 
					AND BetType = 5301
					AND SettingType = 20 
					AND SettingLevel <> 2	
	
	END		

