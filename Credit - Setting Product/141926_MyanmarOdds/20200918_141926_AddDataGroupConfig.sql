/*
	Created: Winfred
	Date: 20201020
	Task:  Insert Data eaGroupConfiguration RedmineID:#141926
	DB: DBPOL.NAP_UserControl
*/
USE NAP_UserControl
GO

SELECT GroupID INTO #temp_eaGroup FROM eaGroup WITH (NOLOCK)  WHERE GroupName  in ( 'ACCUUSMyanmar','ACCMMKMyanmar' )

DELETE a FROM eaGroupConfiguration a INNER JOIN #temp_eaGroup b on a.GroupId = b.GroupId

INSERT INTO eaGroupConfiguration (ProductId,GroupId,IsShow) 
SELECT 
	c.ProductId 
	,a.GroupId
	,c.IsShow 
FROM #temp_eaGroup a
INNER JOIN eaGroup b WITH (NOLOCK) ON b.GroupName  = 'ACCMMK'
INNER JOIN eaGroupConfiguration c WITH(NOLOCK) ON b.GroupId = c.GroupId
		
DROP TABLE #temp_eaGroup