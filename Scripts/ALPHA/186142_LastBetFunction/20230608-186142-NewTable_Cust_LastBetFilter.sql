/*<info serverAlias="DBCUST-CustDB, DBACC-bodb02"></info>*/

/*
	Created: 20230608@Tacy
	Task: Create new table Cust_LastBetFilter [RedmineID: #186142]
		 https://nexdev.net/issues/186142 
	Database: DBCUST-CustDB,DBACC-bodb02
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 CREATE TABLE [dbo].[Cust_LastBetFilter](
	CustID		[int] NOT NULL,
	SubAccID	[int] NOT NULL,
	FilterID	[int] NOT NULL IDENTITY(1,1),
	FilterName	[nvarchar](50) NOT NULL,
	FilterValue	[varchar](max) NOT NULL,
	IsDefault	[bit] NOT NULL,
	CreatedDate	[datetime] NOT NULL,
 CONSTRAINT [PK_Cust_LastBetFilter] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SubAccID] ASC,
	[FilterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Cust_LastBetFilter] ADD  CONSTRAINT [DF_Cust_LastBetFilter_IsDefault]  DEFAULT (0) FOR [IsDefault]
GO

ALTER TABLE [dbo].[Cust_LastBetFilter] ADD  CONSTRAINT [DF_Cust_LastBetFilter_CreatedDate]  DEFAULT (GETDATE()) FOR [CreatedDate]
GO