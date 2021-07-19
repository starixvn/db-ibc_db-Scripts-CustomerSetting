/*
	Created by: Elodie
	Date: 2017-11-23
	Task: Update config data on LimitLoss_HeadlineSetting [Redmine:#82892]	
*/
USE bodb_Age
GO

UPDATE a
SET a.ActionDesc = 'Alert on report'
FROM dbo.LimitLoss_ActionItem a
WHERE ActionID = 1

UPDATE a
SET a.ActionDesc = 'Send email notification to recipient'
FROM dbo.LimitLoss_ActionItem a
WHERE ActionID = 2

INSERT dbo.LimitLoss_ActionItem (ActionID, ActionDesc)
VALUES  ( 3, -- ActionID - tinyint
          'Send lettalk notification to recipient'  -- ActionDesc - varchar(500)
          )

UPDATE c
SET c.ActionID = 2
FROM dbo.LimitLoss_ActionConfig c
WHERE Value >=60 --AND c.Value < 80

--UPDATE c
--SET c.ActionID = 3
--FROM dbo.LimitLoss_ActionConfig c
--WHERE Value >=80