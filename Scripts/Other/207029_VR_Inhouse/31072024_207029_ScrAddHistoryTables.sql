/*<info serverAlias="DBCust-CustDB_History"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting add history tables  [redmine: #207029]
	DB: DBCust/CustDB_History
*/

USE CustDB_History
GO
ALTER DATABASE [CustDB_History] ADD FILEGROUP [VirtualSetting_table] 
GO
ALTER DATABASE [CustDB_History] ADD FILE 
( NAME = N'VirtualSetting_table01', FILENAME = N'/mnt/DiskG/CustDB_History/VirtualSetting_table01.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'VirtualSetting_table02', FILENAME = N'/mnt/DiskG/CustDB_History/VirtualSetting_table02.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'VirtualSetting_table03', FILENAME = N'/mnt/DiskG/CustDB_History/VirtualSetting_table03.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [VirtualSetting_table]
GO

CREATE TABLE [dbo].[CustVirtualSetting_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_CustVirtualSetting_History_UpdateTime]  DEFAULT (getdate()),
	[custid] [int] NOT NULL,
	[seqNo] [tinyint] NOT NULL,
	[bitmapVirtual] [binary](64) NOT NULL,
CONSTRAINT [PK_CustVirtualSetting_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [VirtualSetting_table]
GO

CREATE TABLE [dbo].[VRCustLockStatus_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[CustID] [int] NOT NULL ,
	[Type] [tinyint] NOT NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_VRCustLockStatus_History_UpdateTime]  DEFAULT (getdate()),
	[IsLocked] [bit] NOT NULL,
CONSTRAINT [PK_VRCustLockStatus_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [VirtualSetting_table]
GO