/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230228@Helios
	Task: Initial data system setting for Backup Domain telegram bot service [#RedmineID:#184101]
	DB: DBBOT/bodb_Chatbot
	Original:

	Revisions:  
	- 20230307@Helios : Edit and HARD CODE VALUES
*/
use bodb_Chatbot

/*REMOVE DATA OLD*/

-- COLLECT FunctionID , ActionID Of Available Domains
DECLARE @FunctionID SMALLINT , @ActionID SMALLINT

SELECT @FunctionID = FunctionID FROM BotFunction WITH (NOLOCK) WHERE FunctionKey = 'AvailableDomains'

SELECT @ActionID = ActionID FROM BotAction WITH (NOLOCK) WHERE ActionName = 'Available Domains' 

-- DELETE BotResource

DELETE FROM BotResource WITH (ROWLOCK, UPDLOCK) WHERE Language ='en-US' AND ResourceKey IN (@FunctionID ,@ActionID)

-- DELETE BotFunction
DELETE FROM BotFunction WITH (ROWLOCK, UPDLOCK) WHERE FunctionID = @FunctionID

-- DELETE BotAction
DELETE FROM BotAction WITH (ROWLOCK, UPDLOCK) WHERE ActionID = @ActionID


/*INSERT DATA HARDCODE*/

 -- [BotFunction]
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
SELECT 19 , 'Available Domains' , 'AvailableDomains' , 1  , '/domain' , 1 , 5 , NULL , NULL

 -- [BotAction]
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
SELECT 48 , 'Available Domains' , 1 , '/domain' , 19 , 0 , 1 , 1 , 5

 -- [BotResource]
 INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT 'Function_Name' , 19 , 'en-US' , 'Available Domains'
UNION ALL
SELECT 'Action_Name' , 48 , 'en-US' , 'Available Domains'
UNION ALL
SELECT 'Function_Description' , 19 , 'en-US' , 'Get a list of all the available backup domains.'
UNION ALL
SELECT 'Action_Description' , 48 , 'en-US' , 'Get a list of all the available backup domains.'


/*UPDATE DATA ACTION NAME: Setting*/

IF EXISTS (SELECT 1 FROM BotAction WITH(NOLOCK) WHERE ActionName = 'Settings' AND ActionID = 11 )
BEGIN
	UPDATE b SET [Order] = 7
	FROM BotAction b WITH (ROWLOCK, UPDLOCK)
	WHERE ActionName = 'Settings' AND ActionID = 11 
END

ELSE
BEGIN
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
SELECT 11 , 'Settings' , 1 , '/settings' , 12 , 0 , 0 , 0 , 7
END