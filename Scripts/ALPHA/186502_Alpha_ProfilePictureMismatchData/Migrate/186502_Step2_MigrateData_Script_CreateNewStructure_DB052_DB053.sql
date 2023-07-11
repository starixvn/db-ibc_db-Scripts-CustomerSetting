/*<info serverAlias="DBAGE-bodb02, DBTP-bodb02"></info>*/
/*
	Created by: Helios
	Date: 14/6/2023 3:56:42 AM
	Task: Create new Database Structure [Redmine:#186502] 
	DB:	DBAGE-bodb02 & DBTP-bodb02
*/
USE [master]
GO
ALTER DATABASE bodb02 ADD FILEGROUP [ProfilePicture];
GO  
ALTER DATABASE bodb02    
ADD FILE   
( NAME = N'ProfilePicture', FILENAME = N'/mnt/DiskG/bodb02/ProfilePicture.ndf' , SIZE = 32768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ) -- Edit path file by environment deployed
TO FILEGROUP [ProfilePicture];  
GO


USE [bodb02]
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

