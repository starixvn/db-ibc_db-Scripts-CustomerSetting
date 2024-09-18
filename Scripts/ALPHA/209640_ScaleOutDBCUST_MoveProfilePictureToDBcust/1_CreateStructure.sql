/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 21/08/2024
	Task: Scale Out DBCUST - Move CustProfilePicture and ProfilePicture to DBcust - Create Structure [Redmine:#209640] 
	DB: DBCUST/CustDB 
*/


CREATE TABLE [dbo].[ProfilePicture](
	[ImageId] [int] NOT NULL,
	[Image] [varbinary](max) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ProfilePicture] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ProfilePicture]
) ON [ProfilePicture]
GO
ALTER TABLE [dbo].[ProfilePicture] ADD  CONSTRAINT [DF_ProfilePicture_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_ProfilePicture] ON [dbo].[ProfilePicture]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ProfilePicture]
GO


CREATE TABLE [dbo].[CustProfilePicture](
	[CustId] [int] NOT NULL,
	[ImageId] [int] NOT NULL,
	[Modified] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_CustProfilePicture] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ProfilePicture]
) ON [ProfilePicture]
GO
ALTER TABLE [dbo].[CustProfilePicture] ADD  CONSTRAINT [DF_CustProfilePicture_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_CustProfilePicture] ON [dbo].[CustProfilePicture]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ProfilePicture]
GO
