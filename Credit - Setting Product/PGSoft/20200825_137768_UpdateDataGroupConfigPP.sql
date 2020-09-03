/*
	Created: Winfred
	Date: 20200901
	Task:  Insert Data eaGroupConfiguration PP RedmineID:#137768
	DB: DBPOL.NAP_UserControl
*/
USE NAP_UserControl
GO

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.eaGroupConfiguration psd WITH(NOLOCK)
				WHERE 	psd.ProductID = 34 
					AND GroupId = 54 			
			)
BEGIN
	INSERT INTO eaGroupConfiguration (ProductId,GroupId,IsShow) 
	VALUES(32,54,1)		

END 