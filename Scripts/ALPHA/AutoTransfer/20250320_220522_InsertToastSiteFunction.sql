/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: 20231108@Luke
	Task: Alpha - Enhance Auto Transfer function (Phase 2) [Redmine: #195135]
	DB: DBMSG/bodb_Message
*/
USE bodb_Message
GO

IF EXISTS (SELECT TOP 1 1
	FROM ToastSiteFunction WITH (NOLOCK)
	WHERE SiteFunctionId = 4
)
BEGIN
	RAISERROR('SiteFunctionId has already been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO ToastSiteFunction(SiteFunctionId, SiteFunctionName, SiteFunctionDesc)
	SELECT 4, 'Age_LoginDownlineFailureAlert', 'Alpha Downline Login Issue Alert'
END

SELECT * 
FROM ToastSiteFunction WITH (NOLOCK)
WHERE SiteFunctionId = 4

--DELETE FROM ToastSiteFunction WHERE SiteFunctionId = 4