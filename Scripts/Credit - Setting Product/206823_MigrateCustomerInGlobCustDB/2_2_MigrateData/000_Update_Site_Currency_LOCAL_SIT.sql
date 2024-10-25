/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Update Site , Currency  [#206823]   
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

DECLARE @StartRow		INT 
	, @StopRow		INT 
	, @MinRow		INT
	, @MaxRow		INT	-- Keep the total row of your data
	, @Threshold	INT   -- the number of each batch


DECLARE @debug_message VARCHAR(500)
SET @Threshold		= 4000


---- Update Site/Currency For Member from Agent
IF EXISTS (SELECT TOP 1 1 FROM CustInfoMini WITH (NOLOCK) WHERE roleid = 1 AND Site IS NULL)
BEGIN	
	SET @MinRow			= (SELECT MIN(cim.CustID) FROM CustInfoMini cim WITH (NOLOCK) WHERE Site IS NULL AND Roleid = 1)
	SET @MaxRow			= (SELECT MAX(cim.CustID) FROM CustInfoMini cim WITH (NOLOCK) WHERE Site IS NULL AND Roleid = 1)

	-- Result MaxCustID Need Update
	SELECT	@MinRow AS Min_CustID_Member , @MaxRow AS Max_CustID_Member

	IF @Threshold >= @MaxRow
		SET @Threshold = @MaxRow
	
	SELECT @StartRow = @MinRow, @StopRow = @MinRow + @Threshold

	WHILE (@MaxRow IS NOT NULL)
	BEGIN
		PRINT @StartRow
		PRINT @StopRow

		
		-- YOUR CODE PROCESS FOR DATA FROM @StartRow & @StopRow
		UPDATE ci
			SET 
				ci.Site	= c.site
			,	ci.Currency = c.currency 
			,	ci.RepUpdateTime = SYSDATETIME ()
		FROM CustInfoMini ci WITH (ROWLOCK ,UPDLOCK) 
		LEFT JOIN dbo.Customer c WITH (NOLOCK) ON ci.recommend = c.custid
		WHERE ci.roleid = 1
		AND ci.site IS NULL
		AND ci.custid BETWEEN @StartRow AND @StopRow

		SET @debug_message = CONVERT(VARCHAR(50), GETDATE(), 121)			
		RAISERROR (@debug_message, 0, 1) WITH NOWAIT
		
		IF @StopRow = @MaxRow BREAK

		WAITFOR DELAY '00:00:00.100' --optional

		SET @StartRow = @StopRow + 1
		SET @StopRow = @StopRow + @Threshold
		IF @StopRow >= @MaxRow
			SET @StopRow = @MaxRow

	END
END

SET @debug_message = 'Curdt End update Site/Currency For Member: ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT


 ----Update For SMA
IF EXISTS (SELECT TOP 1 1 FROM CustInfoMini WITH (NOLOCK) WHERE roleid IN (2,3,4) AND Site IS NULL)
BEGIN
	SET @Threshold		= 4000

	SET @MinRow			= (SELECT MIN(cim.CustID) FROM CustInfoMini cim WITH (NOLOCK) WHERE Site IS NULL AND Roleid IN (2,3,4))
	SET @MaxRow			= (SELECT MAX(cim.CustID) FROM CustInfoMini cim WITH (NOLOCK) WHERE Site IS NULL AND Roleid IN (2,3,4))

	-- Result MaxCustID Need Update
	SELECT	@MinRow AS Min_CustID_SMA , @MaxRow AS Max_CustID_SMA

	IF @Threshold >= @MaxRow
		SET @Threshold = @MaxRow
	
	SELECT @StartRow = @MinRow, @StopRow = @MinRow + @Threshold

	WHILE (@MaxRow IS NOT NULL)
	BEGIN
		PRINT @StartRow
		PRINT @StopRow

		
		-- YOUR CODE PROCESS FOR DATA FROM @StartRow & @StopRow
		UPDATE ci
			SET 
				ci.Site	= c.site
			,	ci.Currency = c.currency
			,	ci.RepUpdateTime = SYSDATETIME ()
		FROM CustInfoMini ci WITH (ROWLOCK ,UPDLOCK)
		INNER JOIN dbo.Customer c WITH (NOLOCK) ON ci.custid = c.custid
		WHERE ci.roleid IN (2,3,4)
		AND ci.site IS NULL
		AND ci.custid BETWEEN @StartRow AND @StopRow

		SET @debug_message = CONVERT(VARCHAR(50), GETDATE(), 121)			
		RAISERROR (@debug_message, 0, 1) WITH NOWAIT
		
		IF @StopRow = @MaxRow BREAK

		WAITFOR DELAY '00:00:00.100' --optional

		SET @StartRow = @StopRow + 1
		SET @StopRow = @StopRow + @Threshold
		IF @StopRow >= @MaxRow
			SET @StopRow = @MaxRow

	END
END
	
SET @debug_message = 'Curdt End update Site/Currency For SMA: ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT