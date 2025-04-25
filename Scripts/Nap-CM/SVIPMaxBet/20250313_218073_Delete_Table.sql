/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250313@Winfred	
	Task: [NAP CM] Customer - Increase Bet Limit In-House
	DB: DBCUST/CustDB
	
	Revisions:
		- 20250313@Winfred:  [NAP CM] Customer - Increase Bet Limit Created [RedmineID: #218073]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'SVIPMaxBetPlayer_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[SVIPMaxBetPlayer_Del_InHouse]
	(
		[SiteID] [INT] NOT NULL
		,[custid] [INT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[Bettype] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[SVIPMaxBetPlayer_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_SVIPMaxBetPlayer_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_SVIPMaxBetPlayer_Del_InHouse_RepUpdateTime] ON [dbo].[SVIPMaxBetPlayer_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table SVIPMaxBetPlayer_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'SVIPMaxBetHistory_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[SVIPMaxBetHistory_Del_InHouse]
	(
		[ID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[SVIPMaxBetHistory_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_SVIPMaxBetHistory_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_SVIPMaxBetHistory_Del_InHouse_RepUpdateTime] ON [dbo].[SVIPMaxBetHistory_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table SVIPMaxBetHistory_Del_InHouse exists!!!'
END
GO
/***************************************************************************/




