/*
	Created: Johnson
	Date: 20180924
	Task: new structure for logging customer settings for cash
	DB: DBLOG/bodb_customerlog
*/

USE [bodb_CustomerLog]
GO

--create temporary table on FileGroup [Data] for UAT testing then drop when launch PRO
CREATE TABLE [dbo].[UserLog_Dep_CustSetting](
  [LogID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
  [UserID] [int] NULL,
  [CustID] [int] NULL,
  [logDate] [datetime] NULL,  
  [ActionID] [int] NULL,
  [TrackingValue] [varchar](max) NULL,  
  [TrackingValue2] [varchar](max) NULL,
  [Duration] [int] NULL,
  [Language] [VARCHAR](3),
  [IP] [VARCHAR](15)
) ON DATA


--Deploy this script when launch PRO

-- Adds four new filegroups to the bodb_CustomerLog database  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_18M09;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_18M10;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_18M11;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_18M12;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M01;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M02;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M03;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M04;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M05;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M06;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M07;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M08;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M09;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M10;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M11;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_19M12;  
GO  
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Dep_CustSetting_MAX;  
GO  

-- Adds one file for each filegroup.  
--local
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_18M09,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_18M09.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_18M09 
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_18M10,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_18M10.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_18M10    
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_18M11,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_18M11.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_18M11
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_18M12,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_18M12.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_18M12
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M01,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M01.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M01
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M02,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M02.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M02
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M03,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M03.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M03
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M04,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M04.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M04
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M05,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M05.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M05
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M06,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M06.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M06
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M07,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M07.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M07
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M08,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M08.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M08
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M09,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M09.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M09
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M10,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M10.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M10
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M11,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M11.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M11
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_19M12,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_19M12.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_19M12
GO
ALTER DATABASE bodb_CustomerLog ADD FILE ( NAME = Dep_CustSetting_MAX,  
    FILENAME = 'D:\IBC_DB\bodb_CustomerLog\Dep_CustSetting\Dep_CustSetting_MAX.ndf', SIZE = 5MB, FILEGROWTH = 10MB)  
TO FILEGROUP Dep_CustSetting_MAX
GO

----create partition function for UserLog_Dep_CustSetting
CREATE PARTITION FUNCTION pf_Dep_CustSetting_Monthly (datetime)  
    AS RANGE LEFT FOR VALUES (N'2018-09-30T23:59:59.997', N'2018-10-31T23:59:59.997', N'2018-11-30T23:59:59.997', N'2018-12-31T23:59:59.997', N'2019-01-31T23:59:59.997', N'2019-02-28T23:59:59.997', N'2019-03-31T23:59:59.997', N'2019-04-30T23:59:59.997', N'2019-05-31T23:59:59.997', N'2019-06-30T23:59:59.997', N'2019-07-31T23:59:59.997', N'2019-08-31T23:59:59.997', N'2019-09-30T23:59:59.997', N'2019-10-31T23:59:59.997', N'2019-11-30T23:59:59.997', N'2019-12-31T23:59:59.997')  
GO 

--create partition scheme 
CREATE PARTITION SCHEME [ps_Dep_CustSetting_monthly] AS PARTITION [pf_Dep_CustSetting_monthly] TO ([Dep_CustSetting_18M09], [Dep_CustSetting_18M10], [Dep_CustSetting_18M11], [Dep_CustSetting_18M12], [Dep_CustSetting_19M01], [Dep_CustSetting_19M02], [Dep_CustSetting_19M03], [Dep_CustSetting_19M04], [Dep_CustSetting_19M05], [Dep_CustSetting_19M06], [Dep_CustSetting_19M07], [Dep_CustSetting_19M08], [Dep_CustSetting_19M09], [Dep_CustSetting_19M10], [Dep_CustSetting_19M11], [Dep_CustSetting_19M12], [RUNSP_MAX])
GO

/***** Object:  Table [dbo].[UserLog_Dep_CustSetting]    Script Date: 9/20/2018 4:19:26 AM *****/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserLog_Dep_CustSetting](
		[LogID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
		[UserID] [int] NULL,
		[CustID] [int] NULL,
		[logDate] [datetime] NULL,		
		[ActionID] [int] NULL,
		[TrackingValue] [varchar](max) NULL,		
		[TrackingValue2] [varchar](max) NULL,
		[Duration] [int] NULL,
		[Language] [VARCHAR](3),
		[IP] [VARCHAR](15)
) ON [ps_Dep_CustSetting_monthly]([logdate])

GO

SET ANSI_PADDING OFF
GO

GRANT INSERT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbAdminNet] AS [dbo]
GO

GRANT SELECT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbAdminNet] AS [dbo]
GO

GRANT INSERT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbDownlineNet] AS [dbo]
GO

GRANT SELECT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbDownlineNet] AS [dbo]
GO

GRANT INSERT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbDownlineNetView] AS [dbo]
GO

GRANT SELECT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbDownlineNetView] AS [dbo]
GO

GRANT INSERT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbLicenseeNet] AS [dbo]
GO

GRANT SELECT ON [dbo].[UserLog_Dep_CustSetting] TO [bodbLicenseeNet] AS [dbo]
GO

GRANT INSERT ON [dbo].[UserLog_Dep_CustSetting] TO [Dot_Admin] AS [dbo]
GO

GRANT SELECT ON [dbo].[UserLog_Dep_CustSetting] TO [Dot_Admin] AS [dbo]
GO

GRANT INSERT ON [dbo].[UserLog_Dep_CustSetting] TO [Dot_Member] AS [dbo]
GO

GRANT SELECT ON [dbo].[UserLog_Dep_CustSetting] TO [Dot_Member] AS [dbo]
GO

/***** Object:  Index [IX_UserLog_Dep_CustSetting]    Script Date: 9/20/2018 4:19:27 AM *****/
CREATE CLUSTERED INDEX [IX_UserLog_Dep_CustSetting] ON [dbo].[UserLog_Dep_CustSetting]
(
 [custid] ASC,
 [logdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) 
ON [ps_Dep_CustSetting_monthly]([logdate])
GO

/***** Object:  Index [IX_ActionID_Custid]    Script Date: 9/20/2018 4:19:27 AM *****/
CREATE NONCLUSTERED INDEX [IX_ActionID_Custid] ON [dbo].[UserLog_Dep_CustSetting]
(
 [ActionID] ASC,
 [custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) 
ON [ps_Dep_CustSetting_monthly]([logdate])
GO

SET ANSI_PADDING ON

GO

ALTER TABLE [dbo].[UserLog_Dep_CustSetting] ADD  CONSTRAINT [DF_UserLog_Dep_CustSetting2_logdate]  DEFAULT (getdate()) FOR [logdate]
GO
