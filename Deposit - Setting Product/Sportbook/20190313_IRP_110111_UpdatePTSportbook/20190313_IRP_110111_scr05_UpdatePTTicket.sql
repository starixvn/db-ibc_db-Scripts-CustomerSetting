/*
	Created: Elodie
	Task: Update PT settings of SB for licensees [RedmineID: #110111]
	DB: DBCUST/CustDB
	Date: 20190313
*/ 

ALTER PROCEDURE [dbo].NAP_Admin_Calculate_10
	@TransIdList VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('bettrans') = 0 RETURN
	IF dbo.f_CheckRepTable('tranlog') = 0 RETURN
	
	CREATE TABLE #tmpList (ID INT IDENTITY (1,1) PRIMARY KEY, TransId INT)
	DECLARE @StartRow INT, @StopRow	INT, @MaxRow INT, @Threshold INT
				
	SET @StartRow = 1
	SET @Threshold = 4000
		
	IF EXISTS(SELECT 1 FROM #tmpList)
	BEGIN
			
		SET @MaxRow = (SELECT MAX(ID) FROM #tmpList)
			
		IF	@Threshold >= @MaxRow
		SET	@Threshold = @MaxRow
			
		SET @StopRow = @Threshold

		WHILE (0 = 0)
		BEGIN			
			UPDATE b
			SET b.spositiontaking=@PT,
				b.mpositiontaking=@PT,
				b.apositiontaking=@PT
			FROM bettrans b WITH(ROWLOCK)
				INNER JOIN #tmpList t ON b.CustID=t.TransId		
			WHERE ID >= @StartRow AND ID <= @StopRow
		
			IF	@StopRow = @MaxRow 
				BREAK
						
			SET	@StartRow = @StopRow + 1
						
			SET	@StopRow = 1 + @StopRow + @Threshold
						
			IF	@StopRow >= @MaxRow
				SET	@StopRow = @MaxRow
										
		END;
	END;	
		
END	
