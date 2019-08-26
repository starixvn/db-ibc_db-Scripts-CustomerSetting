/*
	Created: Winnie
	Task: Create table [Temp_StakeLevel] and insert data of PP, Macau. [RedmineID:#118564]
	DB: DBCUST/CustDB
	Date: 20190826
*/ 


USE [CustDB]
GO

CREATE TABLE [dbo].[Temp_StakeLevel](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [int] NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ExchangeId] [int] NULL,
	[ResourceId] [int] NULL,
	[GameGroupID] [int] NOT NULL CONSTRAINT [DF_Temp_StakeLevel_GameGroupID]  DEFAULT ((0)),
 CONSTRAINT [PK_Temp_StakeLevel] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO


INSERT INTO  [Temp_StakeLevel] (
			[StakeLevelID]
			,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId]
           ,[ResourceId]
           ,[GameGroupID])
SELECT 
			[StakeLevelID]
			,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId]
           ,[ResourceId]
           ,[GameGroupID]
FROM StakeLevel (NOLOCK) WHERE GameTypeID IN(4001,4101)