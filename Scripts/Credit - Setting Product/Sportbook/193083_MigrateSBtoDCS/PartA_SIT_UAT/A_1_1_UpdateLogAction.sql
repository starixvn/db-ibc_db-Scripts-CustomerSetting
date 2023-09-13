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
	-- Initial for Commission:

	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE Actionid  IN (251,252,253,254))
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
				WHEN ActionID = 204  THEN 251
				WHEN ActionID = 205 THEN  252
				WHEN ActionID = 206  THEN 253
				WHEN ActionID = 207  THEN 254
			END  AS ActionID 
				, ActionTypeID
				, 'Acc_CustSetting_Discount150Upd' AS SPName
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
		WHERE ActionID  IN (204,205,206,207)

	END

	-- Initial for BetSetting:

	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE Actionid  IN (220020,220021,220022,220023,220024,220025,220026))
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

	IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE Actionid  IN (220020,220021,220022,220023,220024,220025,220026))
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

	

	-- Initial for ParlayMaxPayout:

	--IF NOT EXISTS (SELECT 1 FROM LogAction la WITH (NOLOCK) WHERE Actionid  IN (220044,220045,220046,220047,220048,220049,220050))
	--BEGIN
	--	INSERT INTO LogAction 
	--	(
	--		ActionID
	--	    , ActionTypeID
	--	    , SPName
	--	    , ActionNameEN
	--	    , ActionNameCH
	--	    , ActionNameCS
	--	    , ActionNameJP
	--	    , ActionNameIT
	--	    , ActionNameTH
	--	    , ActionNameKO
	--	    , XsltContent
	--	    , IsInternal
	--	    , ActionNameVI
	--	    , ActionNameCN
	--	)

	--	SELECT 
	--		CASE 
	--			WHEN ActionID = 220000  THEN 220044
	--			WHEN ActionID = 220001  THEN 220045
	--			WHEN ActionID = 220002  THEN 220046
	--			WHEN ActionID = 220003  THEN 220047
	--			WHEN ActionID = 220004  THEN 220048
	--			WHEN ActionID = 220005  THEN 220049
	--			WHEN ActionID = 220006  THEN 220050
	--		END  AS ActionID 
	--			, ActionTypeID
	--			, SPName
	--			, ActionNameEN
	--			, ActionNameCH
	--			, ActionNameCS
	--			, ActionNameJP
	--			, ActionNameIT
	--			, ActionNameTH
	--			, ActionNameKO
	--			, XsltContent
	--			, IsInternal
	--			, ActionNameVI
	--			, ActionNameCN
	--	FROM LogAction la WITH (NOLOCK)
	--	WHERE la.SPName = 'Acc_CustSetting_MaxPayoutUpd'
	--	AND
	--	ActionID  IN (220000,220001,220002,220003,220004,220005,220006)

	--END


	--IF NOT EXISTS (SELECT 1 FROM LogActionDetail la WITH (NOLOCK) WHERE Actionid  IN (220044,220045,220046,220047,220048,220049,220050))
	--BEGIN	
	--	INSERT INTO LogActionDetail (ActionID, ProductID, Level)
	--		SELECT 220044 , 1 , 4
	--	UNION SELECT 220045 , 1 , 4
	--	UNION SELECT 220046 , 1 , 3
	--	UNION SELECT 220047 , 1 , 3
	--	UNION SELECT 220048 , 1 , 2
	--	UNION SELECT 220049 , 1 , 2
	--	UNION SELECT 220050 , 1 , 1
	--END
	