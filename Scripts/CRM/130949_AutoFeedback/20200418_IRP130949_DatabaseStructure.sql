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
	[SettingID] [int] NOT NULL,
	[SettingSource] [varchar](200) NULL,
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_crmSettingMapping] ON [dbo].crmSettingMapping 
(
	[SettingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
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
