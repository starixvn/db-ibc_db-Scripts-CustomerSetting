/*
	Created: 20200418@@Johnson
	Task : prepare structure for auto feedback [redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

CREATE TABLE [dbo].[SystemSetting](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SettingName] [varchar](50) NOT NULL,
	[Value] [varchar](50) NULL,
 CONSTRAINT [PK_SystemSetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[crmSettingMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SettingID] [int] NOT NULL,
	[SettingSource] [varchar](50) NULL,
 CONSTRAINT [PK_crmSettingMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[crmLicenseeMapping](	
	[SettingID] [int] NOT NULL,
	[Site] [varchar](50) NULL,
	[custid] [int] NULL
 CONSTRAINT [PK_crmLicenseeMapping] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO
