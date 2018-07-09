/*
	Created By: Elodie
	Created Date: 20180621
	Description: Add new table to count new msg [RedmineID: #94705]	
	DB: DBMSG/bodb_Message
*/

USE [bodb_Message]
GO

/****** Object:  Table [dbo].[MsgCustReadStatus]    Script Date: 6/22/2018 9:45:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MsgCustReadStatus](
	[CustID] [INT] NOT NULL,
	[SubAccID] [INT] NULL,
	[LastSeenNormalMsg] [DATETIME] NOT NULL,
	[LastSeenPersonalMsg] [DATETIME] NOT NULL,
	[LastSeenSpecialMsg] [DATETIME] NOT NULL,
	[LastSeenSystemUpdMsg] [DATETIME] NOT NULL,
 CONSTRAINT [PK_MsgCustReadStatus] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO