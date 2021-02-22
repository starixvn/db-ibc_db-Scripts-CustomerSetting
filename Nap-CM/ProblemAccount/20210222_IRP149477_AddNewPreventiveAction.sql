/*
	Created: 20210222@Johnson
	Task: add new preventive action for problem account [redmine:#149447]
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[ProblemAccountAction]
           ([ActionID]
           ,[ActionName]
           ,[IsActive]
           ,[SubIssueTypeId])
SELECT 3,'Limit New Downline',0,NULL
UNION SELECT 4,'Void Win. Tic. & Lim. DL.',0,38		   