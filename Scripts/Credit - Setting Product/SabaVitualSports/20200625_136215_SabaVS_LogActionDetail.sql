/*<info serverAlias=DBLOG-bodb_CustomerLog ></info>*/
/*
    Created: Winfred
    Date: 20200623
    Task: Manage ProductLaunchSiteCurrency / Can See : #131241
    DB: DBLOG/bodb_CustomerLog
*/ 
USE bodb_CustomerLog
GO

--Super
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (60528,		54,				4)	
	
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (60529,		54,				4)	
--Master	
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (65556,		54,				4)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (65557,		54,				3)			
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (65558,		54,				4)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (65559,		54,				3)		
-- Agent	
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (70584,		54,				4)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (70585,		54,				3)			
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (70586,		54,				2)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (70587,		54,				4)			
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (70588,		54,				3)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (70589,		54,				2)		

-- Member	
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75612,		54,				4)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75613,		54,				3)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75614,		54,				2)			
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75615,		54,				1)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75616,		54,				4)			
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75617,		54,				3)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75618,		54,				2)		
INSERT INTO [dbo].[LogActionDetail]	
([ActionID],		[ProductID],	[Level])
VALUES (75619,		54,				1)							