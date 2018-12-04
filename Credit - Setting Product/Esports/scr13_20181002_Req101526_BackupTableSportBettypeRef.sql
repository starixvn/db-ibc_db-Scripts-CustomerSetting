/*
	Created: Winnie
	Date: 20181024
	Task: Back up table Sport_Bettype_Reference
	DB: DBTXN/bodb02
*/
USE [bodb02]
GO

/****** Object:  Table [dbo].[Sport_Bettype_Reference]    Script Date: 10/24/2018 15:30:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Sport_Bettype_Reference_BKEsport](
	[Bettype] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[isLicensee] [bit] NOT NULL,
	[BettypeRef] [int] NULL,
	[SporttypeRef] [smallint] NULL,
	[isActive] [bit] NULL,
	[Site] [nvarchar](50) NOT NULL,
	[RefTableName] [varchar](50) NULL,
 CONSTRAINT [PK_Sport_Bettype_Reference_BKEsport] PRIMARY KEY CLUSTERED 
(
	[Bettype] ASC,
	[Sporttype] ASC,
	[isLicensee] ASC,
	[Site] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]


ALTER TABLE [dbo].[Sport_Bettype_Reference_BKEsport] ADD  CONSTRAINT [DF_Sport_Bettype_Reference_BKEsport_Site]  DEFAULT (N'ALL') FOR [Site]
GO

INSERT INTO [bodb02].[dbo].[Sport_Bettype_Reference_BKEsport]
           ([Bettype]
           ,[Sporttype]
           ,[isLicensee]
           ,[BettypeRef]
           ,[SporttypeRef]
           ,[isActive]
           ,[Site]
           ,[RefTableName])
SELECT [Bettype]
           ,[Sporttype]
           ,[isLicensee]
           ,[BettypeRef]
           ,[SporttypeRef]
           ,[isActive]
           ,[Site]
           ,[RefTableName]
FROM Sport_Bettype_Reference
WHERE  Sporttype=43

