/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230410@Johnson
	Task: database structure change
	DB: DBCUST/CustDB
*/
ALTER TABLE ProductSettingType ALTER COLUMN SettingNameDetail VARCHAR(200)

ALTER TABLE ProductSettingDetail ADD GroupID TINYINT, GroupType	TINYINT, GroupTypeOrder	TINYINT, SubGroupID	TINYINT,SubGroupOrder	TINYINT,CreationStatus	TINYINT, DisplayType	TINYINT

ALTER TABLE ProductSettingDetail_UAT ADD GroupID TINYINT, GroupType	TINYINT, GroupTypeOrder	TINYINT, SubGroupID	TINYINT,SubGroupOrder	TINYINT,CreationStatus	TINYINT, DisplayType	TINYINT
GO

CREATE TABLE [dbo].[CustPTTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[custid] [int] NOT NULL,
	[TemplateName] [varchar](50) NOT NULL,
	[IsDefault] [bit] NULL
 CONSTRAINT [PK_CustPTTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_custid_templateName] ON [dbo].[CustPTTemplate]
(
	[custid] ASC,
	[TemplateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

CREATE TABLE [dbo].[CustPTTemplateDetail](
	[TemplateID] [int] NOT NULL,
	[GroupID] [tinyint] NOT NULL,
	[SubGroupID] [tinyint] NOT NULL,
	[PT] [smallmoney] NOT NULL,
 CONSTRAINT [PK_CustPTTemplateDetail] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC,
	[GroupID] ASC,
	[SubGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

