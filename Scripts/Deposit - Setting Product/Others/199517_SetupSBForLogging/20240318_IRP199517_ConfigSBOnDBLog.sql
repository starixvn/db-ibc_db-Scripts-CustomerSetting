/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240318@Johnson	
	Task: Setup service broker for loggin deposit [RedmineID:#179334]
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

IF NOT EXISTS (	
				SELECT 1
				FROM sys.service_message_types
				WHERE name = 'MessageType_CustomerLog_UserLog_DepCustSetting'
				)
BEGIN
	CREATE MESSAGE TYPE [MessageType_CustomerLog_UserLog_DepCustSetting] VALIDATION = NONE
END

IF NOT EXISTS (	
				SELECT 1
				FROM sys.service_contracts
				WHERE name = 'Contract_CustomerLog_UserLog_DepCustSetting'
				)
BEGIN
	CREATE CONTRACT [Contract_CustomerLog_UserLog_DepCustSetting] ([MessageType_CustomerLog_UserLog_DepCustSetting] SENT BY ANY)
END

ALTER SERVICE [Service_UserLog_Others_DBLOG] (ADD CONTRACT [Contract_CustomerLog_UserLog_DepCustSetting])

