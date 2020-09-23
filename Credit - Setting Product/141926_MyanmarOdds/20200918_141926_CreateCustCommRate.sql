/*
	Created: 20200918@Winfred
	Task : Create table CustCommRate
	DB:  DBCUST/CustDB and DBTP/bodb02 
*/
USE CustDB
GO

CREATE TABLE [dbo].[CustCommRate](
	[CustId] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[sdiscount] [decimal](9, 8) NULL,
	[adiscount] [decimal](9, 8) NULL,
	[discount] [decimal](9, 8) NULL,
	[playerdiscount] [decimal](9, 8) NULL,
 CONSTRAINT [PK_CustCommRate] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC,
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [CustSetting3rd_table]
) ON [CustSetting3rd_table]

GO


