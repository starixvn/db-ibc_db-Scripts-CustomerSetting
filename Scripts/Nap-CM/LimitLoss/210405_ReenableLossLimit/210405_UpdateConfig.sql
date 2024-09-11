/*<info serverAlias="DBAGE-bodb_Age"></info>*/
/*
	Created by: Elodie
	Date: 20240905
	Task: Update config data on LimitLoss_HeadlineSetting [Redmine:#82892]	
*/
USE bodb_Age
GO

UPDATE c
SET c.ActionID = 3
FROM dbo.LimitLoss_ActionConfig c
WHERE Value >=60 --AND c.Value < 80

SELECT * FROM LimitLoss_ActionConfig