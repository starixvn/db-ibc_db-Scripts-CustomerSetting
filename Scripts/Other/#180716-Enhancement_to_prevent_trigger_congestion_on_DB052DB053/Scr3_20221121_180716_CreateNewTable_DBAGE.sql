/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20221121@Eden
	Task: Create new table [#180716]
	DB: DBAGE/bodb02
*/
USE bodb02
GO
DROP TABLE [dbo].[CustWLMonitored_Setting]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustWLMonitored_Setting](
	[CustID] [int] NOT NULL,
	[recommend] [int] NOT NULL
	CONSTRAINT [PK_CustWLMonitored_Setting] PRIMARY KEY CLUSTERED 
(
	recommend, CustID
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
