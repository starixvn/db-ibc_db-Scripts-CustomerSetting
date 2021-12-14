/*<info serverAlias="DBTEST/CUSTDB"></info>*/
/*
	Created: Eden@20211001
	Task: Update status of config to planned [Redmine: #156667]   
	DB: DBTEST/CUSTDB
*/

USE CUSTDB
GO

DECLARE @configID INT = 12

UPDATE  t 
SET status = 0
	, CurrentStep = NULL
	, ProcessedStep = NULL
	, EndTime = NULL
from Initial_ProductConfig t with(rowlock,updlock)
where ConfigID = @configID


