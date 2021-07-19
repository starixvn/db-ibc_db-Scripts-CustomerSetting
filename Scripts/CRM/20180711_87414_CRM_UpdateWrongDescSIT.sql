/*
Created: 20180709@Winnie
Task: Update SIT data RedmineID: #84714
DB: DBCRM.bodb_CRM
Revisions:
Param's Explanation: 
*/

USE bodb_CRM
GO

CREATE TABLE #tempFB(FeedbackID INT PRIMARY KEY,Description XML ,Remark NVARCHAR(MAX))
INSERT INTO #tempFB(FeedbackID,Description)
SELECT FeedbackID,CAST (Description AS XML)
FROM crmFeedback WITH(NOLOCK)
WHERE Description like '%&lt;ROOT%'

UPDATE #tempFB
	SET Remark=Description.value('/ROOT[1]/row[1]/@Remark', 'VARCHAR(MAX)')

UPDATE c
	SET c.Description=t.Remark
FROM crmFeedback  c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #tempFB t ON C.FeedbackID=t.FeedbackID

DROP TABLE #tempFB