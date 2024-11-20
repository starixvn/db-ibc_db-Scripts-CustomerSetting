/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: Tacy@20241120
	Task: Update maxLogID - Service ChatBot - ProblemAccount  [Redmine:#212681] 
	DB:	DBBOT-bodb_ChatBot
*/

USE bodb_ChatBot
GO

DECLARE @Max_LogID BIGINT = 8240778

/*
select max(logid) maxlogid
from CustCategoryHistory with (nolock)
where CreatedDate between '2024-11-19 00:00:00' and '2024-11-19 23:02:51.1870000'
and CustomerClass in (30000,31000)
*/

UPDATE TOP (2) BotSystemSetting WITH (ROWLOCK, UPDLOCK)
SET Value = @Max_LogID
WHERE ServiceName='ProblemAccount'
AND SettingName IN ('MaxLogId')
GO