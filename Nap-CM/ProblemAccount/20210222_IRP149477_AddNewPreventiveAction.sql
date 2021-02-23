/*
	Created: 20210222@Johnson
	Task: add new preventive action for problem account [redmine:#149447]
	DB: DBCUST/CustDB
*/
--update isCredit & isDeposit for existing settings
UPDATE ProblemAccountAction
SET isCredit = 1,
	isDeposit = 1
WHERE ActionID IN (1,2)
GO

--add 2 new settings
INSERT INTO [dbo].[ProblemAccountAction]
           ([ActionID]
           ,[ActionName]
           ,[IsActive]
           ,[SubIssueTypeId]
		   ,[IsCredit])
SELECT 3,'Limit New Downline',0,NULL,1
UNION SELECT 4,'Void Win. Tic. & Lim. DL.',0,38,1		   

