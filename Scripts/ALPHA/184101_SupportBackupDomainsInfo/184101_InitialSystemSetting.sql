/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230228@Helios
	Task: Initial data system setting for Backup Domain telegram bot service [#RedmineID:#184101]
	DB: DBBOT/bodb_Chatbot
*/




DECLARE @FunctionID SmallINT , @ActionID SmallINT 
SELECT @FunctionID = MAX(FunctionID) + 1 from BotFunction (NOLOCK)

-- Insert BotFunction
INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
		   ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
		   ,[Order]
		   ,[Priority]
		   ,[ParentID])

SELECT @FunctionID ,  'Backup Domains' , 'BackupDomains' , 3 , NULL , 1 , 202 , NULL , NULL

SELECT @ActionID = MAX(ActionID) + 1  FROM BotAction (NOLOCK)

-- Insert BotAction
INSERT INTO [dbo].[BotAction]
           ([ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction]
           ,[Order])
SELECT @ActionID ,  'Backup Domains' , 1 , @FunctionID  , @FunctionID , 0 , 1 , 0 , 5011

-- Insert BotResource
INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT 'Function_Name' , @FunctionID , 'en-US' , 'Backup Domains'
UNION ALL
SELECT 'Action_Name' , @ActionID , 'en-US' , 'Backup Domains'

