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
