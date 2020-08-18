/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200812@Eden
	Task: Create Dep_UMConfig table [Redmine:#136741]	
		FunctionType : 1.FirstDeposit
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_UMConfig](
	[FunctionType] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[LicenseeID] [int] NOT NULL,
	[BeginTime] [smalldatetime] NULL,
	[EndTime] [smalldatetime] NULL,
	[Time_Stamp] [TimeStamp] NULL,
CONSTRAINT [PK_Dep_UMConfig] PRIMARY KEY CLUSTERED 
(
	[FunctionType] ASC,
	[ProductID] ASC,
	[SettingType] ASC,
	[LicenseeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Data]

) ON [Data]

GO

