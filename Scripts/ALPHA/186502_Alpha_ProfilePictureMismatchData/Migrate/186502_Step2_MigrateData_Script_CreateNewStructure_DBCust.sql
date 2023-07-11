/*<info serverAlias="DBCUST-bodb_Credit"></info>*/
/*
	Created by: Helios
	Date: 23/05/2023
	Task: Create CustProfilePicture , ProfilePicture table on DBCUST/bodb_Credit [Redmine:#186502]	
	DB: DBCUST/bodb_Credit
*/
USE [master]
GO
ALTER DATABASE bodb_Credit ADD FILEGROUP [ProfilePicture];
GO  
ALTER DATABASE bodb_Credit   
ADD FILE   
( NAME = N'ProfilePicture', FILENAME = N'/mnt/DiskG/bodb02/ProfilePicture.ndf' , SIZE = 32768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ) -- Edit path file by environment deployed
TO FILEGROUP [ProfilePicture];  
GO

USE [bodb_Credit]
GO
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

CREATE USER [bodbDownlineNet] FOR LOGIN [bodbDownlineNet] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [bodbDownlineNetView] FOR LOGIN [bodbDownlineNetView] WITH DEFAULT_SCHEMA=[dbo]
GO