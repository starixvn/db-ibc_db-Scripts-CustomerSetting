/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20211027@Winfred
	Task : Create trigger [CustLimitPTSetting][Redmine:#162476]
	DB:  DBTP/bodb02 
*/
USE bodb02
GO

CREATE TRIGGER [dbo].[CustLimitPTSetting_update] ON [dbo].[CustLimitPTSetting] AFTER UPDATE
AS
/*
		Task : NAP CM -  Limit Daily PT Update
		DB: DBTP/bodb02
		Original: 20211027@Winfred
		Revisions:
			- 20211027@Winfred: Create trigger [Redmine: #162476]
		Param's Explanation: 
			

	*/
BEGIN 
	SET NOCOUNT ON
	INSERT INTO bodb_CustHistory.dbo.[CustLimitPTSetting_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[ActorID],
		[PTCount],
		[LastUpdated]
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[ActorID],
		[PTCount],
		[LastUpdated]
	FROM [DELETED]
	
END