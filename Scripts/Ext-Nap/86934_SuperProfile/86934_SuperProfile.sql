/*
	CreatedDate: 20180718@Elodie
	Task: Prepare new structure to support ALPHA chat bot via letstalk
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

/****** Object:  Table [dbo].[custInfo]    Script Date: 7/27/2018 2:36:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustSuperProfile](
	[custid] [int] NOT NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[mobilephone] [nvarchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[remark] [nvarchar](50) NULL,	
 CONSTRAINT [PK_CustSuperProfile] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [table_customer]
) ON [table_customer]

GO


