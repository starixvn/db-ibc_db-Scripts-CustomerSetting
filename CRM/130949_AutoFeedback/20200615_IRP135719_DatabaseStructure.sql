/*
	Created: 20200615@Johnson
	Task : database structure to check missing fb[redmine:#135719]
	DB: DBCRM/bodb_CRM	
*/
CREATE TABLE [dbo].[crmMessageImport](
	[MessageID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[IsProcessed] [bit] NULL,
 CONSTRAINT [PK_crmMessageImport] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO
