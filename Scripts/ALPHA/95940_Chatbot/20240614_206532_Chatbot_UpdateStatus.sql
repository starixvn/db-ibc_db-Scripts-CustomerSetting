/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	CreatedDate: 20240614@Elodie
	Task: Update status and IsVerifyOTP
	DB: DBBOT/bodb_ChatBot
*/
USE bodb_ChatBot
GO

--UPDATE CustBotMessenger WITH (ROWLOCK, UPDLOCK)
--SET status = 0, IsVerifyOTP = 0
--WHERE ChatId = 1861969998

DECLARE @ErrCode INT = 0, @ErrMsg VARCHAR(1000) = ''

EXEC NAP_Chatbot_CustBotAccountInfoUpd
	@userid = 3445,
	@BotID = 5,
	@Status = 0,
	@IsVerifyOTP = 0,		
	@Creator = 10278938,
	@IP	= '125.227.140.97',
	@ErrCode = @ErrCode OUTPUT,
	@ErrMsg = @ErrMsg OUTPUT

	SELECT @ErrCode, @ErrMsg