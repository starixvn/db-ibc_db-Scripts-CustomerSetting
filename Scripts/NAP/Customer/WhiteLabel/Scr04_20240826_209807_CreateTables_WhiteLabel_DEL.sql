/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240826
	Task: Create new tables - WhiteLabel [Redmine:#209807] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--WhiteLabelInfo_Del_InHouse
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WhiteLabelInfo_Del_InHouse](
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

--CREATE INDEX
CREATE CLUSTERED INDEX [IX_WhiteLabelInfo_Del_InHouse_RepUpdateTime] ON [dbo].[WhiteLabelInfo_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--WhiteLabelSetting_Del_InHouse
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WhiteLabelSetting_Del_InHouse](
	[CustID] [int] NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

--CREATE INDEX
CREATE CLUSTERED INDEX [IX_WhiteLabelSetting_Del_InHouse_RepUpdateTime] ON [dbo].[WhiteLabelSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO
