/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250211@Tacy	
	Task: Scale Out DBCUST - Setup InHouse replication on Dist
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250211@Tacy: Created [RedmineID: #216870]

	Tables:
		ProfilePicture
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProfilePicture
CREATE TABLE [dbo].[ProfilePicture](
	[ImageId] [int] NOT NULL,
	[Image] [varbinary](max) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ProfilePicture] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProfilePicture] ADD  CONSTRAINT [DF_ProfilePicture_IsDeleted]  DEFAULT (0) FOR [IsDeleted]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_ProfilePicture] ON [dbo].[ProfilePicture]
(
	[RepUpdateTime] ASC
)
GO
