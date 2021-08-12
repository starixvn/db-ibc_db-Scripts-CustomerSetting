/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20210513@Winfred
	Task : Create trigger CustMaxPayoutSetting_Member[Redmine:#154104]
	DB:  DBTP/bodb02 
*/
USE bodb02
GO

CREATE TRIGGER [dbo].[CustMaxPayoutSetting_Member_update] ON [dbo].[CustMaxPayoutSetting_Member] AFTER UPDATE
AS
/*
		Task : Parlay Max Payout for credit site
		DB: DBTP/bodb02
		Original: 20210513@Winfred
		Revisions:
			- 20210513@Winfred: Create trigger [Redmine: #154104]
		Param's Explanation: 
			

	*/
BEGIN 
	SET NOCOUNT ON
	INSERT INTO bodb_CustHistory.dbo.[CustMaxPayoutSetting_Member_History] (
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[SingleMatchParlay],
		[Combo2],
		[Combo35],
		[ComboOver6]
	)
	SELECT
		[CustID] ,
		[SportType] ,
		[BetType] ,
		[SingleMatchParlay],
		[Combo2],
		[Combo35],
		[ComboOver6]
	FROM [DELETED]
	
END