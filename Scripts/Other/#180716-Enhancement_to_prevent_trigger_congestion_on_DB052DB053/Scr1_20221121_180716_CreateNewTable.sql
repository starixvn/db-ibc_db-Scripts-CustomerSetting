/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Create new table [#180716]
	DB: DBCust/CustDB
*/
USE CustDB
GO
DROP TABLE [dbo].[CustWLMonitored_Setting_Pending]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustWLMonitored_Setting_Pending](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustID] [int] NOT NULL,
	[recommend] [int] NOT NULL,
	[IsDeleted] [BIT] NOT NULL,
	CONSTRAINT [PK_CustWLMonitored_Setting_Pending] PRIMARY KEY CLUSTERED 
(
	[ID]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
