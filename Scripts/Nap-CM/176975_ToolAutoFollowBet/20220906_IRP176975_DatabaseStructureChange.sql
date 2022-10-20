/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220906@Johnson
	Task: Database structure change to manage follow bet account [Redmine: #176975]
	DB: DBCUST/CustDB
*/

CREATE TABLE [dbo].[Acc_CustFollowBet](
	[CustID] [int] NOT NULL,	
	[DummyAgentID] [int] NOT NULL,
	[DummyCustID] [int] NOT NULL,
	[DummyUsername] [varchar](30) NULL,
	[Creator] [int] NULL,
	[isActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Acc_CustFollowBet] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[DummyAgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]