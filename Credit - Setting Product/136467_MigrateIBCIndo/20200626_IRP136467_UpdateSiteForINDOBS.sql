/*
	Created: 20200626@Johnson
	Task: update site = 'IBCIndo' for INDOBS
	DB: DBCUST/CustDB
*/
--9043 rows affected
SELECT custid, 0 isFinished
INTO #Supers
FROM Acc_CustGroup WITH(NOLOCK)
where groupname = 'indobs'

DECLARE @custid INT, @ErrCode INT , @ErrMsg VARCHAR(200) 
DECLARE @Result TABLE (CustID INT, ErrCode INT, ErrMsg VARCHAR(200))

--update new site for INDOBS
WHILE(1=1)
BEGIN
	UPDATE TOP(1) s
	SET @custid = custid,
		isFinished = 1
	FROM #Supers s
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	EXEC Acc_CustomerUpdMoveSite
		@UserId	= 10278938, --StarixIT
		@CustId	= @custid,
		@Site	= 'IBCIndo',
		@ErrCode = @ErrCode OUTPUT,
		@ErrMsg	= @ErrMsg OUTPUT,
		@IP		= ''
	
	IF @ErrCode > 0
	BEGIN
		INSERT INTO @Result(custid,ErrCode,ErrMsg)
		SELECT @custid, @ErrCode, @ErrMsg
	END
	
	WAITFOR DELAY '0:0:0.28'	
END

SELECT * from @Result
