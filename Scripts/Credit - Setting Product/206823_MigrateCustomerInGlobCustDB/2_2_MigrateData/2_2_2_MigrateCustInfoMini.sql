/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Credit Customer in GlobCustDB - Migrate data CustInfoMini [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

------ info for deployer
DECLARE @StartRow		INT 
	, @StopRow		INT 
	, @MaxRow		INT	-- Keep the total row of your data
	, @Threshold	INT  -- the number of each batch
		
DECLARE @debug_message VARCHAR(500)
SET @Threshold		= 4000

SET @MaxRow			= xxx	-- As Min CustID From CustInfoMini From "Script 2_2_1_GetMin_CustID_SubAccID"

IF @Threshold >= @MaxRow
	SET @Threshold = @MaxRow

-- SET for first batch
SELECT @StartRow = 1, @StopRow = @Threshold

WHILE (@MaxRow IS NOT NULL)
BEGIN
	
		PRINT @StartRow
		PRINT @StopRow
		
		-- YOUR CODE PROCESS FOR DATA FROM @StartRow & @StopRow
		INSERT INTO dbo.CustInfoMini
		(
			CustID
		    , username
		    , username2
		    , recommend
		    , mrecommend
		    , srecommend
		    , roleid
		    , Site
		    , Currency
		)
		SELECT
			CustID
		    , username
		    , username2
		    , recommend
		    , mrecommend
		    , srecommend
		    , roleid
		    , Site
		    , currency
		FROM dbo.Customer c WITH (NOLOCK)
		WHERE c.custid BETWEEN @StartRow AND @StopRow

		SET @debug_message = CONVERT(VARCHAR(50), GETDATE(), 121)			
		RAISERROR (@debug_message, 0, 1) WITH NOWAIT
		
		IF @StopRow = @MaxRow BREAK

		WAITFOR DELAY '00:00:00.100' --optional

		SET @StartRow = @StopRow + 1
		SET @StopRow = @StopRow + @Threshold
		IF @StopRow >= @MaxRow
			SET @StopRow = @MaxRow
END
