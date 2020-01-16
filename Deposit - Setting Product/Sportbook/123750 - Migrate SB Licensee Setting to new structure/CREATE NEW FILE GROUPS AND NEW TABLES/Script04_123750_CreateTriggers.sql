/*
	Created by: Eden
	Date: 20200116
	Task: Create trigges for New tables of SB - Deposit DCS & Number Games DCS [Redmine:#123750]		
	DB: DBTP/bodb02
*/
USE bodb02
GO
/*
DROP TRIGGER [dbo].[DSB_CustBetSetting_Member_update]
GO

DROP TRIGGER [dbo].[DSB_CustBetSetting_Agent_update]
GO

DROP TRIGGER [dbo].[DSB_CustGroupBetSetting_Member_update]
GO

DROP TRIGGER [dbo].[DSB_CustDiscount_Agent_update]
GO

DROP TRIGGER [dbo].[DSB_CustDiscount_Member_update]
GO

DROP TRIGGER [dbo].[DSB_CustGroupDiscount_Member_update]
GO

DROP TRIGGER [dbo].[DSB_CustPTSetting_Agent_update]
GO

DROP TRIGGER [dbo].[DSB_CustPTSetting_Member_update]
GO

DROP TRIGGER [dbo].[DSB_CustPTGroupSetting_Member_update]
GO

DROP TRIGGER [dbo].[DSB_CustSettingMode_update]
GO

DROP TRIGGER [dbo].[Dep_CustBetSettingGame_Agent_update]
GO

DROP TRIGGER [dbo].[Dep_CustBetSettingGame_Member_update]
GO

*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustBetSetting_Member_update] ON [dbo].[DSB_CustBetSetting_Member] AFTER UPDATE
AS
/* 
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustBetSetting_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustBetSetting_Member_History] (
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch		
	FROM [DELETED]
END


GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustBetSetting_Agent_update] ON [dbo].[DSB_CustBetSetting_Agent] AFTER UPDATE
AS
/* 
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustBetSetting_Agent] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustBetSetting_Agent_History] (
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch		
	FROM [DELETED]
END


GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustGroupBetSetting_Member_update] ON [dbo].[DSB_CustGroupBetSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustGroupBetSetting_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustGroupBetSetting_Member_History] (
		 AgentID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT
		 AgentID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch		
	FROM [DELETED]
END


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustDiscount_Agent_update] ON [dbo].[DSB_CustDiscount_Agent] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustDiscount_Agent] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustDiscount_Agent_History] (
		 CustId
		,Discount
	)
	SELECT
		 CustId
		,Discount
	FROM [DELETED]
END


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustDiscount_Member_update] ON [dbo].[DSB_CustDiscount_Member] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustDiscount_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustDiscount_Member_History] (
		 CustId
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	)
	SELECT
		 CustId
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustGroupDiscount_Member_update] ON [dbo].[DSB_CustGroupDiscount_Member] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustGroupDiscount_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustGroupDiscount_Member_History] (
		 AgentId
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	)
	SELECT
		 AgentId
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustPTSetting_Agent_update] ON [dbo].[DSB_CustPTSetting_Agent] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustPTSetting_Agent] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustPTSetting_Agent_History] (
		 CustId
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT
		 CustId
		,SuperPT
		,MasterPT
		,AgentPT
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustPTSetting_Member_update] ON [dbo].[DSB_CustPTSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustPTSetting_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustPTSetting_Member_History] (
		 CustId
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT
		 CustId
		,SuperPT
		,MasterPT
		,AgentPT
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustPTGroupSetting_Member_update] ON [dbo].[DSB_CustPTGroupSetting_Member] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustPTGroupSetting_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustPTGroupSetting_Member_History] (
		 AgentID
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT
		 AgentID
		,SuperPT
		,MasterPT
		,AgentPT
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[DSB_CustSettingMode_update] ON [dbo].[DSB_CustSettingMode] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [DSB_CustSettingMode] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[DSB_CustSettingMode_History] (
		 CustID
		,IsGroupedPT
		,IsGroupedComm
		,IsGroupedBetLimit
	)
	SELECT
		 CustID
		,IsGroupedPT
		,IsGroupedComm
		,IsGroupedBetLimit
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Dep_CustBetSettingGame_Agent_update] ON [dbo].[Dep_CustBetSettingGame_Agent] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [Dep_CustBetSettingGame_Agent] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[Dep_CustBetSettingGame_Agent_History] (
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerBall
	)
	SELECT
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerBall
	FROM [DELETED]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Dep_CustBetSettingGame_Member_update] ON [dbo].[Dep_CustBetSettingGame_Member] AFTER UPDATE
AS
/*
	Created by: 20200116@Eden
	Task: Trigger for updating [Dep_CustBetSettingGame_Member] table [#RM:123750]
	DB: DBTP/bodb02

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO bodb_CustHistory.dbo.[Dep_CustBetSettingGame_Member_History] (
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerBall
	)
	SELECT
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerBall
	FROM [DELETED]
END

GO










