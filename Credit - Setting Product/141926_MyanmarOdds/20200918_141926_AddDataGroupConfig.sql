/*
	Created: Winfred
	Date: 20201020
	Task:  Insert Data eaGroupConfiguration RedmineID:#141926
	DB: DBPOL.NAP_UserControl
*/
USE NAP_UserControl
GO

DECLARE @GroupID INT = 0

SELECT @GroupID = GroupID  FROM eaGroup WITH (NOLOCK)  WHERE GroupName  = 'ACCUUSMyanmar'

DELETE FROM	 eaGroupConfiguration  WHERE GroupId = @GroupID			

INSERT INTO eaGroupConfiguration (ProductId,GroupId,IsShow) 
SELECT 
	ProductId 
	,@GroupID as GroupId
	,IsShow 
FROM eaGroupConfiguration a WITH(NOLOCK)
INNER JOIN eaGroup c WITH (NOLOCK) ON a.GroupId = c.GroupId
WHERE c.GroupName  = 'ACCMMK'
		
