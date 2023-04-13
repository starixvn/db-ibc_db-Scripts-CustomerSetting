/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
 Created: 20230210@Helios
 Task : Create new table CustFeedback
 DB: DBBOT.bodb_ChatBot  
  
     
 Revisions:    
  - 20230210@Helios: Create new table CustFeedback  
 Parameter's Explanation:  
*/

USE [bodb_ChatBot]
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustFeedback]') AND type in (N'U'))
DROP TABLE [dbo].[CustFeedback]
GO

CREATE TABLE [dbo].[CustFeedback](
	[CustID] [int] NOT NULL,
	[Subaccid] [int] NOT NULL,
	[Comment] [nvarchar](4000) NULL,
	[Rate] [tinyint] NULL,
	[CreatedDate] [smalldatetime] NULL,
) 
GO
SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_CustFeedback]    Script Date: 2/8/2023 4:06:18 PM ******/
CREATE CLUSTERED INDEX [IX_CustFeedback] ON [dbo].[CustFeedback]
(
	[CreatedDate] ASC,
	[CustID] ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO