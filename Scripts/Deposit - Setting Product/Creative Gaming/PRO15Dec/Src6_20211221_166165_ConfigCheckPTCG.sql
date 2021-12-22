/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20211220@Winfred
	Task: add new pt 0.93 for Creative Gaming [Redmine:#166165]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Creative Gaming
PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
UPDATE a 
SET a.PTValue = a.PTValue + ',93.00'
FROM  Dep_PTConfig a WITH(ROWLOCK)
WHERE a.SportType = 167 AND a.RuleID = 71 AND a.PTValue NOT LIKE '%,93.00'

GO

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 167
	  AND RuleID = 71

GO	  
	  
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 