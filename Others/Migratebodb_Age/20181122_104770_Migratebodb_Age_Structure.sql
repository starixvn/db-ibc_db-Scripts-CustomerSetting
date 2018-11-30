/*
	Created: 20181122@Elodie
	Task: Prepare structure for bodb_Age Migration
	DB: DBCUST/CustDB and all replicated servers (DB052/bodb02, DB053/bodb02, DB06/bodb02, DBTP/bodb02, .....)
*/
USE bodb02
GO

CREATE TABLE [dbo].[Acc_CustGroup](
	[CustID] [int] NOT NULL,
	[RoleID] [tinyint] NOT NULL,
	[GroupName] [varchar](50) NOT NULL,
	[rv] [timestamp] NOT NULL,
	[IsPayout] [bit] NULL,
 CONSTRAINT [PK_AccGroup] PRIMARY KEY NONCLUSTERED 
(
	[CustID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[Acc_CustGroup] ADD  CONSTRAINT [DF_Acc_CustGroup_IsPayout]  DEFAULT ((0)) FOR [IsPayout]
GO


CREATE TABLE [dbo].[Age_CustDateLimit](
	[CustId] [int] NOT NULL,
	[MinDate] [smalldatetime] NULL,
	[LimitDays] [smallint] NULL,
 CONSTRAINT [PK_Age_CustDateLimit] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
CREATE TABLE [dbo].[Age_CustProfilePicture](
	[custid] [int] NOT NULL,
	[image] [varbinary](max) NOT NULL,
	[modified] [datetime] NULL,
	[rv] [timestamp] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO

CREATE TABLE [dbo].[Age_CustSeq](
	[SeqName] [varchar](3) NOT NULL,
	[Type] [tinyint] NOT NULL,
 CONSTRAINT [PK_Age_CustSeq] PRIMARY KEY CLUSTERED 
(
	[SeqName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
