/*
	Created by: Winnie
	Created Date: 20180717
	Description: 
	Database: DBCust/CustDB
		
*/
USE [CustDB]
GO

CREATE TABLE [dbo].[Dep_DefaultOddGroup](
	[AgentID] [int] NOT NULL,
	[Ugroup] [varchar](3) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_DefaultOddGroup] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DATA]
) ON [DATA]

GO
