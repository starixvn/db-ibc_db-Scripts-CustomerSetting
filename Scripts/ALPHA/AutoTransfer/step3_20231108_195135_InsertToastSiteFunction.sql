/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: 20231108@Luke
	Task: Alpha - Enhance Auto Transfer function (Phase 2) [Redmine: #195135]
	DB: DBMSG/bodb_Message
*/

IF EXISTS (SELECT TOP 1 1
	FROM ToastSiteFunction WITH (NOLOCK)
	WHERE SiteFunctionId = 3
)
BEGIN
	RAISERROR('SiteFunctionId has already been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO ToastSiteFunction(SiteFunctionId, SiteFunctionName, SiteFunctionDesc)
	SELECT 3, 'Age_TransferCondition_Config', 'NAP/Ext/Alpha Update Transfer Condition Config'
END
