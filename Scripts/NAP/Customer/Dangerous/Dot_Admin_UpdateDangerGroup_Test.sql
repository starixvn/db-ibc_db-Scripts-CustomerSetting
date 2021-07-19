
ALTER PROCEDURE [dbo].[Dot_Admin_UpdateDangerGroup_Test]
	@CustID			INT,
	@DangerType		TINYINT,
	@DangerGroup	TINYINT = 0,
	@UserID			INT,   -- will be cust id of admin server 
	@IP				VARCHAR(15) = '' -- will be IP of userId
AS
/*
	20200215@Singz(DBCUST): Create sp for updating danger group
*/		
BEGIN
	SET NOCOUNT ON
	DECLARE @oldvalue AS VARCHAR(10), @dangerfield AS VARCHAR(10)
	DECLARE @startRun DATETIME, @endRun DATETIME, @duration INT
    
	SET @startRun = GETDATE()

	IF (@DangerType=1)
	BEGIN
		SELECT @oldvalue= Danger FROM custInfo (NOLOCK) WHERE custid = @CustID
		SET @dangerfield='Danger'

		UPDATE custInfo with (UPDLOCK,ROWLOCK)
		SET Danger = @DangerGroup
		WHERE custid = @custid
	END
	ELSE IF @DangerType= 2
	BEGIN
		SELECT @oldvalue= Danger2 FROM custInfo (NOLOCK) WHERE custid = @CustID
		SET @dangerfield='Danger2'

		UPDATE custInfo with (UPDLOCK,ROWLOCK)
		SET Danger2 = @DangerGroup 
		WHERE custid = @custid
	END
	ELSE IF @DangerType= 3
	BEGIN
		SELECT @oldvalue= Danger3 FROM custInfo (NOLOCK) WHERE custid = @CustID
		SET @dangerfield='Danger3'

		UPDATE custInfo with (UPDLOCK,ROWLOCK)
		SET Danger3 = @DangerGroup 
		WHERE custid = @custid
	END

	
	/*--------wait VN TEAM give us the format ..how to write the log -----------*/	
	DECLARE @LogSPData VARCHAR(MAX), @LogSPData2 VARCHAR(MAX)

	Select @LogSPData = '<R ' + @dangerfield + 'Old="' + COALESCE(CAST(@oldvalue AS VARCHAR(50)),SPACE(1)) + '" ' 
						+ @dangerfield + '="'  + COALESCE(CAST(@DangerGroup AS VARCHAR(50)),SPACE(1)) + '" '
						+ 'IP="'+ COALESCE(CAST(@IP AS VARCHAR(15)),SPACE(1))+'" />'
	
	SET @endRun = GETDATE()
	SET @duration = DATEDIFF (millisecond,@startRun,@endRun)

	EXEC Acc_WriteLog_UserLog_RunSP_Wrapper
		@UserID = @UserID,
		@CustID = @CustID,
		@ActionID = 1174,
		@TrackingValue = @LogSPData,
		@duration = @duration
END

