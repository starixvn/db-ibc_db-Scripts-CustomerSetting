/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: 20250728@Elodie
	Task: Alpha - Toast message for manual deposit and withdrawal [Redmine: #233481]
	DB: DBMSG/bodb_Message
*/
USE bodb_Message
GO

IF EXISTS (SELECT TOP 1 1
	FROM ToastSiteFunction WITH (NOLOCK)
	WHERE SiteFunctionId = 5
)
BEGIN
	RAISERROR('SiteFunctionId has already been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO ToastSiteFunction(SiteFunctionId, SiteFunctionName, SiteFunctionDesc)
	SELECT 5, 'Age_ManualDepositWithdrawal', 'Alpha manual deposit and withdrawal'
END
