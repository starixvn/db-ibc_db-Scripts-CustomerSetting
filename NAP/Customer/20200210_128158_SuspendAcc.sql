/*
	Created: 20200210@Elodie
	Task: Suspend customer
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @CustId INT, @UserID INT, @IP VARCHAR(15), @ErrCode INT = 0, @ErrMsg NVARCHAR(500) = ''
SELECT	@UserID = 10278938,
		@IP = '127.0.0.1'

CREATE TABLE #CustList (CustId INT, username NVARCHAR(50), IsFishished BIT DEFAULT (0))

INSERT INTO #CustList (CustId, username)
SELECT CustId, username
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username IN ('FNG','FNU','S6BP','S69E','S69H','S69NT','S69R','S69RM ','paultb','6666HK','6666BP','6666EU','6hk6601',
						'MACAPAUL','M6SD','S6EU ','S6US','M6RM','6666AHK','MPH','JPG','S6H','S6BP','s6cn','N8E','S9EU','M6M',
						'S6P','S6AHK')

WHILE (1=1)
BEGIN
	UPDATE TOP (1) #CustList
	SET @CustId = CustId,
		IsFishished = 1
	WHERE IsFishished = 0

	IF @@ROWCOUNT = 0
		BREAK

	EXEC Acc_CustomerUpdSuspended
		@CustID = @CustId,
		@Suspended = 1,
		@UserID = @UserID,
		@IP = @IP,
		@ErrCode = @ErrCode,
		@ErrMsg = @ErrMsg
END