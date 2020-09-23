/*
	Created: 20200918@Winfred
	Task : Create table AgentCommRate
	DB:  Add to CustDB_Custsetting publication 
*/
USE CustDB
GO
CREATE TABLE [dbo].[AgentCommRate](
	[CustId] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[CommRate] [decimal](9, 8) NULL,
 CONSTRAINT [PK_AgentCommRate] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC,
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [CustSetting3rd_table]
) ON [CustSetting3rd_table]

GO


