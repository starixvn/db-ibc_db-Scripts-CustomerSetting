/*<info serverAlias="DBBOT-bodb_ChatBot" ></info>*/

/*
	Created: 20220509@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Add Index 
*/

CREATE NONCLUSTERED INDEX IX_CreatedDate ON dbo.NotificationReferenceLog (CreatedDate) ON [DATA]
GO 
