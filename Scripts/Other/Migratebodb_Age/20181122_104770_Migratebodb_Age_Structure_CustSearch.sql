/*
	Created: 20181122@Elodie
	Task: Prepare structure for bodb_Age Migration
	DB: DBCUST/CustDB and all replicated servers exclude DB053/bodb02 (DB052/bodb02, DB06/bodb02, DBTP/bodb02, .....)
*/

CREATE TABLE [dbo].[custSearch](
	[userid] [int] NOT NULL,
	[username] [varchar](30) NOT NULL,
	[searchcount] [int] NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[Currency] [int] NULL,
	[GroupName] [varchar](50) NULL,
 CONSTRAINT [PK_custSearch] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[custSearch] ADD  CONSTRAINT [DF_usersearch_count]  DEFAULT ((0)) FOR [searchcount]
GO

