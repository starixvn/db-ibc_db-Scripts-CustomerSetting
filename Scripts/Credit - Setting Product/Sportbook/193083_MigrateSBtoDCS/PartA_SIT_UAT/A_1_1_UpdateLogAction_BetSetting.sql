/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230913@Helios
	Task: Initial Data LogAction (Com , BetSetting)  [#193083]
	DB: DBLOG/bodb_CustomerLog
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	-- Initial for BetSetting:

	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE Actionid  IN (220037,220038,220039,220040,220041,220042,220043))
	BEGIN
		INSERT INTO LogAction 
		(
			ActionID
		    , ActionTypeID
		    , SPName
		    , ActionNameEN
		    , ActionNameCH
		    , ActionNameCS
		    , ActionNameJP
		    , ActionNameIT
		    , ActionNameTH
		    , ActionNameKO
		    , XsltContent
		    , IsInternal
		    , ActionNameVI
		    , ActionNameCN
		)

		SELECT 
			CASE 
				WHEN ActionID = 220020  THEN 220037
				WHEN ActionID = 220021  THEN 220038
				WHEN ActionID = 220022  THEN 220039
				WHEN ActionID = 220023  THEN 220040
				WHEN ActionID = 220024  THEN 220041
				WHEN ActionID = 220025  THEN 220042
				WHEN ActionID = 220026  THEN 220043
			END  AS ActionID 
				, ActionTypeID
				, 'Acc_CustSetting_BetSetting151Upd' AS SPName
				, ActionNameEN
				, ActionNameCH
				, ActionNameCS
				, ActionNameJP
				, ActionNameIT
				, ActionNameTH
				, ActionNameKO
				, XsltContent
				, IsInternal
				, ActionNameVI
				, ActionNameCN
		FROM LogAction la WITH (NOLOCK)
		WHERE la.SPName = 'Acc_CustomerUpd_BetSetting'
		AND
		ActionID  IN (220020,220021,220022,220023,220024,220025,220026)

	END

	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE Actionid  IN (220037,220038,220039,220040,220041,220042,220043))
	BEGIN
		INSERT INTO LogActionDetail (ActionID, ProductID, Level)
			SELECT 220037 , 1 , 4
		UNION SELECT 220038 , 1 , 4
		UNION SELECT 220039 , 1 , 3
		UNION SELECT 220040 , 1 , 3
		UNION SELECT 220041 , 1 , 2
		UNION SELECT 220042 , 1 , 2
		UNION SELECT 220043 , 1 , 1
	END