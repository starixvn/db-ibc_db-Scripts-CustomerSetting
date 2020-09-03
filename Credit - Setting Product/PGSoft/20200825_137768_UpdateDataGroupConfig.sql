/*
	Created: Winfred
	Date: 20200901
	Task:  Insert Data eaGroupConfiguration RedmineID:#137768
	DB: DBPOL.NAP_UserControl
*/
USE NAP_UserControl
GO

DELETE FROM	 eaGroupConfiguration  WHERE ProductID = 34			

INSERT INTO eaGroupConfiguration (ProductId,GroupId,IsShow) 
SELECT 
	34 AS ProductId	 -- Card Club
	,GroupId
	,0 AS IsShow 
FROM eaGroupConfiguration WITH(NOLOCK)
WHERE ProductID = 22 -- Macau Game			
