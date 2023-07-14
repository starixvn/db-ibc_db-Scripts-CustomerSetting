/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Eden@20230714
	Task: Migrate data temp table to History table [Redmine: #191243] 
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO

	INSERT INTO CustBetSetting_Agent_History( 
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,UpdateTime
		)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,UpdateTime
	FROM CustBetSetting_Agent_History_Tmp WITH(NOLOCK)

	INSERT INTO CustBetSetting_Member_History( 
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,UpdateTime
	)
	SELECT  CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,UpdateTime
	FROM CustBetSetting_Member_History_Tmp WITH(NOLOCK)

	INSERT INTO Dep_CustBetSettingGame_Agent_History( 
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
		,UpdateTime	
		)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
		,UpdateTime	
	FROM Dep_CustBetSettingGame_Agent_History_Tmp WITH(NOLOCK)


	INSERT INTO Dep_CustBetSettingGameGroup_Member_History( 
		AgentID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
		,UpdateTime
	)
	SELECT AgentID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
		,UpdateTime
	FROM Dep_CustBetSettingGameGroup_Member_History_Tmp WITH(NOLOCK)

	INSERT INTO Dep_CustBetSettingGame_Member_History( 
		CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
		,UpdateTime	
		)
	SELECT CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerNumber
		,MaxPayoutPerMatch
		,IsInserted
		,UpdateTime	
	FROM Dep_CustBetSettingGame_Member_History_Tmp WITH(NOLOCK)

